import 'package:finance_tracker/constants/categories.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryPctBar extends StatefulWidget {
  String catName;
  double? catSum;
  dynamic topCatSum;

  CategoryPctBar(
      {required this.catName, required this.catSum, required this.topCatSum});

  @override
  State<CategoryPctBar> createState() => _CategoryPctBarState();
}

class _CategoryPctBarState extends State<CategoryPctBar> {
  double percent = 0;

  @override
  void initState() {
    percent = (widget.catSum)! / (widget.topCatSum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.catName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              widget.catSum!.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LinearPercentIndicator(
            backgroundColor: Colors.grey.withOpacity(0.2),
            //percent: calcData.cashFlowPercentCalc(givenTrans, isExpenseBar),
            percent: percent,
            lineHeight: 20,
            padding: const EdgeInsets.all(0),
            barRadius: const Radius.circular(10),
            progressColor: categories
                .where((cat) => cat.title == widget.catName)
                .toList()
                .first
                .color,
          ),
        ),
      ],
    );
  }
}
