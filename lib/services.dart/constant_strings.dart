import 'package:flutter/material.dart';

class Constants {
  static const maxLoanAmount = 10000000;
  static const maxInterestRate = 60;
  static const maxLoanTermMonths = 24;
  static const emptyFieldError = "Поле не может быть пустым!";
  static const zeroFieldError = "Поле не может содержать 0!";
  static const overAmountError =
      "Сумма кредита не может быть больше $maxLoanAmount рублей!";
  static const overInterestRateError =
      "Годовая процентная ставка не может быть больше $maxInterestRate%!";
  static const overLoanTermError =
      "Срок кредита не может быть больше $maxLoanTermMonths месяцев!";
  static const companyName = 'Finstar Financial Company';
  static const calculateCreditString = "Рассчитать кредит";
  static const loanAmountString = "Сумма кредита (руб.)";
  static final regExpForInterestRate = RegExp(r'^\d+\.?\d{0,2}');
  static const yearlyInterestRateString = "Годовая процентная ставка (%)";
  static const loanTermString = "Cрок кредита (месяцы)";
  static const annualPaymentString = "Аннуитетный платеж";
  static const differPaymentString = "Дифференцированный платеж";
  static const calculateButtonString = "Рассчитать";
  static const goToTableButtonString = "Посмотреть расчет в таблице";
  static const monthlyPaymentString = "Ежемесячный платеж";
  static const remainPaymentString = "Остаток после платежа";
  static const totalPaymentsString = "Общая сумма платежа:";
  static const totalInterestPaymentString = "Переплата по процентам:";
  static const rubSumString = "Сумма, руб";
  static const principalPaymentString = "Оплата суммы займа";
  static const interestPaymentString = "Оплата процентов";
  static const rubString = " руб.";
  static const maxInterestRateFieldLength = 5;
  static const calculationHistoryString = "История расчетов";
  static const dateFormatRus = "dd.MM.yyyy HH:mm";
  static const amountStringHistoryScreen = "Сумма:";
  static const interestRateStringHistoryScreen = "Ставка:";
  static const paymentStringHistoryScreen = "Платеж:";
  static const subTitleTextStyle = TextStyle(fontSize: 12);
  static const monthlyPaymentColor = Colors.green;
  static const principalPaymentColor = Colors.blue;
  static const interestPaymentColor = Colors.red;
  static const tablePaymentString = "Таблица платежей";
  static const monthStringTableScreen = "Месяц";
  static const maxErrorLines = 2;
}
