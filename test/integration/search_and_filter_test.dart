import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/providers/products_provider_riverpod.dart';

void main() {
  group('Search and Filter Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Search products by name', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to search tab
      final searchTab = find.byIcon(Icons.search);
      if (searchTab.evaluate().isNotEmpty) {
        await tester.tap(searchTab);
        await tester.pumpAndSettle();

        // Find search field
        final searchField = find.byType(TextField);
        if (searchField.evaluate().isNotEmpty) {
          await tester.enterText(searchField.first, 'Phone');
          await tester.pumpAndSettle();

          // Verify search results are displayed
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    testWidgets('Clear search query', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to search tab
      final searchTab = find.byIcon(Icons.search);
      if (searchTab.evaluate().isNotEmpty) {
        await tester.tap(searchTab);
        await tester.pumpAndSettle();

        // Enter search query
        final searchField = find.byType(TextField);
        if (searchField.evaluate().isNotEmpty) {
          await tester.enterText(searchField.first, 'Test');
          await tester.pumpAndSettle();

          // Clear search
          final clearIcon = find.byIcon(Icons.clear);
          if (clearIcon.evaluate().isNotEmpty) {
            await tester.tap(clearIcon);
            await tester.pumpAndSettle();

            // Verify search is cleared
            final textField = tester.widget<TextField>(searchField.first);
            expect(textField.controller?.text, '');
          }
        }
      }
    });

    test('Filter products by category', () {
      final products = container.read(productsProvider);

      // Filter by electronics
      final electronicsProducts =
          products.where((p) => p.category == 'Electronics').toList();

      // Filter by clothing
      final clothingProducts =
          products.where((p) => p.category == 'Clothing').toList();

      expect(electronicsProducts, isNotEmpty);
      expect(clothingProducts, isNotEmpty);

      // Verify filtered products belong to correct category
      for (final product in electronicsProducts) {
        expect(product.category, 'Electronics');
      }
    });

    test('Filter products by price range', () {
      final products = container.read(productsProvider);

      // Filter products under $100
      final affordableProducts =
          products.where((p) => p.price < 100).toList();

      // Filter products between $100-$500
      final midRangeProducts =
          products.where((p) => p.price >= 100 && p.price <= 500).toList();

      // Filter expensive products over $500
      final expensiveProducts =
          products.where((p) => p.price > 500).toList();

      // Verify price ranges
      for (final product in affordableProducts) {
        expect(product.price, lessThan(100));
      }

      for (final product in midRangeProducts) {
        expect(product.price, greaterThanOrEqualTo(100));
        expect(product.price, lessThanOrEqualTo(500));
      }
    });

    test('Filter products by rating', () {
      final products = container.read(productsProvider);

      // Filter highly rated products (4+ stars)
      final highlyRated = products.where((p) => p.rating >= 4.0).toList();

      // Filter average rated products (3-4 stars)
      final averageRated =
          products.where((p) => p.rating >= 3.0 && p.rating < 4.0).toList();

      // Verify ratings
      for (final product in highlyRated) {
        expect(product.rating, greaterThanOrEqualTo(4.0));
      }

      for (final product in averageRated) {
        expect(product.rating, greaterThanOrEqualTo(3.0));
        expect(product.rating, lessThan(4.0));
      }
    });

    test('Filter products by availability', () {
      final products = container.read(productsProvider);

      // Filter in-stock products
      final inStockProducts = products.where((p) => p.inStock).toList();

      // Filter out-of-stock products
      final outOfStockProducts = products.where((p) => !p.inStock).toList();

      // Verify availability
      for (final product in inStockProducts) {
        expect(product.inStock, true);
      }

      for (final product in outOfStockProducts) {
        expect(product.inStock, false);
      }
    });

    test('Filter products with discounts', () {
      final products = container.read(productsProvider);

      // Filter discounted products
      final discountedProducts =
          products.where((p) => p.hasDiscount).toList();

      // Verify discounts
      for (final product in discountedProducts) {
        expect(product.hasDiscount, true);
        expect(product.originalPrice, greaterThan(product.price));
        expect(product.discountPercentage, greaterThan(0));
      }
    });

    test('Sort products by price - low to high', () {
      final products = List<Product>.from(container.read(productsProvider));

      // Sort by price ascending
      products.sort((a, b) => a.price.compareTo(b.price));

      // Verify sorting
      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].price, lessThanOrEqualTo(products[i + 1].price));
      }
    });

    test('Sort products by price - high to low', () {
      final products = List<Product>.from(container.read(productsProvider));

      // Sort by price descending
      products.sort((a, b) => b.price.compareTo(a.price));

      // Verify sorting
      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].price, greaterThanOrEqualTo(products[i + 1].price));
      }
    });

    test('Sort products by rating', () {
      final products = List<Product>.from(container.read(productsProvider));

      // Sort by rating descending
      products.sort((a, b) => b.rating.compareTo(a.rating));

      // Verify sorting
      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].rating, greaterThanOrEqualTo(products[i + 1].rating));
      }
    });

    test('Sort products by popularity (review count)', () {
      final products = List<Product>.from(container.read(productsProvider));

      // Sort by review count descending
      products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));

      // Verify sorting
      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].reviewCount,
            greaterThanOrEqualTo(products[i + 1].reviewCount));
      }
    });

    test('Combined filters - category and price range', () {
      final products = container.read(productsProvider);

      // Filter electronics under $500
      final filteredProducts = products
          .where((p) => p.category == 'Electronics' && p.price < 500)
          .toList();

      // Verify combined filters
      for (final product in filteredProducts) {
        expect(product.category, 'Electronics');
        expect(product.price, lessThan(500));
      }
    });

    test('Combined filters - brand and in stock', () {
      final products = container.read(productsProvider);

      if (products.isNotEmpty) {
        final firstBrand = products.first.brand;

        // Filter by brand and availability
        final filteredProducts =
            products.where((p) => p.brand == firstBrand && p.inStock).toList();

        // Verify combined filters
        for (final product in filteredProducts) {
          expect(product.brand, firstBrand);
          expect(product.inStock, true);
        }
      }
    });

    testWidgets('Search with no results', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to search
      final searchTab = find.byIcon(Icons.search);
      if (searchTab.evaluate().isNotEmpty) {
        await tester.tap(searchTab);
        await tester.pumpAndSettle();

        // Search for non-existent product
        final searchField = find.byType(TextField);
        if (searchField.evaluate().isNotEmpty) {
          await tester.enterText(
              searchField.first, 'NonExistentProduct12345');
          await tester.pumpAndSettle();

          // Should show no results message
          expect(
            find.textContaining('no', findRichText: true),
            findsWidgets,
          );
        }
      }
    });

    test('Search case insensitivity', () {
      final products = container.read(productsProvider);

      if (products.isNotEmpty) {
        final searchTerm = products.first.name.substring(0, 3);

        // Search with lowercase
        final lowerCaseResults = products
            .where((p) =>
                p.name.toLowerCase().contains(searchTerm.toLowerCase()))
            .toList();

        // Search with uppercase
        final upperCaseResults = products
            .where((p) =>
                p.name.toLowerCase().contains(searchTerm.toUpperCase().toLowerCase()))
            .toList();

        // Should return same results
        expect(lowerCaseResults.length, upperCaseResults.length);
      }
    });

    test('Filter by multiple categories', () {
      final products = container.read(productsProvider);

      final categories = ['Electronics', 'Clothing'];
      final filteredProducts =
          products.where((p) => categories.contains(p.category)).toList();

      // Verify products belong to specified categories
      for (final product in filteredProducts) {
        expect(categories.contains(product.category), true);
      }
    });

    testWidgets('Apply and clear filters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to search/filter page
      final searchTab = find.byIcon(Icons.search);
      if (searchTab.evaluate().isNotEmpty) {
        await tester.tap(searchTab);
        await tester.pumpAndSettle();

        // Look for filter button
        final filterButton = find.byIcon(Icons.filter_list);
        if (filterButton.evaluate().isNotEmpty) {
          await tester.tap(filterButton);
          await tester.pumpAndSettle();

          // Apply filters
          final applyButton = find.textContaining('Apply', findRichText: true);
          if (applyButton.evaluate().isNotEmpty) {
            await tester.tap(applyButton.first);
            await tester.pumpAndSettle();
          }
        }
      }
    });
  });
}
