import 'package:finance_tracker/screens/add_trans_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/categories.dart';
import '../constants/colors.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../providers/add_trans_provider.dart';
import '../providers/user_provider.dart';
import '../resources/filtering_methods.dart';
import '../widgets/transaction_list_item.dart';

class IndividualRecordsScreen extends StatefulWidget {
  final String givenCategory;
  final List<TransactionModel> dbTransactions;

  const IndividualRecordsScreen(
      {Key? key, required this.givenCategory, required this.dbTransactions})
      : super(key: key);

  @override
  State<IndividualRecordsScreen> createState() =>
      _IndividualRecordsScreenState();
}

class _IndividualRecordsScreenState extends State<IndividualRecordsScreen> {
  // Filtering methods services
  FilteringMethods filtering = FilteringMethods();

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    // Add transaction provider instance
    AddTransProvider? addTransProvider = Provider.of<AddTransProvider>(context);

    List<TransactionModel> displayTransactions = widget.dbTransactions
        .where((trans) => trans.category == widget.givenCategory)
        .toList();

    // Editing transaction
    void transactionTapped(TransactionModel transaction) {
      // Provider
      addTransProvider.setAmount(transaction.amount.toString());
      addTransProvider.setCategory(categories
          .where((cat) => cat.title == transaction.category)
          .toList()
          .first);
      addTransProvider.setDate(transaction.date);
      addTransProvider.setDescription(transaction.description);
      addTransProvider.setisExpense(transaction.isExpense);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTransScreen(
                  selectedIndex: 0,
                  isEdit: true,
                  transId: transaction.transId,
                )),
      );
    }

    Widget _buildTransaction(
        TransactionModel transaction, DateTime dateBefore) {
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
          InkWell(
            onTap: () {
              transactionTapped(transaction);
            },
            child: TransListItem(transaction: transaction),
          ),
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
          InkWell(
            onTap: () {
              transactionTapped(transaction);
            },
            child: TransListItem(transaction: transaction),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Records',
          style: GoogleFonts.prompt(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: displayTransactions.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: displayTransactions.length,
                itemBuilder: (context, index) {
                  return index != 0
                      ? _buildTransaction(displayTransactions[index],
                          displayTransactions[index - 1].date)
                      : _buildFirstTransactions(displayTransactions[index]);
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/empty.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Nothing to show',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
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
