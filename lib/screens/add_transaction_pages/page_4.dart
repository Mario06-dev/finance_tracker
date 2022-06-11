import 'package:finance_tracker/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/add_trans_provider.dart';
import '../../widgets/text_input_field.dart';

class Page4 extends StatefulWidget {
  final PageController pageController;

  Page4({Key? key, required this.pageController}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool isExpense = true;
  // TEMP value
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldInput(
            controller: _descriptionController,
            hintText: 'Enter description',
            labelText: 'Description',
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 60),
        GestureDetector(
          onTap: () {
            Provider.of<AddTransProvider>(context, listen: false)
                .setDescription(_descriptionController.text);
            FocusManager.instance.primaryFocus?.unfocus();
            widget.pageController.animateToPage(
              5,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          child: const SmallActionButton(),
        ),
      ],
    );
  }
}
