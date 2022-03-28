import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/images.dart';
import '../../navigation/routes.dart';
import '../../providers/user_provider.dart';
import '../../widgets/buttons/app_filled_button.dart';
import '../../widgets/buttons/app_outlined_button.dart';
import '../../widgets/cards/app_card.dart';
import '../../widgets/cards/app_list_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
              child: Text("My Account",
                  style: Theme.of(context).textTheme.headline1),
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
              children: Provider.of<UserProvider>(context).isUserLogged
                  ? _userLoggedInProfile()
                  : _userNotLoggedInProfile(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _userNotLoggedInProfile() => [
        // Log In
        AppButtonFilled(
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          text: "Login",
          onClick: () => Navigator.pushNamed(context, Routes.login),
        ),

        // spacing
        const SizedBox(height: 10),

        // Register
        AppButtonOutlined(
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          text: "Register",
          centerContent: true,
          onClick: () => Navigator.pushNamed(context, Routes.register),
        ),

        // Spacing
        const Divider(),

        // Settings
        AppListTile(
          text: "Settings",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.settings,
          onTap: () => Navigator.pushNamed(context, Routes.settings),
        ),

        // Contact Us
        AppListTile(
          text: "Contact Us",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.headset_mic_rounded,
          onTap: () => Navigator.pushNamed(context, Routes.contact),
        ),

        // Help
        AppListTile(
          text: "Help",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.help,
          onTap: () => Navigator.pushNamed(context, Routes.help),
        ),
      ];

  List<Widget> _userLoggedInProfile() => [
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
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: const Text(
              "mail@gmail.com",
            ),
            trailing: const Icon(Icons.edit),
          ),
        ),

        // Orders
        const AppListTile(
          text: "Orders",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.my_library_books,
        ),

        // Addresses
        const AppListTile(
          text: "Addresses",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.location_on_outlined,
        ),

        // Mobile Number
        const AppListTile(
          text: "Mobile Number",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.phone,
        ),

        // Wishlist
        const AppListTile(
          text: "Wishlist",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.favorite,
        ),

        // Settings
        AppListTile(
          text: "Settings",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.settings,
          onTap: () => Navigator.pushNamed(context, Routes.settings),
        ),

        // Contact Us
        AppListTile(
          text: "Contact Us",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.headset_mic_rounded,
          onTap: () => Navigator.pushNamed(context, Routes.contact),
        ),

        // Help
        AppListTile(
          text: "Help",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.help,
          onTap: () => Navigator.pushNamed(context, Routes.help),
        ),

        // Log out
        AppListTile(
          text: "Log out",
          margin: 10.0,
          padding: 10.0,
          radius: 10.0,
          iconData: Icons.logout,
          onTap: () {
            Provider.of<UserProvider>(context, listen: false).logoutUser();
            Navigator.pushNamed(context, Routes.login);
          },
        ),
      ];
}
