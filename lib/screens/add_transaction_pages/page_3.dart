import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/screens/add_transaction_pages/choose_category_screen.dart';
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  PageController pageController;

  Page3({Key? key, required this.pageController}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChooseCategoryScreen()),
        );

        if (result != null) {
          widget.pageController.animateToPage(
            result,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.category,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'Click to choose category',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
