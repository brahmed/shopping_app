import 'package:flutter/material.dart';

/// App Colors Set
class ColorsSet {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  static const gray = Color(0xFFD1D1D1);
  static const disabledGray = Color(0xFFF0F0F0);
  static const grayDark = Color(0xFF707070);
  static const grayLight = Color(0xFFC0C0C0);
  static const grayLighter = Color(0xFFF0F0F0);
  static const grayBackground = Color(0xFFF0F0F0);

  static const blue = Colors.blue;
  static const blueDark = Color(0xFF001b39);
  static const blueGrey = Color(0xFFDCE3EA);
  static const green = Color(0xFF6CBD29);

  static const purpleBlueDark = Color(0xFF1C0C5B);
  static const purpleBlue = Color(0xFF3D2C8D);
  static const purpleBlueLight = Color(0xFF916BBF);
  static const purpleBlueLighter = Color(0xFFC996CC);

  static const crimsonRed = Color(0xFFB80F0A);
  static const scarletRed = Color(0xFFFF2400);
  static const pink = Colors.pink;
  static const orange = Color(0xFFFF7417);

  static const MaterialColor blueMaterialSwatch =
      MaterialColor(0xFF001b39, _blueSwatchColor);
  static const Map<int, Color> _blueSwatchColor = {
    50: Color.fromRGBO(0, 27, 57, .1),
    100: Color.fromRGBO(0, 27, 57, .2),
    200: Color.fromRGBO(0, 27, 57, .3),
    300: Color.fromRGBO(0, 27, 57, .4),
    400: Color.fromRGBO(0, 27, 57, .5),
    500: Color.fromRGBO(0, 27, 57, .6),
    600: Color.fromRGBO(0, 27, 57, .7),
    700: Color.fromRGBO(0, 27, 57, .8),
    800: Color.fromRGBO(0, 27, 57, .9),
    900: Color.fromRGBO(0, 27, 57, 1),
  };
}

/// App Primary Color
const appPrimaryColorLight = ColorsSet.pink;
const appPrimaryColorDark = ColorsSet.purpleBlue;

/// App Background colors
const appBackgroundColorLight = ColorsSet.grayBackground;
const appBackgroundColorDark = ColorsSet.blueMaterialSwatch;

/// App Containers background color
const appContainersBackgroundColorLight = ColorsSet.white;
const appContainersBackgroundColorDark = ColorsSet.purpleBlue;

/// App Swatch Color
const appPrimarySwatchColorLight = ColorsSet.pink;
const appPrimarySwatchColorDark = ColorsSet.blue;

/// App Text colors
const appTextColorLight = ColorsSet.black;
const appTextColorDark = ColorsSet.white;

/// Icons Background color
const appIconColorLight = ColorsSet.pink;
const appIconColorDark = ColorsSet.purpleBlueLighter;

/// App Shadow Color
const appShadowColor = ColorsSet.grayDark;
