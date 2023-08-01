import 'package:calc/bloc/calculating_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/monthly_payment.dart';
import '../services.dart/constant_strings.dart';

class ChartWidget extends StatelessWidget {
  final List<MonthlyPayment> payments;
  final bool isAnnuityLoan;
  final CalculatingService s = Get.find();
  ChartWidget({super.key, required this.payments, required this.isAnnuityLoan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.square,
                color: Constants.monthlyPaymentColor,
              ),
              Text(Constants.monthlyPaymentString)
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.square,
                color: Constants.principalPaymentColor,
              ),
              Text(Constants.principalPaymentString)
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.square,
                color: Constants.interestPaymentColor,
              ),
              Text(Constants.interestPaymentString)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: LineChart(LineChartData(
              lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          return LineTooltipItem(
                            " ${s.cutDigit(touchedSpot.y)}${Constants.rubString}",
                            TextStyle(color: touchedSpot.bar.color),
                          );
                        }).toList();
                      },
                      tooltipBgColor: Colors.white)),
              minX: 1,
              maxY: ((isAnnuityLoan
                      ? payments.last.monthlyPayment
                      : payments.first.monthlyPayment) *
                  1.4),
              titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                      axisNameWidget: Text(Constants.loanTermString)),
                  leftTitles: const AxisTitles(
                    axisNameWidget: Text(Constants.rubSumString),
                    axisNameSize: 50,
                    sideTitles: SideTitles(),
                  ),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                          reservedSize: 70,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max) {
                              return Container();
                            }
                            return Text(
                              "   ${value.toStringAsFixed(0)}",
                              style: Constants.subTitleTextStyle,
                            );
                          }))),
              lineBarsData: [
                LineChartBarData(
                    dotData: const FlDotData(show: false),
                    color: Constants.interestPaymentColor,
                    isCurved: true,
                    spots: [
                      ...payments
                          .map((payment) => FlSpot(
                              payment.month.toDouble(),
                              double.parse((payment.interestPayment.toDouble())
                                  .toStringAsFixed(2))))
                          .toList()
                    ]),
                LineChartBarData(
                    color: Constants.principalPaymentColor,
                    isCurved: true,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    spots: [
                      ...payments
                          .map((payment) => FlSpot(
                              payment.month.toDouble(),
                              double.parse((payment.principalPayment.toDouble())
                                  .toStringAsFixed(2))))
                          .toList()
                    ]),
                LineChartBarData(
                    color: Constants.monthlyPaymentColor,
                    isCurved: true,
                    dotData: const FlDotData(show: false),
                    spots: [
                      ...payments
                          .map((payment) => FlSpot(
                              payment.month.toDouble(),
                              double.parse((payment.monthlyPayment.toDouble())
                                  .toStringAsFixed(2))))
                          .toList()
                    ])
              ],
            )),
          ),
        ],
      ),
    );
  }
}
