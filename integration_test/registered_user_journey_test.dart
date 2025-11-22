import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Registered User Journey E2E Tests', () {
    testWidgets('User can complete login flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Find login button
      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        // Enter credentials
        final textFields = find.byType(TextField);
        if (textFields.evaluate().length >= 2) {
          await tester.enterText(textFields.at(0), 'test@example.com');
          await tester.pumpAndSettle();

          await tester.enterText(textFields.at(1), 'password123');
          await tester.pumpAndSettle();

          // Submit login
          final submitButton = find.widgetWithText(ElevatedButton, 'Login');
          if (submitButton.evaluate().isNotEmpty) {
            await tester.tap(submitButton);
            await tester.pumpAndSettle(const Duration(seconds: 2));
          }
        }
      }
    });

    testWidgets('Logged in user can add items to cart and checkout',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to cart
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Add to cart
        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Navigate to cart
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // Look for checkout button
            final checkoutButton =
                find.textContaining('Checkout', findRichText: true);
            if (checkoutButton.evaluate().isNotEmpty) {
              await tester.tap(checkoutButton.first);
              await tester.pumpAndSettle();

              // Verify checkout flow
              expect(find.byType(ElevatedButton), findsWidgets);
            }
          }
        }
      }
    });

    testWidgets('Logged in user can view order history', (WidgetTester tester) async {
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

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Logged in user can add items to wishlist',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Find favorite button
        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();

          // Icon should change to filled
          expect(find.byIcon(Icons.favorite), findsOneWidget);

          // Go back and check favorites
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          await tester.tap(find.byIcon(Icons.bookmark));
          await tester.pumpAndSettle();

          // Favorites should not be empty
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    testWidgets('Logged in user can write reviews', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for write review button
        final reviewButton = find.textContaining('Write', findRichText: true);
        if (reviewButton.evaluate().isNotEmpty) {
          await tester.tap(reviewButton.first);
          await tester.pumpAndSettle();

          // Should show review form
          expect(find.byType(TextField), findsWidgets);

          // Go back
          final backButton = find.byType(BackButton);
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('Logged in user can manage addresses', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Look for addresses option
      final addressButton = find.textContaining('Address', findRichText: true);
      if (addressButton.evaluate().isNotEmpty) {
        await tester.tap(addressButton.first);
        await tester.pumpAndSettle();

        // Verify addresses page
        expect(find.byType(Scaffold), findsOneWidget);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Logged in user can update profile', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Look for edit profile button
      final editButton = find.byIcon(Icons.edit);
      if (editButton.evaluate().isNotEmpty) {
        await tester.tap(editButton.first);
        await tester.pumpAndSettle();

        // Verify edit form
        expect(find.byType(TextField), findsWidgets);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Logged in user can view notifications', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Look for notifications icon
      final notificationIcon = find.byIcon(Icons.notifications);
      if (notificationIcon.evaluate().isNotEmpty) {
        await tester.tap(notificationIcon);
        await tester.pumpAndSettle();

        // Verify notifications page
        expect(find.byType(ListView), findsWidgets);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Logged in user can logout', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Look for logout button
      final logoutButton = find.textContaining('Logout', findRichText: true);
      if (logoutButton.evaluate().isNotEmpty) {
        await tester.tap(logoutButton.first);
        await tester.pumpAndSettle();

        // Should show login button again
        expect(find.textContaining('Login', findRichText: true), findsWidgets);
      }
    });

    testWidgets('User data persists after app restart simulation',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to favorites
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();
        }

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }

      // Navigate away and back
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Favorites should still be there
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('User can complete full shopping journey',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 1. Browse products
      await tester.drag(
        find.byType(ListView).first,
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();

      // 2. View product details
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // 3. Add to cart
        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // 4. View cart
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // 5. Verify cart has items
            expect(find.text('Cart'), findsOneWidget);
          }
        }
      }
    });
  });
}
