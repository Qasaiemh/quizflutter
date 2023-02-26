import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.white,
        onPrimary: Colors.white,
      ),
      cardTheme: const CardTheme(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ),

        bodySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
        ),

      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
      ));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.transparent,
        onPrimary: Colors.transparent,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white54,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        titleSmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
        ),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white));
}
