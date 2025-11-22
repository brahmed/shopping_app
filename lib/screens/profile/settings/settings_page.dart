import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../navigation/app_router.dart';
import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PageAppBar(title: l.settings),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Language
              AppListTile(
                text: l.language,
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,
                onTap: () => context.push(AppRoutes.languages),
              ),

              /// Notification
              AppListTile(
                text: l.notification,
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.notifications_none_outlined,
                onTap: () => context.push(AppRoutes.notificationSettings),
              ),

              /// Theme mode card
              AppListTile(
                text: l.switchMode,
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
