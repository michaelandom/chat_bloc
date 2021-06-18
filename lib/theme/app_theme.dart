import 'package:flutter/material.dart';

enum AppTheme { light, dark }
final appThemeData = {
  AppTheme.light: ThemeData(
    primaryColor: Colors.blue.shade300,
    accentColor: Colors.pink.shade200,
    scaffoldBackgroundColor: Colors.black54,
    textTheme: TextTheme(
      headline5: TextStyle(color: Colors.pink.shade400),
    ),
  ),
  AppTheme.dark: ThemeData(
    primaryColor: Colors.blueGrey.shade500,
    accentColor: Colors.purple.shade400,
    scaffoldBackgroundColor: Colors.black54,
    textTheme: TextTheme(
      headline5: TextStyle(color: Colors.purple.shade400),
    ),
  ),
};
