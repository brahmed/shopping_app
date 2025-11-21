import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../navigation/app_router.dart';
import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
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
                onTap: () => context.push(AppRoutes.languages),
              ),

              /// Notification
              AppListTile(
                text: "Notification",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.notifications_none_outlined,
                onTap: () => context.push(AppRoutes.notificationSettings),
              ),

              /// Theme mode card
              AppListTile(
                text: "Switch mode",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: userState.isLightTheme
                    ? Icons.dark_mode
                    : Icons.light_mode,
                onTap: () => ref.read(userProvider.notifier).switchThemeMode(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
