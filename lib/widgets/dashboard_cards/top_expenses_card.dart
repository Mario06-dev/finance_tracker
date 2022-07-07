import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../resources/stats_calc/categories_calc.dart';
import '../category_pct_bar.dart';

class TopExpensesCard extends StatelessWidget {
  List<TransactionModel> dbTransactions;

  TopExpensesCard(this.dbTransactions);

  // CategoriesCalc Service
  CategoriesCalc catCalc = CategoriesCalc();

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
            offset: const Offset(0, 0), // changes position of shadow
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
                'Top expenses',
                style: Theme.of(context).textTheme.titleLarge,
                /* style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ), */
              ),
              GestureDetector(
                onTap: () {
                  catCalc.getCatSumMap(dbTransactions);
                },
                child: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('LAST 30 DAYS', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            //height: 150,
            child: Column(
              children: List.generate(
                  catCalc.getCatSumMap(dbTransactions).length, (index) {
                return Column(
                  children: [
                    CategoryPctBar(
                      catName: catCalc
                          .getCatSumMap(dbTransactions)
                          .keys
                          .elementAt(index),
                      catSum: catCalc
                          .getCatSumMap(dbTransactions)
                          .values
                          .elementAt(index),
                      topCatSum: catCalc
                          .getCatSumMap(dbTransactions)
                          .values
                          .elementAt(0),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }),
              /* children: [
                CategoryPctBar(dbTransactions),
                SizedBox(height: 10),
                CategoryPctBar(dbTransactions),
                SizedBox(height: 10),
                CategoryPctBar(dbTransactions),
              ], */
            ),
          ),
        ],
      ),
    );
  }
}
