import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../config/constants.dart';
import '../navigation/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: AppTheme.light(),
      initialRoute: Routes.tabs,
      routes: Routes.routes(),
    );
  }
}
