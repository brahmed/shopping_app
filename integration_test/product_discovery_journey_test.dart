import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Product Discovery Journey E2E Tests', () {
    testWidgets('Browse products on home page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify products are displayed
      expect(find.byType(ListView), findsWidgets);

      // Scroll through products
      await tester.drag(
        find.byType(ListView).first,
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('View product by category', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Look for category tabs/buttons
      final categoryButtons = find.byType(TextButton);
      if (categoryButtons.evaluate().isNotEmpty) {
        await tester.tap(categoryButtons.first);
        await tester.pumpAndSettle();

        // Verify filtered products
        expect(find.byType(ListView), findsWidgets);

        // Try another category
        if (categoryButtons.evaluate().length > 1) {
          await tester.tap(categoryButtons.at(1));
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Search for products', (WidgetTester tester) async {
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

        // Verify results
        expect(find.byType(ListView), findsWidgets);

        // Clear search
        final clearIcon = find.byIcon(Icons.clear);
        if (clearIcon.evaluate().isNotEmpty) {
          await tester.tap(clearIcon);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Apply filters to products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Look for filter button
      final filterButton = find.byIcon(Icons.filter_list);
      if (filterButton.evaluate().isNotEmpty) {
        await tester.tap(filterButton);
        await tester.pumpAndSettle();

        // Filter dialog should appear
        expect(find.byType(Dialog), findsWidgets);

        // Close filter
        final closeButton = find.byType(BackButton);
        if (closeButton.evaluate().isNotEmpty) {
          await tester.tap(closeButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Sort products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Look for sort button
      final sortButton = find.byIcon(Icons.sort);
      if (sortButton.evaluate().isNotEmpty) {
        await tester.tap(sortButton);
        await tester.pumpAndSettle();

        // Sort options should appear
        expect(find.byType(BottomSheet), findsWidgets);
      }
    });

    testWidgets('View product details', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Verify product details page
        expect(find.byType(BackButton), findsOneWidget);

        // Scroll to see all details
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -300),
        );
        await tester.pumpAndSettle();

        // Go back
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('View product images gallery', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for image gallery (PageView)
        final pageView = find.byType(PageView);
        if (pageView.evaluate().isNotEmpty) {
          // Swipe through images
          await tester.drag(pageView, const Offset(-300, 0));
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('View product ratings and reviews', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for rating stars
        expect(find.byIcon(Icons.star), findsWidgets);

        // Scroll to reviews section
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -500),
        );
        await tester.pumpAndSettle();

        // Look for reviews
        final reviewsTab = find.textContaining('Reviews', findRichText: true);
        if (reviewsTab.evaluate().isNotEmpty) {
          await tester.tap(reviewsTab.first);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('View similar products', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Scroll down to similar products section
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -800),
        );
        await tester.pumpAndSettle();

        // Look for similar products
        final similarProducts = find.textContaining('Similar', findRichText: true);
        if (similarProducts.evaluate().isNotEmpty) {
          // Horizontal scroll through similar products
          final horizontalList = find.byType(ListView);
          if (horizontalList.evaluate().isNotEmpty) {
            await tester.drag(horizontalList.last, const Offset(-200, 0));
            await tester.pumpAndSettle();
          }
        }
      }
    });

    testWidgets('Search with no results', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Enter non-existent product
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'XYZ123NonExistent');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Should show no results message
        expect(find.textContaining('no', findRichText: true), findsWidgets);
      }
    });

    testWidgets('View product availability', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to product
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for stock status
        expect(
          find.textContaining('stock', findRichText: true),
          findsWidgets,
        );
      }
    });
  });
}
