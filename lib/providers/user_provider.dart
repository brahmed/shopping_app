import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/token_prefs_helpers.dart';

class UserProvider with ChangeNotifier {
  /// User Token
  String? currentUserToken;

  /// Current app locale
  Locale? currentLocale;

  /// Current App Theme Data
  bool isLightTheme = true;

  /// Is user logged
  bool isUserLogged = false;

  void loginUser() async {
    saveUserToken(userToken);
    currentUserToken = userToken;
    isUserLogged = true;
    notifyListeners();
  }

  void logoutUser() {
    isUserLogged = false;
    currentUserToken = null;
    deleteUserToken();
    notifyListeners();
  }

  /// Change the app Locale
  void changeLocale(Locale locale) {
    currentLocale = locale;
    notifyListeners();
  }

  /// Switch the app theme
  void switchThemeMode() {
    isLightTheme = !isLightTheme;
    notifyListeners();
  }
}
