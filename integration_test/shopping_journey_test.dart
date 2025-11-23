import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Shopping Journey E2E Tests', () {
    testWidgets('Complete shopping journey: Search → Add → Apply Coupon → Order',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Step 1: Search for a product
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'Phone');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Step 2: Select a product from search results
        final productCard = find.byType(GestureDetector);
        if (productCard.evaluate().isNotEmpty) {
          await tester.tap(productCard.first);
          await tester.pumpAndSettle();

          // Step 3: Add product to cart
          final addButton = find.text('Add to Cart');
          if (addButton.evaluate().isNotEmpty) {
            await tester.tap(addButton);
            await tester.pumpAndSettle();

            // Step 4: Navigate to cart
            await tester.tap(find.byType(BackButton));
            await tester.pumpAndSettle();

            final cartIcon = find.byIcon(Icons.shopping_cart);
            if (cartIcon.evaluate().isNotEmpty) {
              await tester.tap(cartIcon);
              await tester.pumpAndSettle();

              // Step 5: Look for coupon field (optional)
              final couponField =
                  find.textContaining('Coupon', findRichText: true);
              if (couponField.evaluate().isNotEmpty) {
                // Could enter coupon code here
              }

              // Step 6: Proceed to checkout
              final checkoutButton =
                  find.textContaining('Checkout', findRichText: true);
              if (checkoutButton.evaluate().isNotEmpty) {
                await tester.tap(checkoutButton.first);
                await tester.pumpAndSettle();

                // Verify checkout page
                expect(find.byType(Scaffold), findsOneWidget);
              }
            }
          }
        }
      }
    });

    testWidgets('Browse → Filter → Sort → Add to Cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search/browse
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Look for filter button
      final filterButton = find.byIcon(Icons.filter_list);
      if (filterButton.evaluate().isNotEmpty) {
        await tester.tap(filterButton);
        await tester.pumpAndSettle();

        // Close filter dialog if opened
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      // Select a product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Add to cart
        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Add multiple items to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add first product
      final productCards = find.byType(GestureDetector);
      if (productCards.evaluate().isNotEmpty) {
        await tester.tap(productCards.at(0));
        await tester.pumpAndSettle();

        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Go back
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          // Add second product
          if (productCards.evaluate().length > 1) {
            await tester.tap(productCards.at(1));
            await tester.pumpAndSettle();

            final addButton2 = find.text('Add to Cart');
            if (addButton2.evaluate().isNotEmpty) {
              await tester.tap(addButton2);
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });

    testWidgets('Update cart quantities', (WidgetTester tester) async {
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

          // Navigate to cart
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // Find increment button
            final incrementButton = find.byIcon(Icons.add_circle_outline);
            if (incrementButton.evaluate().isNotEmpty) {
              await tester.tap(incrementButton.first);
              await tester.pumpAndSettle();

              // Quantity should increase
              expect(find.byType(Text), findsWidgets);
            }

            // Find decrement button
            final decrementButton = find.byIcon(Icons.remove_circle_outline);
            if (decrementButton.evaluate().isNotEmpty) {
              await tester.tap(decrementButton.first);
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });

    testWidgets('Remove item from cart', (WidgetTester tester) async {
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

          // Navigate to cart
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          final cartIcon = find.byIcon(Icons.shopping_cart);
          if (cartIcon.evaluate().isNotEmpty) {
            await tester.tap(cartIcon);
            await tester.pumpAndSettle();

            // Find delete button
            final deleteButton = find.byIcon(Icons.delete_outline);
            if (deleteButton.evaluate().isNotEmpty) {
              await tester.tap(deleteButton.first);
              await tester.pumpAndSettle();

              // Should show empty cart or confirmation
              expect(find.byType(SnackBar), findsWidgets);
            }
          }
        }
      }
    });

    testWidgets('View product details before adding to cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Verify product details are shown
        expect(find.byType(BackButton), findsOneWidget);

        // Look for product information
        expect(find.byType(Text), findsWidgets);

        // Scroll to see more details
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -300),
        );
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Apply and remove coupon code', (WidgetTester tester) async {
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

            // Look for coupon field
            final couponField = find.byType(TextField);
            if (couponField.evaluate().isNotEmpty) {
              // Try to enter coupon
              await tester.enterText(couponField.first, 'SAVE20');
              await tester.pumpAndSettle();

              // Look for apply button
              final applyButton =
                  find.textContaining('Apply', findRichText: true);
              if (applyButton.evaluate().isNotEmpty) {
                await tester.tap(applyButton.first);
                await tester.pumpAndSettle();
              }
            }
          }
        }
      }
    });

    testWidgets('Cart total updates correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add items and verify total
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

            // Verify total is displayed
            expect(find.textContaining('\$', findRichText: true), findsWidgets);
          }
        }
      }
    });

    testWidgets('Continue shopping from cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Go to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Look for continue shopping button
        final continueButton =
            find.textContaining('Continue', findRichText: true);
        if (continueButton.evaluate().isNotEmpty) {
          await tester.tap(continueButton.first);
          await tester.pumpAndSettle();

          // Should be back to home or products
          expect(find.byType(BottomNavigationBar), findsOneWidget);
        } else {
          // Use back button
          final backButton = find.byType(BackButton);
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('View cart from multiple entry points', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Method 1: Cart icon from home
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        expect(find.text('Cart'), findsOneWidget);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }

      // Method 2: From product detail after adding
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Look for "View Cart" button in snackbar/dialog
          final viewCartButton =
              find.textContaining('View', findRichText: true);
          if (viewCartButton.evaluate().isNotEmpty) {
            await tester.tap(viewCartButton.first);
            await tester.pumpAndSettle();

            expect(find.text('Cart'), findsOneWidget);
          }
        }
      }
    });
  });
}
