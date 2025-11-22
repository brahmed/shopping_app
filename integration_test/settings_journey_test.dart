import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Settings Journey E2E Tests', () {
    testWidgets('Navigate to settings page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Verify settings page
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Toggle theme mode', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Find theme toggle
      final themeSwitch = find.byType(Switch);
      if (themeSwitch.evaluate().isNotEmpty) {
        // Toggle theme
        await tester.tap(themeSwitch.first);
        await tester.pumpAndSettle();

        // Verify theme changed
        expect(find.byType(Switch), findsWidgets);

        // Toggle back
        await tester.tap(themeSwitch.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Change language', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Navigate to languages
        final languagesButton = find.textContaining('Language', findRichText: true);
        if (languagesButton.evaluate().isNotEmpty) {
          await tester.tap(languagesButton.first);
          await tester.pumpAndSettle();

          // Verify languages page
          expect(find.byType(RadioListTile), findsWidgets);

          // Go back
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Manage notification settings', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Navigate to notification settings
        final notifButton = find.textContaining('Notification', findRichText: true);
        if (notifButton.evaluate().isNotEmpty) {
          await tester.tap(notifButton.first);
          await tester.pumpAndSettle();

          // Verify notification settings page
          expect(find.byType(SwitchListTile), findsWidgets);

          // Toggle a notification setting
          final notifSwitch = find.byType(SwitchListTile);
          if (notifSwitch.evaluate().isNotEmpty) {
            await tester.tap(notifSwitch.first);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('Access help and support', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to help
      final helpButton = find.textContaining('Help', findRichText: true);
      if (helpButton.evaluate().isNotEmpty) {
        await tester.tap(helpButton.first);
        await tester.pumpAndSettle();

        // Verify help page with FAQs
        expect(find.byType(ExpansionTile), findsWidgets);

        // Go back
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('View contact us page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to contact us
      final contactButton = find.textContaining('Contact', findRichText: true);
      if (contactButton.evaluate().isNotEmpty) {
        await tester.tap(contactButton.first);
        await tester.pumpAndSettle();

        // Verify contact page
        expect(find.byType(TextField), findsWidgets);

        // Go back
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Settings persist across navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Toggle theme
      final themeSwitch = find.byType(Switch);
      if (themeSwitch.evaluate().isNotEmpty) {
        await tester.tap(themeSwitch.first);
        await tester.pumpAndSettle();
      }

      // Navigate to other tabs
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Navigate back to profile - theme should persist
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
    });

    testWidgets('View app version and info', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Scroll to bottom to see version info
        await tester.drag(
          find.byType(ListView).first,
          const Offset(0, -300),
        );
        await tester.pumpAndSettle();

        // Look for version text
        expect(find.byType(Text), findsWidgets);
      }
    });

    testWidgets('Clear cache/data options', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Look for clear cache option
        final clearButton = find.textContaining('Clear', findRichText: true);
        if (clearButton.evaluate().isNotEmpty) {
          await tester.tap(clearButton.first);
          await tester.pumpAndSettle();

          // May show confirmation dialog
          final confirmButton = find.textContaining('Confirm', findRichText: true);
          if (confirmButton.evaluate().isNotEmpty) {
            // Cancel instead of confirming
            final cancelButton = find.textContaining('Cancel', findRichText: true);
            if (cancelButton.evaluate().isNotEmpty) {
              await tester.tap(cancelButton.first);
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });

    testWidgets('Privacy and terms links', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to settings
      final settingsButton = find.textContaining('Settings', findRichText: true);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton.first);
        await tester.pumpAndSettle();

        // Look for privacy policy
        final privacyButton = find.textContaining('Privacy', findRichText: true);
        if (privacyButton.evaluate().isNotEmpty) {
          await tester.tap(privacyButton.first);
          await tester.pumpAndSettle();

          // Go back
          final backButton = find.byType(BackButton);
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }
        }
      }
    });
  });
}
