import 'package:finance_tracker/screens/add_transaction_pages/page_5.dart';
import 'package:finance_tracker/screens/add_transaction_pages/page_6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../providers/add_trans_provider.dart';
import 'add_transaction_pages/page_1.dart';
import 'add_transaction_pages/page_2.dart';
import 'add_transaction_pages/page_3.dart';
import 'add_transaction_pages/page_4.dart';

// ignore: must_be_immutable
class AddTransScreen extends StatefulWidget {
  int selectedIndex;

  AddTransScreen(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  State<AddTransScreen> createState() => _AddTransScreenState();
}

class _AddTransScreenState extends State<AddTransScreen> {
  late PageController pageController;
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
    final _provider = Provider.of<AddTransProvider>(context);

    bool isExpense = _provider.getisExpense;
    double amount = _provider.getAmount;
    String description = _provider.getDescription;
    DateTime date = _provider.getDate;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.xmark,
            size: 20,
            color: blackTextColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: bgColor,
        title: Text(
          'Add transaction',
          style: GoogleFonts.prompt(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
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
                  CustomItem(
                    leftTitle: 'Transaction type',
                    leftValue: isExpense ? 'Expense' : 'Income',
                    rightTitle: 'Amount',
                    rightValue: '${amount.toStringAsFixed(2)} kn',
                    icon: CupertinoIcons.arrowtriangle_down_fill,
                    isOptionOne: true,
                  ),
                  const SizedBox(height: 30),
                  CustomItem(
                    leftTitle: 'Category',
                    leftValue: '-',
                    rightTitle: 'Date',
                    rightValue: DateFormat.MMMd().format(date),
                    icon: Icons.category,
                    isOptionOne: false,
                  ),
                  const SizedBox(height: 30),
                  CustomItem(
                    isDoubleContent: false,
                    leftTitle: 'Transaction description',
                    leftValue: description,
                    icon: Icons.description,
                    isOptionOne: false,
                    isDescription: true,
                  ),
                  //Spacer(),
                  const SizedBox(height: 40),
                  const Text('Please follow the instructions down bellow'),
                  const SizedBox(height: 20),
                  Container(
                    height: 90,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 7), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PageView(
                      //physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      children: [
                        Page1(
                          pageController: pageController,
                        ),
                        Page2(
                          pageController: pageController,
                        ),
                        Page3(),
                        Page5(
                          pageController: pageController,
                        ),
                        Page4(
                          pageController: pageController,
                        ),
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

class CustomItem extends StatelessWidget {
  final bool isDoubleContent;
  final String leftTitle, rightTitle;
  final String leftValue, rightValue;
  final IconData icon;
  final bool isOptionOne;
  final bool isDescription;

  const CustomItem({
    Key? key,
    this.isDoubleContent = true,
    required this.leftTitle,
    required this.leftValue,
    required this.icon,
    required this.isOptionOne,
    this.isDescription = false,
    this.rightTitle = '',
    this.rightValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          //backgroundColor: isOptionOne ? Colors.redAccent : primaryColor,
          backgroundColor:
              isOptionOne || isDescription ? Colors.white : primaryColor,
          child: Icon(
            //isExpense ? Icons.arrow_downward : Icons.arrow_upward,
            isOptionOne
                ? leftValue == 'Expense'
                    ? CupertinoIcons.arrowtriangle_down_fill
                    : CupertinoIcons.arrowtriangle_up_fill
                : icon,
            //color: Colors.white,
            //color: isExpense ? Colors.redAccent : primaryColor,
            color: isOptionOne || isDescription
                ? leftValue == 'Expense'
                    ? Colors.red
                    : primaryColor
                : Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftTitle,
              style: const TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              leftValue,
              style: const TextStyle(
                color: blackTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        isDoubleContent
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rightTitle,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    rightValue,
                    style: const TextStyle(
                      color: blackTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Container(),
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
