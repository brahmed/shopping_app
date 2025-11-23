import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../config/images.dart';
import '../../navigation/app_router.dart';
import '../../providers/user_provider_riverpod.dart';
import '../../widgets/buttons/app_filled_button.dart';
import '../../widgets/buttons/app_outlined_button.dart';
import '../../widgets/cards/app_card.dart';
import '../../widgets/cards/app_list_tile.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final l = AppLocalizations.of(context);

    return Scaffold(
      /// App Bar
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Page Title
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(l.myAccount,
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            Image.asset(
              appImage,
              color: Theme.of(context).iconTheme.color,
              height: 100,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: userState.isUserLogged
                  ? _userLoggedInProfile(context, ref)
                  : _userNotLoggedInProfile(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _userNotLoggedInProfile(BuildContext context) {
    final l = AppLocalizations.of(context);
    return [
        // Log In
        AppButtonFilled(
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          text: l.login,
          onClick: () => context.push(AppRoutes.login),
        ),

        // spacing
        const SizedBox(height: 10),

        // Register
        AppButtonOutlined(
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          text: l.register,
          centerContent: true,
          onClick: () => context.push(AppRoutes.register),
        ),

        // Spacing
        const Divider(),

        // Settings
        AppListTile(
          text: l.settings,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.settings,
          onTap: () => context.push(AppRoutes.settings),
        ),

        // Contact Us
        AppListTile(
          text: l.contactUs,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.headset_mic_rounded,
          onTap: () => context.push(AppRoutes.contact),
        ),

        // Help
        AppListTile(
          text: l.help,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.help,
          onTap: () => context.push(AppRoutes.help),
        ),
      ];
  }

  List<Widget> _userLoggedInProfile(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return [
        // User Info
        AppCard(
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          child: ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 50,
            ),
            title: Text(
              "Amine Brahmi",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subtitle: const Text(
              "mail@gmail.com",
            ),
            trailing: const Icon(Icons.edit),
          ),
        ),

        // Orders
        AppListTile(
          text: l.orders,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.my_library_books,
        ),

        // Addresses
        AppListTile(
          text: l.addresses,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.location_on_outlined,
        ),

        // Mobile Number
        AppListTile(
          text: l.mobileNumber,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.phone,
        ),

        // Wishlist
        AppListTile(
          text: l.wishlist,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.favorite,
        ),

        // Settings
        AppListTile(
          text: l.settings,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.settings,
          onTap: () => context.push(AppRoutes.settings),
        ),

        // Contact Us
        AppListTile(
          text: l.contactUs,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.headset_mic_rounded,
          onTap: () => context.push(AppRoutes.contact),
        ),

        // Help
        AppListTile(
          text: l.help,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.help,
          onTap: () => context.push(AppRoutes.help),
        ),

        // Log out
        AppListTile(
          text: l.logout,
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.logout,
          onTap: () {
            ref.read(userProvider.notifier).logoutUser();
            context.go(AppRoutes.login);
          },
        ),
      ];
  }
}
