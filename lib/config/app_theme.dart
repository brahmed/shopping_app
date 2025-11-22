import 'package:flutter/material.dart';
import '../config/colors.dart';

class AppTheme {
  /// App light theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: appPrimarySwatchColorLight,
      primaryColor: appPrimaryColorLight,
      scaffoldBackgroundColor: appBackgroundColorLight,
      colorScheme: ColorScheme.light(
        primary: appPrimaryColorLight,
        surface: appContainersBackgroundColorLight,
      ),
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
      scaffoldBackgroundColor: appBackgroundColorDark,
      colorScheme: ColorScheme.dark(
        primary: appContainersBackgroundColorDark,
        surface: appContainersBackgroundColorDark,
      ),
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
    bodyLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: appTextColorLight,
    ),
    displayLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: appTextColorLight,
    ),
    displayMedium: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: appTextColorLight,
    ),
    headlineMedium: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: appTextColorLight,
    ),
    titleLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: appTextColorLight,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: appTextColorDark,
    ),
    displayLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: appTextColorDark,
    ),
    displayMedium: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: appTextColorDark,
    ),
    headlineMedium: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: appTextColorDark,
    ),
    titleLarge: TextStyle(
      fontFamily: "OpenSans",
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: appTextColorDark,
    ),
  );
}
