import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/user_provider_riverpod.dart';
import '../../../widgets/cards/app_list_tile.dart';
import '../../../widgets/page_app_bar.dart';

class LanguagesPage extends ConsumerWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PageAppBar(title: l.languages),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// French
              AppListTile(
                text: l.french,
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => ref.read(userProvider.notifier).changeLocale(const Locale("fr", "FR")),
              ),

              /// English
              AppListTile(
                text: l.english,
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.g_translate,

                /// update MaterialApp with new locale
                onTap: () => ref.read(userProvider.notifier).changeLocale(const Locale("en", "US")),
              ),

              /// Arabic
              AppListTile(
                text: l.arabic,
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
