import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List actions = [];

  CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      //backgroundColor: bgColor,
      //backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(
        title,
        style: GoogleFonts.prompt(
          //color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
