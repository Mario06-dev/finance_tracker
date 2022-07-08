import 'package:finance_tracker/constants/categories.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/resources/firestore_methods.dart';
import 'package:finance_tracker/screens/add_transaction_pages/page_5.dart';
import 'package:finance_tracker/screens/add_transaction_pages/page_6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../models/transaction_model.dart';
import '../providers/add_trans_provider.dart';
import 'add_transaction_pages/page_1.dart';
import 'add_transaction_pages/page_2.dart';
import 'add_transaction_pages/page_3.dart';
import 'add_transaction_pages/page_4.dart';

late PageController pageController;

// ignore: must_be_immutable
class AddTransScreen extends StatefulWidget {
  int selectedIndex;
  bool isEdit;
  String transId;

  AddTransScreen({
    Key? key,
    required this.selectedIndex,
    this.isEdit = false,
    this.transId = '',
  }) : super(key: key);

  @override
  State<AddTransScreen> createState() => _AddTransScreenState();
}

class _AddTransScreenState extends State<AddTransScreen> {
  final TextEditingController _amountController = TextEditingController();
  //int _page = 0;
  //bool isExpense = true;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectedIndex);

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      widget.selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final addTransProvider = Provider.of<AddTransProvider>(context);
    final user = Provider.of<UserProvider>(context);

    bool isExpense = addTransProvider.getisExpense;
    double amount = addTransProvider.getAmount;
    String description = addTransProvider.getDescription;
    DateTime date = addTransProvider.getDate;

    void updateTransaction() {
      TransactionModel transaction = TransactionModel(
        transId: widget.transId,
        uid: user.getUser!.uid,
        isExpense: addTransProvider.getisExpense,
        amount: addTransProvider.getAmount,
        category: categories
            .where((cat) => cat.title == addTransProvider.getCategory.title)
            .toList()
            .first
            .title,
        date: addTransProvider.getDate,
        description: addTransProvider.getDescription,
      );

      FirestoreMethods().updateTransaction(transaction, user.getUser!.uid);
      Navigator.of(context).pop();
    }

    void deleteTransaction() {
      FirestoreMethods().deleteTransaction(widget.transId);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.xmark,
            size: 20,
            //color: blackTextColor,
          ),
        ),

        centerTitle: true,
        elevation: 0,
        //backgroundColor: bgColor,
        title: Text(
          'Add transaction',
          style: GoogleFonts.prompt(
            //color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          !widget.isEdit
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check, color: Colors.greenAccent),
                )
              : Container(),
          widget.isEdit
              ? IconButton(
                  onPressed: () {
                    deleteTransaction();
                  },
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                )
              : Container(),
          widget.isEdit
              ? IconButton(
                  onPressed: () {
                    updateTransaction();
                  },
                  icon: const Icon(Icons.update, color: Colors.blueAccent),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProgressBar(value: widget.selectedIndex),
              const SizedBox(height: 25),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        enableFeedback: false,
                        onTap: () {
                          pageController.jumpToPage(0);
                        },
                        child: AddValueFieldLeft(
                          isExpenseField: true,
                          icon: isExpense
                              ? CupertinoIcons.arrowtriangle_down_fill
                              : CupertinoIcons.arrowtriangle_up_fill,
                          title: 'Transaction type',
                          value: isExpense ? 'Expense' : 'Income',
                        ),
                      ),
                      InkWell(
                        enableFeedback: false,
                        onTap: () {
                          pageController.jumpToPage(1);
                        },
                        child: AddValueFieldRight(
                          title: 'Amount',
                          value: '${amount.toStringAsFixed(2)} kn',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        enableFeedback: false,
                        onTap: () {
                          pageController.jumpToPage(2);
                        },
                        child: AddValueFieldLeft(
                          icon: addTransProvider.getCategory.icon,
                          isAvatar: true,
                          title: 'Category',
                          value: addTransProvider.getCategory.title,
                        ),
                      ),
                      InkWell(
                        enableFeedback: false,
                        onTap: () {
                          pageController.jumpToPage(3);
                        },
                        child: AddValueFieldRight(
                          title: 'Date',
                          value: date.day == DateTime.now().day
                              ? 'Today'
                              : date.day == DateTime.now().day - 1
                                  ? 'Yesterday'
                                  : DateFormat.MMMd().format(date),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    enableFeedback: false,
                    onTap: () {
                      pageController.jumpToPage(4);
                    },
                    child: AddValueFieldLeft(
                      icon: Icons.description,
                      title: 'Description',
                      value: description,
                    ),
                  ),
                  //Spacer(),
                  const SizedBox(height: 40),
                  Text('Please follow the instructions down bellow',
                      style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      /* boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.1),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 7), // changes position of shadow
                        ),
                      ], */
                      //color: Theme.of(context).shadowColor,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      //physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      children: [
                        Page1(pageController: pageController),
                        Page2(pageController: pageController),
                        Page3(pageController: pageController),
                        Page5(pageController: pageController),
                        Page4(pageController: pageController),
                        Page6(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  DotsIndicator(selectedIndex: widget.selectedIndex),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddValueFieldRight extends StatelessWidget {
  final String title;
  final String value;

  const AddValueFieldRight({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}

class AddValueFieldLeft extends StatelessWidget {
  final bool isAvatar;
  final String title;
  final String value;
  final IconData icon;
  final bool isExpenseField;

  const AddValueFieldLeft({
    Key? key,
    this.isAvatar = false,
    required this.title,
    required this.value,
    required this.icon,
    this.isExpenseField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _provider = Provider.of<AddTransProvider>(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isAvatar
              ? Theme.of(context).shadowColor
              : Theme.of(context).scaffoldBackgroundColor,
          child: Icon(
            icon,
            color: isExpenseField
                ? value == 'Expense'
                    ? Colors.red
                    : Colors.greenAccent
                : isAvatar
                    ? Provider.of<AddTransProvider>(context).getCategory.color
                    : primaryColor,
            //color: isAvatar ? Colors.white : primaryColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int value;

  const ProgressBar({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        FractionallySizedBox(
          widthFactor: value == 0
              ? 0.167
              : value == 1
                  ? 0.333
                  : value == 2
                      ? 0.5
                      : value == 3
                          ? 0.667
                          : value == 4
                              ? 0.833
                              : 1,
          child: Container(
            color: primaryColor,
            height: 2,
            width: 70,
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int selectedIndex;

  const DotsIndicator({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 0 ? primaryColor : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 1 ? primaryColor : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 2 ? primaryColor : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 3 ? primaryColor : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 4 ? primaryColor : Colors.grey.shade400,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 5 ? primaryColor : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
