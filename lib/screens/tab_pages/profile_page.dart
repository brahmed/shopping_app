import 'package:flutter/material.dart';

import '../../config/images.dart';
import '../../widgets/account_item_card.dart';
import '../../widgets/app_card.dart';

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
            children: [
              /// User Info
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

              /// Orders
              const AccountItemCard(
                text: "Orders",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.my_library_books,
              ),

              /// Addresses
              const AccountItemCard(
                text: "Addresses",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.location_on_outlined,
              ),

              /// Mobile Number
              const AccountItemCard(
                text: "Mobile Number",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.phone,
              ),

              /// Wishlist
              const AccountItemCard(
                text: "Wishlist",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.favorite,
              ),

              /// Settings
              const AccountItemCard(
                text: "Settings",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.settings,
              ),

              /// Contact Us
              const AccountItemCard(
                text: "Contact Us",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.headset_mic_rounded,
              ),

              /// Help
              const AccountItemCard(
                text: "Help",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.help,
              ),

              /// Log out
              const AccountItemCard(
                text: "Log out",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.logout,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
