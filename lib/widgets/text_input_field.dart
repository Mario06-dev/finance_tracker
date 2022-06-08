import 'package:finance_tracker/colors.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;

  const TextFieldInput({
    Key? key,
    this.isPass = false,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: isPass ? true : false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: textColor,
        ),
        hintStyle: const TextStyle(
          color: textColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
