import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/user_provider_riverpod.dart';

void main() {
  group('UserProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(userProvider);

        expect(state.currentUserToken, isNull);
        expect(state.currentLocale, isNull);
        expect(state.isLightTheme, true);
        expect(state.isUserLogged, false);
      });

      test('should create UserState with default values', () {
        const state = UserState();

        expect(state.currentUserToken, isNull);
        expect(state.currentLocale, isNull);
        expect(state.isLightTheme, true);
        expect(state.isUserLogged, false);
      });
    });

    group('Login User', () {
      test('should login user and update state', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.loginUser();

        final state = container.read(userProvider);
        expect(state.currentUserToken, isNotNull);
        expect(state.isUserLogged, true);
      });

      test('should save user token to preferences', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.loginUser();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('userToken'), isNotNull);
      });
    });

    group('Logout User', () {
      test('should logout user and clear state', () async {
        final notifier = container.read(userProvider.notifier);

        // First login
        await notifier.loginUser();
        expect(container.read(userProvider).isUserLogged, true);

        // Then logout
        await notifier.logoutUser();

        final state = container.read(userProvider);
        expect(state.currentUserToken, isNull);
        expect(state.isUserLogged, false);
      });

      test('should remove token from preferences', () async {
        final notifier = container.read(userProvider.notifier);

        // First login
        await notifier.loginUser();

        // Then logout
        await notifier.logoutUser();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('userToken'), isNull);
      });
    });

    group('Change Locale', () {
      test('should change locale to Spanish', () {
        final notifier = container.read(userProvider.notifier);
        const newLocale = Locale('es', 'ES');

        notifier.changeLocale(newLocale);

        final state = container.read(userProvider);
        expect(state.currentLocale, newLocale);
        expect(state.currentLocale?.languageCode, 'es');
        expect(state.currentLocale?.countryCode, 'ES');
      });

      test('should change locale to French', () {
        final notifier = container.read(userProvider.notifier);
        const newLocale = Locale('fr', 'FR');

        notifier.changeLocale(newLocale);

        final state = container.read(userProvider);
        expect(state.currentLocale, newLocale);
        expect(state.currentLocale?.languageCode, 'fr');
      });

      test('should update locale multiple times', () {
        final notifier = container.read(userProvider.notifier);

        notifier.changeLocale(const Locale('es', 'ES'));
        expect(container.read(userProvider).currentLocale?.languageCode, 'es');

        notifier.changeLocale(const Locale('fr', 'FR'));
        expect(container.read(userProvider).currentLocale?.languageCode, 'fr');

        notifier.changeLocale(const Locale('en', 'US'));
        expect(container.read(userProvider).currentLocale?.languageCode, 'en');
      });
    });

    group('Switch Theme Mode', () {
      test('should switch from light to dark theme', () {
        final notifier = container.read(userProvider.notifier);

        expect(container.read(userProvider).isLightTheme, true);

        notifier.switchThemeMode();

        expect(container.read(userProvider).isLightTheme, false);
      });

      test('should switch from dark to light theme', () {
        final notifier = container.read(userProvider.notifier);

        // First switch to dark
        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, false);

        // Then switch back to light
        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, true);
      });

      test('should toggle theme multiple times', () {
        final notifier = container.read(userProvider.notifier);

        expect(container.read(userProvider).isLightTheme, true);

        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, false);

        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, true);

        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, false);
      });
    });

    group('UserState copyWith', () {
      test('should copy with new user token', () {
        const original = UserState();
        final copied = original.copyWith(currentUserToken: 'new_token');

        expect(copied.currentUserToken, 'new_token');
        expect(copied.isLightTheme, true);
        expect(copied.isUserLogged, false);
      });

      test('should copy with new locale', () {
        const original = UserState();
        const newLocale = Locale('es', 'ES');
        final copied = original.copyWith(currentLocale: newLocale);

        expect(copied.currentLocale, newLocale);
        expect(copied.isLightTheme, true);
        expect(copied.isUserLogged, false);
      });

      test('should copy with new theme', () {
        const original = UserState(isLightTheme: true);
        final copied = original.copyWith(isLightTheme: false);

        expect(copied.isLightTheme, false);
        expect(copied.currentUserToken, isNull);
      });

      test('should copy with new logged status', () {
        const original = UserState();
        final copied = original.copyWith(isUserLogged: true);

        expect(copied.isUserLogged, true);
        expect(copied.currentUserToken, isNull);
      });

      test('should copy with all properties', () {
        const original = UserState();
        const newLocale = Locale('fr', 'FR');
        final copied = original.copyWith(
          currentUserToken: 'token123',
          currentLocale: newLocale,
          isLightTheme: false,
          isUserLogged: true,
        );

        expect(copied.currentUserToken, 'token123');
        expect(copied.currentLocale, newLocale);
        expect(copied.isLightTheme, false);
        expect(copied.isUserLogged, true);
      });
    });

    group('Combined Operations', () {
      test('should login and change locale', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.loginUser();
        notifier.changeLocale(const Locale('es', 'ES'));

        final state = container.read(userProvider);
        expect(state.isUserLogged, true);
        expect(state.currentLocale?.languageCode, 'es');
      });

      test('should login and switch theme', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.loginUser();
        notifier.switchThemeMode();

        final state = container.read(userProvider);
        expect(state.isUserLogged, true);
        expect(state.isLightTheme, false);
      });

      test('should perform all operations in sequence', () async {
        final notifier = container.read(userProvider.notifier);

        // Login
        await notifier.loginUser();
        expect(container.read(userProvider).isUserLogged, true);

        // Change locale
        notifier.changeLocale(const Locale('fr', 'FR'));
        expect(container.read(userProvider).currentLocale?.languageCode, 'fr');

        // Switch theme
        notifier.switchThemeMode();
        expect(container.read(userProvider).isLightTheme, false);

        // Logout
        await notifier.logoutUser();
        final state = container.read(userProvider);
        expect(state.isUserLogged, false);
        expect(state.currentLocale?.languageCode, 'fr'); // Locale persists
        expect(state.isLightTheme, false); // Theme persists
      });
    });

    group('Edge Cases', () {
      test('should handle multiple login calls', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.loginUser();
        await notifier.loginUser();
        await notifier.loginUser();

        final state = container.read(userProvider);
        expect(state.isUserLogged, true);
      });

      test('should handle logout when not logged in', () async {
        final notifier = container.read(userProvider.notifier);

        await notifier.logoutUser();

        final state = container.read(userProvider);
        expect(state.isUserLogged, false);
        expect(state.currentUserToken, isNull);
      });

      test('should handle multiple theme switches in sequence', () {
        final notifier = container.read(userProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.switchThemeMode();
        }

        // After even number of switches, should be back to light
        expect(container.read(userProvider).isLightTheme, true);
      });
    });
  });
}
