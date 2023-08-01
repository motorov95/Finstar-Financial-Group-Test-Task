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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyPayment &&
          month == other.month &&
          monthlyPayment == other.monthlyPayment &&
          interestPayment == other.interestPayment &&
          principalPayment == other.principalPayment &&
          remainPayment == other.remainPayment;

  @override
  int get hashCode =>
      month.hashCode ^
      monthlyPayment.hashCode ^
      interestPayment.hashCode ^
      principalPayment.hashCode ^
      remainPayment.hashCode;
}
