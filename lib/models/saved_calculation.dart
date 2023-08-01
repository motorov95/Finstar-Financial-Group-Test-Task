import 'monthly_payment.dart';

class SavedCalculation {
  final List<MonthlyPayment> payments;
  final bool isAnnuityPayment;
  final double? monthlyPayment;
  final double totalInterestPayment;
  final double amount;
  final double interestRate;
  final int loanTerm;
  final String time;
  final double totalPayments;

  SavedCalculation(
      {required this.payments,
      required this.isAnnuityPayment,
      required this.monthlyPayment,
      required this.totalInterestPayment,
      required this.amount,
      required this.interestRate,
      required this.loanTerm,
      required this.time,
      required this.totalPayments});

  Map<String, dynamic> toJson() {
    return {
      'payments': payments.map((payment) => payment.toJson()).toList(),
      'isAnnuityPayment': isAnnuityPayment,
      'monthlyPayment': monthlyPayment,
      'totalInterestPayment': totalInterestPayment,
      'amount': amount,
      'interestRate': interestRate,
      'loanTerm': loanTerm,
      'totalPayments': totalPayments,
      'time': time.toString()
    };
  }

  factory SavedCalculation.fromJson(Map<String, dynamic> json) {
    return SavedCalculation(
        payments: List<MonthlyPayment>.from(json['payments']
            .map((payment) => MonthlyPayment.fromJson(payment))),
        isAnnuityPayment: json['isAnnuityPayment'],
        monthlyPayment: json['monthlyPayment'],
        totalInterestPayment: json['totalInterestPayment'],
        amount: json['amount'],
        interestRate: json['interestRate'],
        loanTerm: json['loanTerm'],
        time: json['time'],
        totalPayments: json['totalPayments']);
  }
}
