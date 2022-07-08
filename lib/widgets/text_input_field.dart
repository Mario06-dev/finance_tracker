import 'package:finance_tracker/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const TextFieldInput({
    Key? key,
    this.isPass = false,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
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
