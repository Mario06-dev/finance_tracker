import 'package:finance_tracker/screens/add_transaction_pages/page_5.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../widgets/small_action_button.dart';
import '../widgets/text_input_field.dart';
import 'add_transaction_pages/page_1.dart';
import 'add_transaction_pages/page_2.dart';
import 'add_transaction_pages/page_3.dart';
import 'add_transaction_pages/page_4.dart';

class AddTransScreen extends StatefulWidget {
  int selectedIndex;

  AddTransScreen(this.selectedIndex);

  @override
  State<AddTransScreen> createState() => _AddTransScreenState();
}

class _AddTransScreenState extends State<AddTransScreen> {
  late PageController pageController;
  final TextEditingController _amountController = TextEditingController();
  //int _page = 0;
  bool isExpense = true;

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
              ProgressBar(
                value: widget.selectedIndex,
              ),
              const SizedBox(height: 25),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            isExpense ? Colors.redAccent : primaryColor,
                        child: Icon(
                          isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Transaction type',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            isExpense ? 'Expense' : 'Income',
                            style: const TextStyle(
                              color: blackTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '40.45 kn',
                            style: TextStyle(
                              color: blackTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.category,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Category',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Life & Entertainment',
                            style: TextStyle(
                              color: blackTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '22 Mar 2022',
                            style: TextStyle(
                              color: blackTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Spacer(),
                  const SizedBox(height: 40),
                  const Text(
                      'Please follow the instructions down bellow (use Rrovider)'),
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
                        Page2(),
                        Page3(),
                        Page4(),
                        Page5(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedIndex == 0
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedIndex == 1
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedIndex == 2
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedIndex == 3
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedIndex == 4
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
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
  const CustomItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: primaryColor,
          child: Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Category',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Shopping',
              style: TextStyle(
                color: blackTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
              ? 0.3
              : value == 1
                  ? 0.5
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
