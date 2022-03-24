import 'package:flutter/material.dart';
import 'package:shopping_app/navigation/routes.dart';

import '../../../widgets/account_item_card.dart';
import '../../../widgets/page_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Help"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Language
              const AccountItemCard(
                text: "Language",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,
              ),

              /// Notification
              AccountItemCard(
                text: "Notification",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.notifications_none_outlined,
                onTap: () => Navigator.pushNamed(context, Routes.notificationSettings),
              ),

              /// Theme mode card
              const AccountItemCard(
                text: "Switch mode",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.light_mode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
