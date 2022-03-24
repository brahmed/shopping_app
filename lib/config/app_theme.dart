import 'package:flutter/material.dart';
import 'package:shopping_app/config/colors.dart';

class AppTheme {
  /// App light theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: appPrimarySwatchColorLight,
      primaryColor: appPrimaryColorLight,
      backgroundColor: appContainersBackgroundColorLight,
      scaffoldBackgroundColor: appBackgroundColorLight,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: appBackgroundColorDark,
        backgroundColor: appBackgroundColorLight,
      ),
      textTheme: lightTextTheme,
      iconTheme: const IconThemeData(color: appIconColorLight),
    );
  }

  /// App dark theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: appPrimarySwatchColorDark,
      primaryColor: appContainersBackgroundColorDark,
      backgroundColor: appContainersBackgroundColorDark,
      scaffoldBackgroundColor: appBackgroundColorDark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: appBackgroundColorLight,
        backgroundColor: appBackgroundColorDark,
      ),
      textTheme: darkTextTheme,
      iconTheme: const IconThemeData(color: appIconColorDark),
    );
  }

  /// App Text Theme
  static TextTheme lightTextTheme = const TextTheme(
    bodyText1: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: appTextColorLight,
    ),
    headline1: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: appTextColorLight,
    ),
    headline2: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: appTextColorLight,
    ),
    headline3: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: appTextColorLight,
    ),
    headline6: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: appTextColorLight,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyText1: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: appTextColorDark,
    ),
    headline1: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: appTextColorDark,
    ),
    headline2: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: appTextColorDark,
    ),
    headline3: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: appTextColorDark,
    ),
    headline6: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: appTextColorDark,
    ),
  );
}
