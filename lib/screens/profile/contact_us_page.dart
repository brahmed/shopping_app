import 'package:flutter/material.dart';

import '../../widgets/account_item_card.dart';
import '../../widgets/page_app_bar.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Help"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              /// Call us card
              AccountItemCard(
                text: "Settings",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.phone,
              ),

              /// Email card
              AccountItemCard(
                text: "Email",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.email,
              ),

              /// Chat with us card
              AccountItemCard(
                text: "Chat with us",
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                iconData: Icons.message,
              ),

              /// Facebook card
              AccountItemCard(
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
