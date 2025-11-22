import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/notifications/notifications_page.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('NotificationsPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsPage(),
          ),
        ),
      );

      expect(find.byType(NotificationsPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
    });

    testWidgets('should display notifications title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsPage(),
          ),
        ),
      );

      expect(find.text('Notifications'), findsWidgets);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NotificationsPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerWidget', (tester) async {
      const notificationsPage = NotificationsPage();
      expect(notificationsPage, isA<ConsumerWidget>());
    });
  });
}
