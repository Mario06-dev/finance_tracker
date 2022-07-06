import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightModeTheme() {
  // Base theme mode to go with
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: GoogleFonts.rubikTextTheme(),
    primaryColor: const Color(0xff5063EE),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
  );
}

ThemeData darkModeTheme() {
  // Base theme mode to go with
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    textTheme: GoogleFonts.rubikTextTheme(),
    primaryColor: const Color(0xff5063EE),
    scaffoldBackgroundColor: Colors.black,
  );
}
