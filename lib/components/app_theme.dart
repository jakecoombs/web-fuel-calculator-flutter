import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.red),
      colorScheme: ColorScheme.light(
          primary: Colors.white,
          onPrimary: Colors.grey[350],
          primaryVariant: Colors.black,
          secondary: Colors.red),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        headline5: TextStyle(color: Colors.red, fontSize: 20),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      unselectedWidgetColor: Colors.white,
      accentColor: Colors.grey[800]);

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(color: Colors.red[700]),
      colorScheme: ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.grey[800],
          primaryVariant: Colors.white,
          secondary: Colors.red[700]),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        headline5: TextStyle(color: Colors.red, fontSize: 20),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      unselectedWidgetColor: Colors.white,
      accentColor: Colors.white.withOpacity(0.7));
}
