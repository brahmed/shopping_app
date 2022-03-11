import 'package:flutter/material.dart';
import 'package:shopping_app/config/colors.dart';

class AppTheme {
  // App light theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor:  appBackgroundColorLight,
    );
  }

  // App dark theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: appPrimarySwatchDark,
      scaffoldBackgroundColor:  appBackgroundColorDark,
    );
  }
}