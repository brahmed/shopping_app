import 'package:flutter/material.dart';

import '../../../widgets/app_card.dart';
import '../../../widgets/page_app_bar.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  /// notification switches state values
  bool _accountActive = false;
  bool _shipmentsActive = false;
  bool _recommendationsActive = false;
  bool _dealsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Notification"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Account Notifications
              AppCard(
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                child: SwitchListTile(
                  title: Text(
                    "Your Account",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  subtitle: const Text(
                    "Get notified for account",
                  ),
                  value: _accountActive,
                  onChanged: (value) => setState(() => _accountActive = value),
                ),
              ),

              /// Shipments Notifications
              AppCard(
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                child: SwitchListTile(
                  title: Text(
                    "Your Shipments",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  subtitle: const Text(
                    "Find out when your packages are shipped",
                  ),
                  value: _shipmentsActive,
                  onChanged: (value) =>
                      setState(() => _shipmentsActive = value),
                ),
              ),

              /// Recommendation Notifications
              AppCard(
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                child: SwitchListTile(
                  title: Text(
                    "Your recommendations",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  subtitle: const Text(
                    "Receive recommendations based on your shopping activity",
                  ),
                  value: _recommendationsActive,
                  onChanged: (value) =>
                      setState(() => _recommendationsActive = value),
                ),
              ),

              /// Watched and waitlisted deals Notifications
              AppCard(
                margin: 10.0,
                padding: 10.0,
                radius: 10.0,
                child: SwitchListTile(
                  title: Text(
                    "Your watched and waitlisted deals",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  subtitle: const Text(
                    "Find out when lightning deals happen",
                  ),
                  value: _dealsActive,
                  onChanged: (value) => setState(() => _dealsActive = value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
