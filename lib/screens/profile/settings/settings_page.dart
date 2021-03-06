import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../navigation/routes.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: const PageAppBar(title: "Help"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Language
              AppListTile(
                text: "Language",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,
                onTap: () => Navigator.pushNamed(context, Routes.languages),
              ),

              /// Notification
              AppListTile(
                text: "Notification",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.notifications_none_outlined,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.notificationSettings),
              ),

              /// Theme mode card
              AppListTile(
                text: "Switch mode",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: userProvider.isLightTheme
                    ? Icons.dark_mode
                    : Icons.light_mode,
                onTap: () => userProvider.switchThemeMode(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
