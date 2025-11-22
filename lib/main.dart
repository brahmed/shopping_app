import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/app_theme.dart';
import 'config/constants.dart';
import 'navigation/app_router.dart';
import 'providers/user_provider_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: userState.isLightTheme ? AppTheme.light() : AppTheme.dark(),
      routerConfig: appRouter,

      // Accessibility Settings
      // Show semantic debugger in debug mode (can be toggled)
      showSemanticsDebugger: false,

      // Current app locale
      locale: userState.currentLocale,

      // Localizations delegates
      localizationsDelegates: const [
        AppLocalizations.delegate,
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

      // Accessibility features
      builder: (context, child) {
        // Ensure text scaling is supported up to 2.0x
        final mediaQuery = MediaQuery.of(context);
        final scale = mediaQuery.textScaler.scale(1.0).clamp(1.0, 2.0);
        return MediaQuery(
          data: mediaQuery.copyWith(
            // Respect system text scale factor but limit to reasonable max
            textScaler: TextScaler.linear(scale),
          ),
          child: child!,
        );
      },
    );
  }
}
