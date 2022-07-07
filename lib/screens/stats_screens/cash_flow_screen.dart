import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/colors.dart';
import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../resources/db_service.dart';
import '../../resources/filtering_methods.dart';
import '../../resources/stats_calc/cash_flow_calc.dart';

CashFlowCalc calcData = CashFlowCalc();

class CashFlowScreen extends StatefulWidget {
  const CashFlowScreen({Key? key}) : super(key: key);

  @override
  State<CashFlowScreen> createState() => _CashFlowScreenState();
}

class _CashFlowScreenState extends State<CashFlowScreen> {
  int? _filterTimeSegValue = 0;

  // Filtering methods services
  FilteringMethods filtering = FilteringMethods();

  Widget buildSegment(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: index == _filterTimeSegValue ? Colors.white : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        //foregroundColor: Colors.black54,
        elevation: 0,
        //backgroundColor: bgColor,
        title: Text(
          'Cash Flow',
          style: GoogleFonts.prompt(
            //color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: SlidingUpPanel(
        color: Theme.of(context).scaffoldBackgroundColor,
        minHeight: 100,
        isDraggable: false,
        panel: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 30,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: Colors.grey.withOpacity(0.1),
                thumbColor: primaryColor,
                padding: const EdgeInsets.all(8),
                groupValue: _filterTimeSegValue,
                children: {
                  0: buildSegment("7 days", 0),
                  1: buildSegment("30 days", 1),
                  2: buildSegment("12 weeks", 2),
                  3: buildSegment("6 months", 3),
                  4: buildSegment("1 year", 4),
                },
                onValueChanged: (value) {
                  setState(() {
                    _filterTimeSegValue = value;
                  });
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: StreamBuilder<List<TransactionModel>>(
            stream: DatabaseServices().getTransactionsStream(user!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('NO TRANSACTIONSs'),
                );
              }

              final List<TransactionModel> transactions =
                  filtering.getFilteredTrans2(
                snapshot.data!,
                _filterTimeSegValue!,
                0,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cash Flow',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 22)),
                  const SizedBox(height: 5),
                  Text('Am I spending less then I make?',
                      style: Theme.of(context).textTheme.titleSmall),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  Text(
                      _filterTimeSegValue == 0
                          ? 'LAST 7 DAYS'
                          : _filterTimeSegValue == 1
                              ? 'LAST 30 DAYS'
                              : _filterTimeSegValue == 2
                                  ? 'LAST 12 WEEKS'
                                  : _filterTimeSegValue == 3
                                      ? 'LAST 6 MONTHS'
                                      : 'LAST 1 YEAR',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 10),
                  Text(
                    '${calcData.cashFlowTotalCalc(transactions).toStringAsFixed(2)} HRK ',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  FlowBar(
                    calcData.cashFlowIndividualCalc(
                      transactions.where((element) {
                        return element.isExpense == false;
                      }).toList(),
                    ),
                    'Income',
                    transactions,
                    false,
                    _filterTimeSegValue!,
                  ),
                  const SizedBox(height: 25),
                  FlowBar(
                    calcData.cashFlowIndividualCalc(
                      transactions.where((element) {
                        return element.isExpense == true;
                      }).toList(),
                    ),
                    'Expenses',
                    transactions,
                    true,
                    _filterTimeSegValue!,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FlowBar extends StatelessWidget {
  double amount;
  final String title;
  List<TransactionModel> givenTrans;
  bool isExpenseBar;
  int timeFilter;

  FlowBar(this.amount, this.title, this.givenTrans, this.isExpenseBar,
      this.timeFilter);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${amount.toStringAsFixed(2)} HRK',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              //color: Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: LinearPercentIndicator(
              backgroundColor: Colors.grey.withOpacity(0.2),
              percent: calcData.cashFlowPercentCalc(givenTrans, isExpenseBar),
              lineHeight: 30,
              padding: const EdgeInsets.all(0),
              barRadius: const Radius.circular(10),
              progressColor:
                  isExpenseBar ? const Color(0xffc71716) : Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
