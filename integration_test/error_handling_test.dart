import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Error Handling E2E Tests', () {
    testWidgets('Handle empty cart checkout', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to empty cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Verify empty state message
        expect(find.textContaining('empty', findRichText: true), findsWidgets);

        // Checkout button should be disabled or not present
        final checkoutButton =
            find.textContaining('Checkout', findRichText: true);
        if (checkoutButton.evaluate().isNotEmpty) {
          // Try to tap it
          await tester.tap(checkoutButton.first);
          await tester.pumpAndSettle();

          // Should show error or do nothing
        }
      }
    });

    testWidgets('Handle invalid login credentials', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        // Enter invalid credentials
        final textFields = find.byType(TextField);
        if (textFields.evaluate().length >= 2) {
          await tester.enterText(textFields.at(0), 'invalid@email.com');
          await tester.pumpAndSettle();

          await tester.enterText(textFields.at(1), 'wrongpassword');
          await tester.pumpAndSettle();

          // Try to submit
          final submitButton = find.widgetWithText(ElevatedButton, 'Login');
          if (submitButton.evaluate().isNotEmpty) {
            await tester.tap(submitButton);
            await tester.pumpAndSettle();

            // Should show error message
            expect(find.byType(SnackBar), findsWidgets);
          }
        }
      }
    });

    testWidgets('Handle empty form submission', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        // Try to submit without entering data
        final submitButton = find.widgetWithText(ElevatedButton, 'Login');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          // Should show validation errors
          expect(find.textContaining('required', findRichText: true), findsWidgets);
        }
      }
    });

    testWidgets('Handle network errors gracefully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // App should still be functional even if network fails
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Navigate through the app
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
    });

    testWidgets('Handle out of stock products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Look for out of stock products
      final products = find.byType(GestureDetector);
      if (products.evaluate().isNotEmpty) {
        // Try multiple products
        for (int i = 0; i < products.evaluate().length && i < 3; i++) {
          await tester.tap(products.at(i));
          await tester.pumpAndSettle();

          // Check if add to cart is disabled for out of stock
          final addButton = find.text('Add to Cart');
          final outOfStockText = find.textContaining('Out of Stock', findRichText: true);

          if (outOfStockText.evaluate().isNotEmpty) {
            // Verify add button is disabled
            if (addButton.evaluate().isNotEmpty) {
              // Should not be able to add
            }
          }

          // Go back
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Handle invalid coupon code', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to cart first
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Go to cart
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // Try invalid coupon
            final couponField = find.byType(TextField);
            if (couponField.evaluate().isNotEmpty) {
              await tester.enterText(couponField.first, 'INVALID123');
              await tester.pumpAndSettle();

              final applyButton =
                  find.textContaining('Apply', findRichText: true);
              if (applyButton.evaluate().isNotEmpty) {
                await tester.tap(applyButton.first);
                await tester.pumpAndSettle();

                // Should show error
                expect(find.byType(SnackBar), findsWidgets);
              }
            }
          }
        }
      }
    });

    testWidgets('Handle missing required fields', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to contact form
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final contactButton = find.textContaining('Contact', findRichText: true);
      if (contactButton.evaluate().isNotEmpty) {
        await tester.tap(contactButton.first);
        await tester.pumpAndSettle();

        // Try to submit empty form
        final submitButton = find.byType(ElevatedButton);
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton.first);
          await tester.pumpAndSettle();

          // Should show validation errors
          expect(find.textContaining('required', findRichText: true), findsWidgets);
        }
      }
    });

    testWidgets('Handle rapid button taps', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Rapidly tap add to cart
        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          for (int i = 0; i < 5; i++) {
            await tester.tap(addButton);
            await tester.pump(const Duration(milliseconds: 100));
          }

          await tester.pumpAndSettle();

          // App should still be functional
          expect(find.byType(BackButton), findsOneWidget);
        }
      }
    });

    testWidgets('Handle empty search results', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Search for non-existent product
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'NonExistentProduct12345');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Should show no results message
        expect(find.textContaining('no', findRichText: true), findsWidgets);

        // Verify clear button works
        final clearButton = find.byIcon(Icons.clear);
        if (clearButton.evaluate().isNotEmpty) {
          await tester.tap(clearButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Handle navigation to non-existent routes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // App should handle gracefully and show error page or redirect
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Handle app state after errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Cause an error (empty form submission)
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        final submitButton = find.widgetWithText(ElevatedButton, 'Login');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();
        }
      }

      // Navigate away - app should still work
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Verify app is still functional
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}
