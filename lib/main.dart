import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../config/constants.dart';
import '../navigation/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(AppTheme.light());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: themeNotifier,
      builder: (_, ThemeData currentTheme, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: kAppTitle,
          theme: currentTheme,
          initialRoute: Routes.tabs,
          routes: Routes.routes(),
        );
      },
    );
  }
}
