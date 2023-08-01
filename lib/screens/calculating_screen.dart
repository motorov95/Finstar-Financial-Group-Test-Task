import 'package:calc/bloc/calculating_bloc.dart';
import 'package:calc/services.dart/constant_strings.dart';
import 'package:calc/services.dart/fields_properties.dart';
import 'package:calc/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class CreditCalculatorScreen extends StatelessWidget {
  final CalculatingService s = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreditCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                s.resetAllFields();
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () =>
                  Get.toNamed("/historyScreen", arguments: 'Get is the best'),
              icon: const Icon(Icons.history))
        ],
        title: const Text(
          Constants.companyName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const Center(
                  child: Text(
                Constants.calculateCreditString,
                style: TextStyle(fontSize: 17),
              )),
              TextFormField(
                maxLength: s.giveMaxInputLength(fieldType: FieldType.amount),
                onChanged: (input) {
                  s.saveAmountField(input);
                },
                controller: s.amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    FieldsProprerties.fieldsInputDecoration(FieldType.amount),
                validator: (value) =>
                    s.validateForm(value, fieldType: FieldType.amount),
              ),
              TextFormField(
                  onChanged: (value) {
                    s.saveInterestRateField(value);
                  },
                  maxLength:
                      s.giveMaxInputLength(fieldType: FieldType.interestRate),
                  controller: s.interestRateController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        Constants.regExpForInterestRate)
                  ],
                  decoration: FieldsProprerties.fieldsInputDecoration(
                      FieldType.interestRate),
                  validator: (value) =>
                      s.validateForm(value, fieldType: FieldType.interestRate)),
              TextFormField(
                onChanged: (value) {
                  s.saveLoanTermField(value);
                },
                maxLength: s.giveMaxInputLength(fieldType: FieldType.loanTerm),
                controller: s.loanTermController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    FieldsProprerties.fieldsInputDecoration(FieldType.loanTerm),
                validator: (value) =>
                    s.validateForm(value, fieldType: FieldType.loanTerm),
              ),
              Obx(() => Column(
                    children: [
                      RadioListTile<bool>(
                          title: const Text(Constants.annualPaymentString),
                          value: true,
                          groupValue: s.isAnnuityLoan.value,
                          onChanged: (value) {
                            s.isCalculated.value = false;
                            s.isAnnuityLoan.value = value!;
                          }),
                      RadioListTile<bool>(
                          title: const Text(Constants.differPaymentString),
                          value: false,
                          groupValue: s.isAnnuityLoan.value,
                          onChanged: (value) {
                            s.isCalculated.value = false;
                            s.isAnnuityLoan.value = value!;
                          })
                    ],
                  )),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    s.isCalculated.value = true;
                    s.calculateLoan(isAnnuityLoan: s.isAnnuityLoan.value);
                  } else {
                    s.isCalculated.value = false;
                  }
                },
                child: const Text(Constants.calculateButtonString),
              ),
              Obx(() => !s.isCalculated.value
                  ? Container()
                  : ElevatedButton(
                      onPressed: () => Get.toNamed("tableScreen"),
                      child: const Text(Constants.goToTableButtonString))),
              const SizedBox(
                height: 20,
              ),
              Obx(() => !s.isCalculated.value
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        s.isAnnuityLoan.value
                            ? Text(
                                "${Constants.monthlyPaymentString}: ${s.cutDigit(s.monthlyPayment.value)}${Constants.rubString}")
                            : Container(),
                        Text(
                            "${Constants.totalPaymentsString} ${s.cutDigit(s.totalPayments.value)}${Constants.rubString}"),
                        Text(
                            "${Constants.totalInterestPaymentString} ${s.cutDigit(s.totalInterestPayment.value)}${Constants.rubString}"),
                      ],
                    )),
              const SizedBox(height: 30),
              Obx(() => s.isCalculated.value && s.payments.length > 1
                  ? ChartWidget(
                      payments: s.payments,
                      isAnnuityLoan: s.isAnnuityLoan.value,
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}
