import 'package:finance_tracker/constants/colors.dart';
import 'package:flutter/material.dart';

class SmallActionButton extends StatelessWidget {
  const SmallActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 50,
      height: 50,
      child: Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
    );
  }
}
