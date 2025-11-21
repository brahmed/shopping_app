import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class LanguagesPage extends ConsumerWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onTap: () => ref.read(userProvider.notifier).changeLocale(const Locale("fr", "FR")),
              ),

              /// Notification
              AppListTile(
                text: "English",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => ref.read(userProvider.notifier).changeLocale(const Locale("en", "US")),
              ),

              /// Theme mode card
              AppListTile(
                text: "العربية",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => ref.read(userProvider.notifier).changeLocale(const Locale("ar", "TN")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
