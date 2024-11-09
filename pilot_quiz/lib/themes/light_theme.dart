import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.grey[200]!,
      onPrimary: Colors.black,
      secondary: Colors.grey[300]!,
      onSecondary: Colors.black45,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.grey[300]!,
      onSurface: Colors.black),
);
