import 'package:animate_icons/animate_icons.dart';
import 'package:finance_tracker/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/add_trans_provider.dart';

class Page6 extends StatefulWidget {
  Page6({Key? key}) : super(key: key);

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  bool isExpense = true;
  //late AnimateIconController _animateIconController;

/*   @override
  void initState() {
    _animateIconController = AnimateIconController();
    super.initState();
  } */

  /*  bool onEndIconPress(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("onEndIconPress called"),
        duration: Duration(seconds: 1),
      ),
    );
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("onStartIconPress called"),
        duration: Duration(seconds: 1),
      ),
    );
    return true;
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AddTransProvider>(context, listen: false).resetValues();
        print('Values Reset');
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
            /* AnimateIcons(
              controller: _animateIconController,
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              startIcon: Icons.done,
              endIcon: Icons.done_all,
              onEndIconPress: () => onEndIconPress(context),
              onStartIconPress: () => onStartIconPress(context),
            ), */
            Icon(
              Icons.done_all,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'Save Transaction',
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
