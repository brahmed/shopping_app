import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../config/constants.dart';
import '../screens/tab_pages/tabs_manager.dart';

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
      home: const TabsManager(),
    );
  }
}
