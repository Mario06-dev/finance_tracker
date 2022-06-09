import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../widgets/small_action_button.dart';
import '../../widgets/text_input_field.dart';

class Page3 extends StatefulWidget {
  Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
    return Column(
      children: [
        Container(
          child: Row(
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
                      fontSize: 20,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //Spacer(),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFieldInput(
                controller: _amountController,
                hintText: 'Enter amount...',
                labelText: 'Amount',
                textInputType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 100),
            GestureDetector(
              child: SmallActionButton(),
            ),
          ],
        ),
      ],
    );
  }
}
