import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../charts/spendings_pie_chart.dart';

class ExpensesCard extends StatelessWidget {
  List<TransactionModel> dbTransactions;

  ExpensesCard(this.dbTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      /* decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expenses',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'LAST 30 DAYS',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: ExpensesChart(dbTransactions),
          ),
        ],
      ),
    );
  }
}
