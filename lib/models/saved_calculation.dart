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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedCalculation &&
          payments == other.payments &&
          monthlyPayment == other.monthlyPayment &&
          isAnnuityPayment == other.isAnnuityPayment &&
          monthlyPayment == other.monthlyPayment &&
          totalInterestPayment == other.totalInterestPayment &&
          amount == other.amount &&
          interestRate == other.interestRate &&
          loanTerm == other.loanTerm &&
          time == other.time &&
          totalPayments == other.totalPayments;

  @override
  int get hashCode =>
      payments.hashCode ^
      monthlyPayment.hashCode ^
      isAnnuityPayment.hashCode ^
      monthlyPayment.hashCode ^
      totalInterestPayment.hashCode ^
      amount.hashCode ^
      interestRate.hashCode ^
      loanTerm.hashCode ^
      time.hashCode ^
      totalPayments.hashCode;
}
