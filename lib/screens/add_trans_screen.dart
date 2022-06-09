import 'package:finance_tracker/screens/add_transaction_pages/page_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import 'add_transaction_pages/page_2.dart';
import 'add_transaction_pages/page_3.dart';

class AddTransScreen extends StatefulWidget {
  int selectedIndex;

  AddTransScreen(this.selectedIndex);

  @override
  State<AddTransScreen> createState() => _AddTransScreenState();
}

class _AddTransScreenState extends State<AddTransScreen> {
  late PageController pageController;
  //int _page = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
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
              Container(
                height: 500,

                //color: Colors.grey[300],
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: onPageChanged,
                  controller: pageController,
                  children: [
                    Page1(),
                    Page2(),
                    Page3(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
