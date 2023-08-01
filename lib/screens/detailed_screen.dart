import 'package:calc/bloc/calculating_bloc.dart';
import 'package:calc/models/saved_calculation.dart';
import 'package:calc/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services.dart/constant_strings.dart';

class DetailedScreen extends StatelessWidget {
  final SavedCalculation savedCalculation;
  final CalculatingService s = Get.find();
  DetailedScreen({super.key, required this.savedCalculation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "${Constants.amountStringHistoryScreen} ${s.cutDigit(savedCalculation.amount)}${Constants.rubString}",
            ),
            Text(
                "${Constants.yearlyInterestRateString}: ${savedCalculation.interestRate}"),
            Text("${Constants.loanTermString}: ${savedCalculation.loanTerm}"),
            savedCalculation.isAnnuityPayment &&
                    savedCalculation.monthlyPayment != null
                ? Text(
                    "${Constants.monthlyPaymentString}: ${s.cutDigit(savedCalculation.monthlyPayment!)}${Constants.rubString}")
                : Container(),
            Text(
                "${Constants.totalPaymentsString} ${s.cutDigit(savedCalculation.totalPayments)}${Constants.rubString}"),
            Text(
                "${Constants.totalInterestPaymentString} ${s.cutDigit(savedCalculation.totalInterestPayment)}${Constants.rubString}"),
            const SizedBox(
              height: 30,
            ),
            savedCalculation.payments.length > 1
                ? ChartWidget(
                    payments: savedCalculation.payments,
                    isAnnuityLoan: s.isAnnuityLoan.value,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
