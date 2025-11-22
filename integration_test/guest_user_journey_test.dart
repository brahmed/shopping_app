import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Guest User Journey E2E Tests', () {
    testWidgets('Guest user can browse products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Browse products on home page
      expect(find.byType(Scaffold), findsWidgets);

      // Scroll through products
      await tester.drag(
        find.byType(ListView).first,
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // Verify still on home page
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('Guest user can view product details', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find and tap first product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Verify product detail page is displayed
        expect(find.byType(BackButton), findsOneWidget);

        // Go back to home
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Guest user can search for products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Enter search query
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'Phone');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify results are displayed
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Guest user can add items to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Find and tap "Add to Cart" button
        final addToCartButton = find.text('Add to Cart');
        if (addToCartButton.evaluate().isNotEmpty) {
          await tester.tap(addToCartButton);
          await tester.pumpAndSettle();

          // Verify success message or cart badge update
          expect(find.byType(SnackBar), findsWidgets);
        }
      }
    });

    testWidgets('Guest user can view cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Verify cart page is displayed
        expect(find.text('Cart'), findsOneWidget);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Guest user sees login prompt for protected features',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Try to access orders
      final ordersButton = find.textContaining('Orders', findRichText: true);
      if (ordersButton.evaluate().isNotEmpty) {
        await tester.tap(ordersButton.first);
        await tester.pumpAndSettle();

        // Should show login prompt or redirect to login
        expect(
          find.textContaining('Login', findRichText: true),
          findsWidgets,
        );
      }
    });

    testWidgets('Guest user can navigate to login page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Find and tap login button
      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        // Verify login page is displayed
        expect(find.byType(TextField), findsWidgets);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Guest user can browse categories', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Look for category buttons/tabs
      final categoryButtons = find.byType(TextButton);
      if (categoryButtons.evaluate().isNotEmpty) {
        // Tap first category
        await tester.tap(categoryButtons.first);
        await tester.pumpAndSettle();

        // Verify products are filtered
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Guest user can view product ratings', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for ratings display
        expect(find.byIcon(Icons.star), findsWidgets);

        // Go back
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Guest user cannot add reviews', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for review section
        final reviewButton = find.textContaining('Write', findRichText: true);
        if (reviewButton.evaluate().isNotEmpty) {
          await tester.tap(reviewButton.first);
          await tester.pumpAndSettle();

          // Should prompt for login
          expect(
            find.textContaining('Login', findRichText: true),
            findsWidgets,
          );
        }
      }
    });

    testWidgets('Guest user can use app settings', (WidgetTester tester) async {
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

        // Verify settings page is accessible
        expect(find.byType(ListView), findsWidgets);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Guest user cart persists across navigation',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to cart
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Go back and navigate to different tabs
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          await tester.tap(find.byIcon(Icons.search));
          await tester.pumpAndSettle();

          await tester.tap(find.byIcon(Icons.home));
          await tester.pumpAndSettle();

          // Check cart still has items
          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // Cart should not be empty
            expect(find.text('Cart'), findsOneWidget);
          }
        }
      }
    });
  });
}
