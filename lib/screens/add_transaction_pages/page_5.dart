import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';

class Page5 extends StatefulWidget {
  Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  bool isExpense = true;
  // TEMP value
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            'Today?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              //letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
