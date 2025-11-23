import 'package:flutter/material.dart';

import '../../widgets/cards/app_list_tile.dart';
import '../../widgets/page_app_bar.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PageAppBar(title: "Help"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Call us card
              AppListTile(
                text: "Settings",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.phone,
              ),

              /// Email card
              AppListTile(
                text: "Email",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.email,
              ),

              /// Chat with us card
              AppListTile(
                text: "Chat with us",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.message,
              ),

              /// Facebook card
              AppListTile(
                text: "Facebook",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.messenger,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
