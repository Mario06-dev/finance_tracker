import 'package:finance_tracker/resources/filtering_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../colors.dart';
import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../resources/db_service.dart';
import '../../widgets/charts/spendings_pie_chart.dart';

class SpendingsScreen extends StatefulWidget {
  const SpendingsScreen({Key? key}) : super(key: key);

  @override
  State<SpendingsScreen> createState() => _SpendingsScreenState();
}

class _SpendingsScreenState extends State<SpendingsScreen> {
  int? _filterTimeSegValue = 0;

  // Filtering Services
  FilteringMethods filtering = FilteringMethods();

  Widget buildSegment(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: index == _filterTimeSegValue ? Colors.white : Colors.black54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black54,
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          'Spendings',
          style: GoogleFonts.prompt(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: SlidingUpPanel(
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
                const Text(
                  'Spending',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Where does my money go?',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
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
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  //color: Colors.grey.withOpacity(0.1),
                  child: StreamBuilder<List<TransactionModel>>(
                    stream: DatabaseServices().getTransactionsStream(user!),
                    builder: (context, snapshot) {
                      // Print error if there is any
                      if (snapshot.hasError) {
                        print('An Error Occured!');
                        print(snapshot.error.toString());
                      }

                      if (snapshot.hasData) {
                        // Transactions filtered with timeFIlterSegment
                        final List<TransactionModel> transactions =
                            filtering.getFilteredTrans2(
                                snapshot.data!, _filterTimeSegValue!, 0);

                        return ExpensesChart(transactions);
                        //return Container(color: Colors.grey);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
