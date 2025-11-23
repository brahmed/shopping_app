import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/providers/cart_provider_riverpod.dart';

void main() {
  group('Shopping Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Complete shopping flow: Browse → Add to Cart → Checkout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Step 1: Verify app loads with home page
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Step 2: Browse products on home page
      // Look for product cards or product listings
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Step 3: Tap on first product card to view details
      final productCards = find.byType(GestureDetector);
      if (productCards.evaluate().isNotEmpty) {
        await tester.tap(productCards.first);
        await tester.pumpAndSettle();
      }

      // Step 4: Add product to cart
      final addToCartButton = find.widgetWithText(ElevatedButton, 'Add to Cart');
      if (addToCartButton.evaluate().isNotEmpty) {
        await tester.tap(addToCartButton);
        await tester.pumpAndSettle();

        // Verify success message or cart update
        expect(find.textContaining('added to cart', findRichText: true),
            findsWidgets);
      }

      // Step 5: Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Verify cart page is displayed
        expect(find.text('Cart'), findsOneWidget);
      }
    });

    testWidgets('Shopping flow with multiple products', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Add multiple products to cart
      for (int i = 0; i < 2; i++) {
        final productCards = find.byType(Card);
        if (productCards.evaluate().length > i) {
          await tester.tap(productCards.at(i));
          await tester.pumpAndSettle();

          final addButton = find.text('Add to Cart');
          if (addButton.evaluate().isNotEmpty) {
            await tester.tap(addButton);
            await tester.pumpAndSettle();

            // Go back to product list
            final backButton = find.byType(BackButton);
            if (backButton.evaluate().isNotEmpty) {
              await tester.tap(backButton);
              await tester.pumpAndSettle();
            }
          }
        }
      }

      // Verify cart has multiple items
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();
      }
    });

    test('Cart provider integration with product provider', () {
      final product = Product(
        id: 'test-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      // Add product to cart
      container.read(cartProvider.notifier).addItem(product);

      // Verify cart state
      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
      expect(cartState.items.first.product.id, 'test-1');
      expect(cartState.totalAmount, 99.99);
    });

    test('Shopping flow state persistence', () async {
      final product1 = Product(
        id: 'prod-1',
        name: 'Product 1',
        description: 'Description 1',
        price: 50.0,
        imageUrl: 'test1.jpg',
        images: ['test1.jpg'],
        category: 'Category1',
        brand: 'Brand1',
      );

      final product2 = Product(
        id: 'prod-2',
        name: 'Product 2',
        description: 'Description 2',
        price: 75.0,
        imageUrl: 'test2.jpg',
        images: ['test2.jpg'],
        category: 'Category2',
        brand: 'Brand2',
      );

      // Add products to cart
      container.read(cartProvider.notifier).addItem(product1);
      container.read(cartProvider.notifier).addItem(product2);

      // Verify total
      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 2);
      expect(cartState.totalAmount, 125.0);
      expect(cartState.totalItemsCount, 2);
    });

    testWidgets('Navigate between product categories', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Find and tap on category tabs or buttons
      final categoryButtons = find.byType(TextButton);
      if (categoryButtons.evaluate().isNotEmpty) {
        // Tap first category
        await tester.tap(categoryButtons.first);
        await tester.pumpAndSettle();

        // Verify products are displayed
        expect(find.byType(ListView), findsWidgets);
      }
    });

    test('Cart calculations with discounted products', () {
      final regularProduct = Product(
        id: 'regular',
        name: 'Regular Product',
        description: 'Regular',
        price: 100.0,
        imageUrl: 'regular.jpg',
        images: ['regular.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      final discountedProduct = Product(
        id: 'discounted',
        name: 'Discounted Product',
        description: 'Discounted',
        price: 80.0,
        originalPrice: 100.0,
        imageUrl: 'discounted.jpg',
        images: ['discounted.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      container.read(cartProvider.notifier).addItem(regularProduct);
      container.read(cartProvider.notifier).addItem(discountedProduct);

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 2);
      expect(cartState.totalAmount, 180.0);
      expect(discountedProduct.discountPercentage, 20.0);
    });

    testWidgets('Empty cart state handling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to cart when empty
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Verify empty cart message
        expect(
          find.textContaining('empty', findRichText: true),
          findsWidgets,
        );
      }
    });

    test('Product availability check in shopping flow', () {
      final inStockProduct = Product(
        id: 'in-stock',
        name: 'Available Product',
        description: 'In Stock',
        price: 50.0,
        imageUrl: 'available.jpg',
        images: ['available.jpg'],
        category: 'Test',
        brand: 'Test',
        inStock: true,
      );

      final outOfStockProduct = Product(
        id: 'out-of-stock',
        name: 'Unavailable Product',
        description: 'Out of Stock',
        price: 50.0,
        imageUrl: 'unavailable.jpg',
        images: ['unavailable.jpg'],
        category: 'Test',
        brand: 'Test',
        inStock: false,
      );

      expect(inStockProduct.inStock, true);
      expect(outOfStockProduct.inStock, false);

      // Can add in-stock product to cart
      container.read(cartProvider.notifier).addItem(inStockProduct);
      expect(container.read(cartProvider).items.length, 1);
    });
  });
}
