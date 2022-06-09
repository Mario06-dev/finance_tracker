import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/screens/add_trans_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          'assets/images/add_trans_img.svg',
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        const Text(
          'What kind of transactions it is?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: TypeCard(isExpense: true),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AddTransScreen(1)));
              },
            ),
            GestureDetector(
              child: TypeCard(isExpense: false),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AddTransScreen(1)));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class TypeCard extends StatelessWidget {
  final bool isExpense;

  const TypeCard({Key? key, required this.isExpense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          //color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: isExpense ? Colors.redAccent : primaryColor,
              child: Icon(
                isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isExpense ? 'Expense' : 'Income',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
