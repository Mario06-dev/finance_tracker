import 'package:finance_tracker/screens/stats_screens/reports_individual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/colors.dart';
import '../../constants/categories.dart';
import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../resources/db_service.dart';
import '../../resources/filtering_methods.dart';
import '../../resources/stats_calc/cash_flow_calc.dart';
import '../../resources/stats_calc/reports_calc.dart';
import '../../widgets/reports_bar.dart';

CashFlowCalc cashFlowCalc = CashFlowCalc();
ReportsCalc resportsCalc = ReportsCalc();

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int? _filterTimeSegValue = 0;

  // Filtering Services
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

  Widget buildGridItem(String title, bool isHeading, [bool isExpense = false]) {
    return isHeading
        ? Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  color: isExpense ? Colors.red : Theme.of(context).splashColor,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isExpense ? Colors.red : Colors.grey,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Reports',
          style: GoogleFonts.prompt(
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Income & Expenses',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 5),
                Text('Quick look at reports',
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,

                  //color: Colors.grey.withOpacity(0.1),
                  child: StreamBuilder<List<TransactionModel>>(
                    stream: DatabaseServices().getTransactionsStream(user!),
                    builder: (context, snapshot) {
                      // Print error if there is any
                      if (snapshot.hasError) {
                        print('An Error Occured!');
                        print(snapshot.error.toString());
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Transactions filtered with timeFIlterSegment
                      final List<TransactionModel> transactions =
                          filtering.getFilteredTrans2(
                              snapshot.data!, _filterTimeSegValue!, 0);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '${cashFlowCalc.cashFlowTotalCalc(
                                  transactions,
                                ).toStringAsFixed(2)} HRK ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: List.generate(
                              parentCategories.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReportsIndividual(
                                            parentCategories[index],
                                            transactions),
                                      ),
                                    );
                                  },
                                  child: ReportBar(
                                    color: catColors[index],
                                    title: parentCategories[index],
                                    //amount: 124.42,
                                    amount: resportsCalc
                                        .individualCategoryAmountCalc(
                                            transactions,
                                            parentCategories[index]),
                                    isHeading: false,
                                    isExpense:
                                        parentCategories[index] == 'Income'
                                            ? false
                                            : true,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cash Flow Table',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 5),
                                Text('Do I need any charts?',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildGridItem('QUICK OVERVIEW', true),
                                        buildGridItem('Count', false),
                                        buildGridItem('Avarage (Day)', false),
                                        buildGridItem(
                                            'Average (Record)', false),
                                        buildGridItem('Total', false),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildGridItem('INCOME', true),
                                        buildGridItem(
                                            resportsCalc
                                                .transactionCount(
                                                    transactions, false)
                                                .toString(),
                                            false),
                                        buildGridItem(
                                          resportsCalc
                                              .getAverageADay(
                                                  transactions, false)
                                              .toStringAsFixed(2),
                                          false,
                                          false,
                                        ),
                                        buildGridItem('--', false),
                                        buildGridItem(
                                            resportsCalc
                                                .getSumOfTransType(
                                                    transactions, false)
                                                .toStringAsFixed(2),
                                            false),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildGridItem('EXPENSES', true, true),
                                        buildGridItem(
                                            resportsCalc
                                                .transactionCount(
                                                    transactions, true)
                                                .toString(),
                                            false,
                                            true),
                                        buildGridItem(
                                          '- ${resportsCalc.getAverageADay(transactions, true).toStringAsFixed(2)}',
                                          false,
                                          true,
                                        ),
                                        buildGridItem('--', false, true),
                                        buildGridItem(
                                            '- ${resportsCalc.getSumOfTransType(transactions, true).toStringAsFixed(2)}',
                                            false,
                                            true),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 220),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
