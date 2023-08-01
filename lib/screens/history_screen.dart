import 'package:calc/bloc/calculating_bloc.dart';
import 'package:calc/services.dart/constant_strings.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'detailed_screen.dart';

class HistoryScreen extends StatelessWidget {
  final CalculatingService s = Get.find();
  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.calculationHistoryString),
        actions: [
          IconButton(
              onPressed: () => s.deleteHistory(),
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: s.savedCalculationList.length,
            itemBuilder: (context, index) {
              final savedCalculation =
                  s.savedCalculationList.reversed.toList()[index];
              return ListTile(
                onTap: () =>
                    Get.to(DetailedScreen(savedCalculation: savedCalculation)),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                  DateFormat(Constants.dateFormatRus)
                      .format(DateTime.parse(savedCalculation.time)),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Constants.amountStringHistoryScreen} ${s.cutDigit(savedCalculation.amount)}${Constants.rubString} ${Constants.interestRateStringHistoryScreen} ${savedCalculation.interestRate}%",
                      style: Constants.subTitleTextStyle,
                    ),
                    Text(
                      "${Constants.loanTermString}: ${savedCalculation.loanTerm}",
                      style: Constants.subTitleTextStyle,
                    ),
                    Text(
                      savedCalculation.isAnnuityPayment
                          ? Constants.annualPaymentString
                          : Constants.differPaymentString,
                      style: Constants.subTitleTextStyle,
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
