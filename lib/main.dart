import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../config/app_theme.dart';
import '../config/constants.dart';
import '../navigation/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  /// to change the app's language, this method needs to be called in the app language settings
  static void setLocale(BuildContext context, Locale newLocale) async {
    // get reference to state class
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    // call change local helper method
    state?.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Current locale
  Locale? _locale;

  /// Change language helper method
  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: AppTheme.light(),
      initialRoute: Routes.tabs,
      routes: Routes.routes(),

      // Current app local
      locale: _locale,
      // Localizations delegates
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Supported Locales
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
        Locale('ar', 'TN'),
      ],
      // fetch current language values
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale?.languageCode &&
              supportedLocaleLanguage.countryCode == locale?.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
