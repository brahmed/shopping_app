import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/constants.dart';
import '../utils/token_prefs_helpers.dart';

// User State
class UserState {
  final String? currentUserToken;
  final Locale? currentLocale;
  final bool isLightTheme;
  final bool isUserLogged;

  const UserState({
    this.currentUserToken,
    this.currentLocale,
    this.isLightTheme = true,
    this.isUserLogged = false,
  });

  UserState copyWith({
    String? currentUserToken,
    Locale? currentLocale,
    bool? isLightTheme,
    bool? isUserLogged,
  }) {
    return UserState(
      currentUserToken: currentUserToken ?? this.currentUserToken,
      currentLocale: currentLocale ?? this.currentLocale,
      isLightTheme: isLightTheme ?? this.isLightTheme,
      isUserLogged: isUserLogged ?? this.isUserLogged,
    );
  }
}

// User Notifier
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  Future<void> loginUser() async {
    await saveUserToken(userToken);
    state = state.copyWith(
      currentUserToken: userToken,
      isUserLogged: true,
    );
  }

  Future<void> logoutUser() async {
    await deleteUserToken();
    state = state.copyWith(
      currentUserToken: null,
      isUserLogged: false,
    );
  }

  void changeLocale(Locale locale) {
    state = state.copyWith(currentLocale: locale);
  }

  void switchThemeMode() {
    state = state.copyWith(isLightTheme: !state.isLightTheme);
  }
}

// Provider
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
