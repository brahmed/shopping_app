import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/user_provider.dart';

import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: const PageAppBar(title: "Languages"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Language
              AppListTile(
                text: "Français",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => provider.changeLocale(const Locale("fr", "FR")),
              ),

              /// Notification
              AppListTile(
                text: "English",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => provider.changeLocale(const Locale("en", "US")),
              ),

              /// Theme mode card
              AppListTile(
                text: "العربية",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => provider.changeLocale(const Locale("ar", "TN")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
