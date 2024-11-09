import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
  ),
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.grey[800]!,
      onPrimary: Colors.white70,
      secondary: Colors.grey[900]!,
      onSecondary: Colors.white38,
      error: Colors.black,
      onError: Colors.black,
      surface: Colors.black,
      onSurface: Colors.black),
);
