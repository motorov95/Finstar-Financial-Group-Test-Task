import 'package:calc/services.dart/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc/calculating_bloc.dart';
import '../models/monthly_payment.dart';

class PaymentTableScreen extends StatelessWidget {
  final CalculatingService s = Get.find();

  PaymentTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.tablePaymentString)),
      body: ListView.builder(
        itemCount: s.payments.length,
        itemBuilder: (context, index) {
          MonthlyPayment payment = s.payments[index];
          return ListTile(
            title: Text("${Constants.monthStringTableScreen} ${payment.month}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${Constants.monthlyPaymentString} ${s.cutDigit(payment.monthlyPayment)}${Constants.rubString}"),
                Text(
                    "${Constants.principalPaymentString} ${s.cutDigit(payment.principalPayment)}${Constants.rubString}"),
                Text(
                    "${Constants.interestPaymentString} ${s.cutDigit(payment.interestPayment)}${Constants.rubString}"),
                Text(
                    "${Constants.remainPaymentString} ${s.cutDigit(payment.remainPayment)}${Constants.rubString}")
              ],
            ),
          );
        },
      ),
    );
  }
}
