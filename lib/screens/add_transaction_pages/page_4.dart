import 'package:finance_tracker/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';

class Page4 extends StatefulWidget {
  Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
    return Row(
      children: [
        Expanded(
          child: TextFieldInput(
            controller: _amountController,
            hintText: 'Enter description',
            labelText: 'Description',
            textInputType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 60),
        GestureDetector(
          child: SmallActionButton(),
        ),
      ],
    );
  }
}
