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
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFieldInput(
              controller: _amountController,
              hintText: 'Enter amount...',
              labelText: 'Amount',
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          const SizedBox(width: 100),
          GestureDetector(
            child: GestureDetector(
              onTap: () {
                if (_amountController.text.isNotEmpty) {
                  if (_amountController.text.contains(',')) {
                    _amountController.text =
                        _amountController.text.replaceAll(',', '.');
                    if ((double.tryParse(_amountController.text) != null)) {
                      // ACTIONS
                      Provider.of<AddTransProvider>(context, listen: false)
                          .setAmount(_amountController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    } else {
                      showSnackBar('Please enter real value', context);
                    }
                  } else {
                    if (_amountController.text.contains(',')) {
                      _amountController.text =
                          _amountController.text.replaceAll(',', '.');
                    }
                    if ((double.tryParse(_amountController.text) != null)) {
                      // ACTIONS
                      Provider.of<AddTransProvider>(context, listen: false)
                          .setAmount(_amountController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    } else {
                      showSnackBar('Please enter real value', context);
                    }
                  }
                } else {
                  showSnackBar('You must enter some value', context);
                }
              },
              child: const SmallActionButton(),
            ),
          ),
        ],
      ),
    );
  }
}
