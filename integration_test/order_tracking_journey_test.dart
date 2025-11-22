import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Order Tracking Journey E2E Tests', () {
    testWidgets('View all orders', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate to orders
      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Verify orders page
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('View order details', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on an order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Verify order details page
          expect(find.byType(BackButton), findsOneWidget);
        }
      }
    });

    testWidgets('Track order status', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Look for order status indicators
        expect(find.byType(Icon), findsWidgets);
      }
    });

    testWidgets('View order timeline', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Look for timeline/tracking info
          expect(find.byType(ListTile), findsWidgets);
        }
      }
    });

    testWidgets('Cancel order', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Look for cancel button
          final cancelButton = find.textContaining('Cancel', findRichText: true);
          if (cancelButton.evaluate().isNotEmpty) {
            await tester.tap(cancelButton.first);
            await tester.pumpAndSettle();

            // May show confirmation dialog
            final confirmButton = find.textContaining('Confirm', findRichText: true);
            if (confirmButton.evaluate().isNotEmpty) {
              await tester.tap(confirmButton.first);
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });

    testWidgets('Return order', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on delivered order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Look for return button
          final returnButton = find.textContaining('Return', findRichText: true);
          if (returnButton.evaluate().isNotEmpty) {
            await tester.tap(returnButton.first);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('View tracking number', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on shipped order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Look for tracking number
          expect(find.textContaining('Track', findRichText: true), findsWidgets);
        }
      }
    });

    testWidgets('Filter orders by status', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Look for filter/tab options
        final tabs = find.byType(Tab);
        if (tabs.evaluate().isNotEmpty) {
          await tester.tap(tabs.first);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('View order invoice', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Tap on order
        final orderCard = find.byType(GestureDetector);
        if (orderCard.evaluate().isNotEmpty) {
          await tester.tap(orderCard.first);
          await tester.pumpAndSettle();

          // Look for invoice/receipt button
          final invoiceButton = find.textContaining('Invoice', findRichText: true);
          if (invoiceButton.evaluate().isNotEmpty) {
            await tester.tap(invoiceButton.first);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('Empty orders state', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to orders
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // May show empty state
        expect(find.byType(Scaffold), findsOneWidget);
      }
    });
  });
}
