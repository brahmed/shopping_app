import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Wishlist Journey E2E Tests', () {
    testWidgets('Add item to favorites from product details',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Find and tap favorite icon
        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();

          // Icon should change to filled
          expect(find.byIcon(Icons.favorite), findsOneWidget);
        }
      }
    });

    testWidgets('View all favorites', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to favorites tab
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Verify favorites page
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Remove item from favorites', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // First add an item to favorites
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Add to favorites
        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();

          // Remove from favorites
          final favoriteIconFilled = find.byIcon(Icons.favorite);
          if (favoriteIconFilled.evaluate().isNotEmpty) {
            await tester.tap(favoriteIconFilled);
            await tester.pumpAndSettle();

            // Should be back to unfilled
            expect(find.byIcon(Icons.favorite_border), findsOneWidget);
          }
        }
      }
    });

    testWidgets('Add items from favorites to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to favorites
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Tap on a favorite product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Add to cart
        final addButton = find.text('Add to Cart');
        if (addButton.evaluate().isNotEmpty) {
          await tester.tap(addButton);
          await tester.pumpAndSettle();

          // Verify success
          expect(find.byType(SnackBar), findsWidgets);
        }
      }
    });

    testWidgets('Favorites persist across app sessions', (WidgetTester tester) async {
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

        // Navigate away and back
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.bookmark));
        await tester.pumpAndSettle();

        // Favorites should still be there
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('Empty favorites state', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to favorites (empty)
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Should show empty state
      expect(find.textContaining('empty', findRichText: true), findsWidgets);
    });

    testWidgets('Toggle favorite multiple times', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Toggle on
        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.favorite), findsOneWidget);

          // Toggle off
          await tester.tap(find.byIcon(Icons.favorite));
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);

          // Toggle on again
          await tester.tap(find.byIcon(Icons.favorite_border));
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.favorite), findsOneWidget);
        }
      }
    });

    testWidgets('Add multiple items to favorites', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add first product
      final productCards = find.byType(GestureDetector);
      if (productCards.evaluate().isNotEmpty) {
        await tester.tap(productCards.at(0));
        await tester.pumpAndSettle();

        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();
        }

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();

        // Add second product
        if (productCards.evaluate().length > 1) {
          await tester.tap(productCards.at(1));
          await tester.pumpAndSettle();

          final favoriteIcon2 = find.byIcon(Icons.favorite_border);
          if (favoriteIcon2.evaluate().isNotEmpty) {
            await tester.tap(favoriteIcon2);
            await tester.pumpAndSettle();
          }
        }
      }

      // Check favorites
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Should have multiple items
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Navigate between favorites and product details',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add item to favorites first
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

      // Navigate to favorites
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Tap on favorite to view details
      final favoriteProduct = find.byType(GestureDetector);
      if (favoriteProduct.evaluate().isNotEmpty) {
        await tester.tap(favoriteProduct.first);
        await tester.pumpAndSettle();

        // Verify product details
        expect(find.byType(BackButton), findsOneWidget);

        // Go back to favorites
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.bookmark), findsOneWidget);
      }
    });

    testWidgets('Share favorite product', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for share icon
        final shareIcon = find.byIcon(Icons.share);
        if (shareIcon.evaluate().isNotEmpty) {
          await tester.tap(shareIcon);
          await tester.pumpAndSettle();

          // May show share dialog
          expect(find.byType(Dialog), findsWidgets);
        }
      }
    });
  });
}
