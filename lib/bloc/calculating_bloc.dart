import 'dart:convert';
import 'dart:math';
import 'package:calc/models/monthly_payment.dart';
import 'package:calc/services.dart/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/saved_calculation.dart';

enum FieldType { amount, interestRate, loanTerm }

class CalculatingService extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  final RxBool isAnnuityLoan = true.obs;
  final RxDouble _amount = 0.0.obs;
  final RxDouble _interestRate = 0.0.obs;
  final RxInt _loanTerm = 0.obs;
  final RxBool isCalculated = false.obs;
  final savedCalculationList = <SavedCalculation>[].obs;
  final RxDouble monthlyPayment = 0.0.obs;
  final RxDouble totalPayments = 0.0.obs;
  final RxDouble totalInterestPayment = 0.0.obs;
  List<MonthlyPayment> payments = [];
  GetStorage storage = GetStorage();

  void deleteHistory() {
    savedCalculationList.value = [];
    storage.write('savedCalculationList', "");
  }

  void resetAllFields() {
    isCalculated.value = false;
    amountController.text = "";
    interestRateController.text = "";
    loanTermController.text = "";
    saveAmountField("");
    saveInterestRateField("");
    saveLoanTermField("");
  }

  void _saveListToStorage(SavedCalculation savedCalculation) async {
    savedCalculationList.add(savedCalculation);
    final String jsonList = jsonEncode(savedCalculationList);
    await storage.write('savedCalculationList', jsonList);
  }

  List<SavedCalculation> _getListFromStorage() {
    final String jsonList = storage.read('savedCalculationList' as String);

    List<SavedCalculation> list = jsonList.isNotEmpty
        ? (jsonDecode(jsonList) as List)
            .map((data) =>
                SavedCalculation.fromJson(data as Map<String, dynamic>))
            .toList()
        : [];

    return list;
  }

  Future<CalculatingService> init() async {
    await storage.writeIfNull("savedCalculationList", "");
    await storage.writeIfNull("amount", "");
    await storage.writeIfNull("interestRate", "");
    await storage.writeIfNull("loanTerm", "");

    savedCalculationList.value = _getListFromStorage();
    amountController.text = await storage.read("amount");
    interestRateController.text = await storage.read("interestRate");
    loanTermController.text = await storage.read("loanTerm");

    return this;
  }

  void calculateLoan({required bool isAnnuityLoan}) {
    _amount.value = double.parse(amountController.text);
    _interestRate.value = double.parse(interestRateController.text);
    _loanTerm.value = int.parse(loanTermController.text);

    payments = isAnnuityLoan
        ? _calculateAnnuityPayments()
        : _calculateDifferentiatedPayments();
    _saveListToStorage(SavedCalculation(
        payments: payments,
        isAnnuityPayment: isAnnuityLoan,
        monthlyPayment: isAnnuityLoan ? monthlyPayment.value : null,
        totalInterestPayment: totalInterestPayment.value,
        amount: _amount.value,
        interestRate: _interestRate.value,
        loanTerm: _loanTerm.value,
        time: DateTime.now().toString(),
        totalPayments: totalPayments.value));
  }

  void saveAmountField(String text) {
    storage.write("amount", text);
  }

  void saveInterestRateField(String text) {
    storage.write("interestRate", text);
  }

  void saveLoanTermField(String text) {
    storage.write("loanTerm", text);
  }

  String? validateForm(String? input, {required FieldType fieldType}) {
    if (input == null) return null;
    if (input.isEmpty) return Constants.emptyFieldError;
    double number = double.parse(input);
    if (number == 0) return Constants.zeroFieldError;
    return _checkForOverValue(value: number, fieldType: fieldType);
  }

  String? _checkForOverValue(
      {required double value, required FieldType fieldType}) {
    switch (fieldType) {
      case FieldType.amount:
        return value > Constants.maxLoanAmount
            ? Constants.overAmountError
            : null;
      case FieldType.interestRate:
        return value > Constants.maxInterestRate
            ? Constants.overInterestRateError
            : null;
      case FieldType.loanTerm:
        return value > Constants.maxLoanTermMonths
            ? Constants.overLoanTermError
            : null;

      default:
        return null;
    }
  }

  String _makeSpaceNumber(num number) =>
      NumberFormat.decimalPattern("uk-UA").format(number);

  String cutDigit(num input) =>
      _makeSpaceNumber(double.parse(input.toStringAsFixed(2)));

  int giveMaxInputLength({required FieldType fieldType}) {
    switch (fieldType) {
      case FieldType.amount:
        return Constants.maxLoanAmount.toString().length;
      case FieldType.interestRate:
        return Constants.maxInterestRateFieldLength;
      case FieldType.loanTerm:
        return Constants.maxLoanTermMonths.toString().length;

      default:
        return 10;
    }
  }

  List<MonthlyPayment> _calculateAnnuityPayments() {
    List<MonthlyPayment> currentPayments = [];
    final double monthlyInterestRate = _interestRate / 100 / 12;
    final num powResult = pow(1 + monthlyInterestRate, _loanTerm.value);
    double remainPayment = _amount.value;
    monthlyPayment.value =
        _amount * (monthlyInterestRate * powResult) / (powResult - 1);
    totalPayments.value = monthlyPayment * _loanTerm.value;
    totalInterestPayment.value = totalPayments.value - _amount.value;

    for (int month = 1; month <= _loanTerm.value; month++) {
      double interestPayment = remainPayment * monthlyInterestRate;
      double principalPayment = monthlyPayment.value - interestPayment;
      remainPayment -= principalPayment;
      currentPayments.add(MonthlyPayment(
          month: month,
          monthlyPayment: monthlyPayment.value,
          interestPayment: interestPayment,
          principalPayment: principalPayment,
          remainPayment: remainPayment.abs()));
    }
    isCalculated.refresh();
    return currentPayments;
  }

  List<MonthlyPayment> _calculateDifferentiatedPayments() {
    final double monthlyInterestRate = _interestRate.value / 100 / 12;
    final double principalPayment = _amount / _loanTerm.value;
    final List<MonthlyPayment> currentPayments = [];
    double remainPayment = _amount.value;
    double currentTotalInterestPayment = 0;
    double currentTotalPayments = 0;

    for (int month = 1; month <= _loanTerm.value; month++) {
      double interestPayment = remainPayment * monthlyInterestRate;
      double monthlyPayment = principalPayment + interestPayment;
      currentTotalInterestPayment += interestPayment;
      currentTotalPayments += monthlyPayment;
      remainPayment -= principalPayment;
      currentPayments.add(MonthlyPayment(
          month: month,
          monthlyPayment: monthlyPayment,
          interestPayment: interestPayment,
          principalPayment: principalPayment,
          remainPayment: remainPayment.abs()));
    }
    totalPayments.value = currentTotalPayments;
    totalInterestPayment.value = currentTotalInterestPayment;

    isCalculated.refresh();
    return currentPayments;
  }
}
