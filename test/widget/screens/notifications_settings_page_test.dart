import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/profile/settings/notifications_settings_page.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('NotificationsSettingsPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsSettingsPage(),
          ),
        ),
      );

      expect(find.byType(NotificationsSettingsPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsSettingsPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
    });

    testWidgets('should display notifications title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsSettingsPage(),
          ),
        ),
      );

      expect(find.text('Notifications'), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsSettingsPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerStatefulWidget', (tester) async {
      const notificationsPage = NotificationsSettingsPage();
      expect(notificationsPage, isA<ConsumerStatefulWidget>());
    });
  });
}
