import 'package:finance_tracker/utils/utils.dart';
import 'package:finance_tracker/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/add_trans_provider.dart';
import '../../widgets/text_input_field.dart';

class Page2 extends StatefulWidget {
  final PageController pageController;

  Page2({Key? key, required this.pageController}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
            hintText: 'Enter amount...',
            labelText: 'Amount',
            textInputType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 100),
        GestureDetector(
          child: GestureDetector(
            onTap: () {
              if (_amountController.text.isNotEmpty) {
                Provider.of<AddTransProvider>(context, listen: false)
                    .setAmount(_amountController.text);
                widget.pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              } else {
                showSnackBar('Please enter amount', context);
              }
            },
            child: const SmallActionButton(),
          ),
        ),
      ],
    );
  }
}
