class MonthlyPayment {
  final int month;
  final double monthlyPayment;
  final double interestPayment;
  final double principalPayment;
  final double remainPayment;

  MonthlyPayment(
      {required this.month,
      required this.monthlyPayment,
      required this.interestPayment,
      required this.principalPayment,
      required this.remainPayment});

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'monthlyPayment': monthlyPayment,
      'interestPayment': interestPayment,
      'principalPayment': principalPayment,
      'remainPayment': remainPayment,
    };
  }

  factory MonthlyPayment.fromJson(Map<String, dynamic> json) {
    return MonthlyPayment(
      month: json['month'],
      monthlyPayment: json['monthlyPayment'],
      interestPayment: json['interestPayment'],
      principalPayment: json['principalPayment'],
      remainPayment: json['remainPayment'],
    );
  }
}
