import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../resources/stats_calc/spendings_pie_chart_calc.dart';

class ExpensesChart extends StatefulWidget {
  List<TransactionModel> transactions;

  ExpensesChart(this.transactions);

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  SpendingsChartCalc spendingsChartCalc = SpendingsChartCalc();

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }

                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;

                print('Index ' + touchedIndex.toString() + ' touched');
              });
            }),
            centerSpaceRadius: 80,
            sections: spendingsChartCalc.getSections(
                widget.transactions, touchedIndex),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                spendingsChartCalc.getClickedCategory(
                    widget.transactions, touchedIndex),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${spendingsChartCalc.getClickedSum(widget.transactions, touchedIndex).toStringAsFixed(2)} kn',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
