import 'package:finance_tracker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightModeTheme() {
  // Base theme mode to go with
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: GoogleFonts.rubikTextTheme().copyWith(
      titleLarge: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      labelMedium: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: const TextStyle(
        color: Colors.black45,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
    primaryColor: const Color(0xff5063EE),
    shadowColor: Colors.black.withOpacity(0.1),
    hintColor: Colors.black.withOpacity(0.7),
    scaffoldBackgroundColor: Colors.white,
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black54,
      textColor: Colors.black54,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
        //color: darkGreyBgColor,
        ),
  );
}

ThemeData darkModeTheme() {
  // Base theme mode to go with
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    textTheme: GoogleFonts.rubikTextTheme().copyWith(
      titleLarge: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      labelMedium: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
      bodySmall: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
    primaryColor: const Color(0xff5063EE),
    shadowColor: Colors.white.withOpacity(0.1),
    hintColor: Colors.white.withOpacity(0.7),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkGreyBgColor,
      foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: darkGreyBgColor,
    ),
  );
}
