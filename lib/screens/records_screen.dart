import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/resources/db_service.dart';
import 'package:finance_tracker/resources/filtering_methods.dart';
import 'package:finance_tracker/widgets/transaction_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  /* ===================== VARIABLES  =====================*/

  // Filtering methods services
  FilteringMethods filtering = FilteringMethods();

  // Bool variable for controlling show of filters panel
  bool filtersExpanded = false;

  // Bool variable for controlling hsow of search box
  bool searchExpanded = false;

  // Segment Controll controll values
  int? filterTimeSegValue = 0;
  int? filterTypeSegValue = 0;

  // Used for filtering
  String searchWord = '';

  // Used for controlling search input text
  final TextEditingController _searchController = TextEditingController();

/* ===================== FUNCTIONS  =====================*/

  // Building function for time segment Contianer
  Widget buildSegmentTime(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: index == filterTimeSegValue ? Colors.white : Colors.grey,
      ),
    );
  }

  // Building function for type segment Contianer
  Widget buildSegmentType(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: index == filterTypeSegValue ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _buildTransaction(TransactionModel transaction, DateTime dateBefore) {
    // Current transaction date
    DateTime currentDate = transaction.date;

    // Previous transaction date
    DateTime previousDate = dateBefore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !(currentDate.day == previousDate.day)
            ? Column(
                children: [
                  //const SizedBox(height: 10),
                  DateDisplay(date: currentDate),
                ],
              )
            : Container(),
        TransListItem(transaction: transaction),
      ],
    );
  }

  Widget _buildFirstTransactions(TransactionModel transaction) {
    // Current transaction date
    DateTime currentDate = transaction.date;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateDisplay(date: currentDate),
        TransListItem(transaction: transaction),
      ],
    );
  }

  /* ===================== BUILD METHOD  =====================*/

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              filtersExpanded = !filtersExpanded;
            });
          },
          icon: Icon(
            filtersExpanded ? Icons.close : Icons.sort,
            size: 20,
            color: blackTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchExpanded = !searchExpanded;
              });
            },
            icon: Icon(
              !searchExpanded ? CupertinoIcons.search : Icons.close,
              size: 20,
              color: blackTextColor,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          'All transactions',
          style: GoogleFonts.prompt(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          filtersExpanded
              ? Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          thumbColor: primaryColor,
                          padding: const EdgeInsets.all(8),
                          groupValue: filterTimeSegValue,
                          children: {
                            0: buildSegmentTime("7 days", 0),
                            1: buildSegmentTime("30 days", 1),
                            2: buildSegmentTime("12 weeks", 2),
                            3: buildSegmentTime("6 months", 3),
                            4: buildSegmentTime("1 year", 4),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              filterTimeSegValue = value;
                            });
                          },
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          thumbColor: primaryColor,
                          padding: const EdgeInsets.all(8),
                          groupValue: filterTypeSegValue,
                          children: {
                            0: buildSegmentType("All", 0),
                            1: buildSegmentType("Income", 1),
                            2: buildSegmentType("Expenses", 2),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              filterTypeSegValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          searchExpanded
              ? Container(
                  width: double.infinity,
                  //height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.search,
                        color: Colors.black38,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          cursorColor: primaryColor,
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              searchWord = value;
                            });
                          },
                          style: const TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            //labelText: 'Search transactions ...',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchWord = '';
                            _searchController.text = '';
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black38,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder<List<TransactionModel>>(
                stream: DatabaseServices().getTransactionsStream(user!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('NO TRANSACTIONSs'),
                    );
                  }

                  List<TransactionModel> transactions =
                      filtering.getFilteredTrans2(
                    snapshot.data!,
                    filterTimeSegValue!,
                    filterTypeSegValue!,
                  );

                  transactions = transactions
                      .where((element) => element.description
                          .toLowerCase()
                          .contains(searchWord.toLowerCase()))
                      .toList();

                  // Sort transactions by date
                  transactions.sort((a, b) {
                    return b.date.compareTo(a.date);
                  });

                  if (transactions.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/empty.svg',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 30),
                        const Text('No transactions yet'),
                      ],
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return index != 0
                          ? _buildTransaction(
                              transactions[index], transactions[index - 1].date)
                          : _buildFirstTransactions(transactions[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  final DateTime date;

  const DateDisplay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 25),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(width: 20),
          Text(
            DateFormat.MMMMd('en_US').format(date),
            style: const TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
