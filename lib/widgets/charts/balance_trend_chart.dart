import 'package:finance_tracker/models/transaction_model.dart';
import 'package:finance_tracker/resources/stats_calc/balance_trend_calc.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceTrendChart extends StatefulWidget {
  final List<TransactionModel> transactions;
  final int timeFilter;

  const BalanceTrendChart(
      {Key? key, required this.transactions, required this.timeFilter})
      : super(key: key);

  @override
  State<BalanceTrendChart> createState() => _BalanceTrendChartState();
}

class _BalanceTrendChartState extends State<BalanceTrendChart> {
  @override
  Widget build(BuildContext context) {
    /* final List<SalesData> chartDataTest = [
      SalesData(widget.transactions[0].date, widget.transactions[0].amount),
      SalesData(widget.transactions[1].date, widget.transactions[1].amount),
      SalesData(widget.transactions[2].date, widget.transactions[2].amount),
      SalesData(widget.transactions[3].date, widget.transactions[3].amount),
      SalesData(widget.transactions[4].date, widget.transactions[4].amount),
    ]; */

    /* final List<BalanceTrendData> chartData =
        BalanceTrendCalc().getChartData(widget.transactions, widget.timeFilter); */

    final List<BalanceTrendData> chartData = [
      BalanceTrendData(100, DateTime.now()),
      BalanceTrendData(500, DateTime.utc(2022, 9, 2)),
      BalanceTrendData(1567, DateTime.utc(2022, 9, 1)),
      BalanceTrendData(300, DateTime.utc(2022, 8, 31)),
      BalanceTrendData(110.45, DateTime.utc(2022, 8, 30)),
      BalanceTrendData(-400, DateTime.utc(2022, 8, 29)),
      BalanceTrendData(-150, DateTime.utc(2022, 8, 28)),
    ];

    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              LineSeries<BalanceTrendData, DateTime>(
                dataSource: chartData,
                xValueMapper: (BalanceTrendData sales, _) => sales.date,
                yValueMapper: (BalanceTrendData sales, _) => sales.amount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceTrendData {
  final DateTime date;
  final double amount;
  BalanceTrendData(this.amount, this.date);
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
