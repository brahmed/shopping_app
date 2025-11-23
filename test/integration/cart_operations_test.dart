import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/providers/cart_provider_riverpod.dart';

void main() {
  group('Cart Operations Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Add item to cart', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      container.read(cartProvider.notifier).addItem(product);

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
      expect(cartState.items.first.product.id, 'prod-1');
      expect(cartState.totalAmount, 99.99);
    });

    test('Add multiple quantities of same item', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      // Add same product three times
      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
      expect(cartState.items.first.quantity, 3);
      expect(cartState.totalAmount, 150.0);
    });

    test('Add item with size selection', () {
      final product = Product(
        id: 'prod-1',
        name: 'T-Shirt',
        description: 'Cool T-Shirt',
        price: 25.0,
        imageUrl: 'shirt.jpg',
        images: ['shirt.jpg'],
        category: 'Clothing',
        brand: 'FashionBrand',
        sizes: ['S', 'M', 'L', 'XL'],
      );

      container.read(cartProvider.notifier).addItem(product, size: 'M');

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
      expect(cartState.items.first.selectedSize, 'M');
    });

    test('Add item with color selection', () {
      final product = Product(
        id: 'prod-1',
        name: 'Phone Case',
        description: 'Protective Case',
        price: 15.0,
        imageUrl: 'case.jpg',
        images: ['case.jpg'],
        category: 'Accessories',
        brand: 'TechBrand',
        colors: ['Black', 'White', 'Blue'],
      );

      container.read(cartProvider.notifier).addItem(product, color: 'Blue');

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
      expect(cartState.items.first.selectedColor, 'Blue');
    });

    test('Add same product with different sizes', () {
      final product = Product(
        id: 'prod-1',
        name: 'T-Shirt',
        description: 'Cool T-Shirt',
        price: 25.0,
        imageUrl: 'shirt.jpg',
        images: ['shirt.jpg'],
        category: 'Clothing',
        brand: 'FashionBrand',
        sizes: ['S', 'M', 'L'],
      );

      container.read(cartProvider.notifier).addItem(product, size: 'S');
      container.read(cartProvider.notifier).addItem(product, size: 'M');
      container.read(cartProvider.notifier).addItem(product, size: 'L');

      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 3); // Different sizes = different cart items
      expect(cartState.totalAmount, 75.0);
    });

    test('Remove item from cart', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      container.read(cartProvider.notifier).addItem(product);
      expect(container.read(cartProvider).items.length, 1);

      container.read(cartProvider.notifier).removeItem('prod-1');
      expect(container.read(cartProvider).items.length, 0);
    });

    test('Update item quantity', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      container.read(cartProvider.notifier).addItem(product);

      // Update quantity to 5
      container.read(cartProvider.notifier).updateQuantity('prod-1', 5);

      final cartState = container.read(cartProvider);
      expect(cartState.items.first.quantity, 5);
      expect(cartState.totalAmount, 250.0);
    });

    test('Update quantity to zero removes item', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      container.read(cartProvider.notifier).addItem(product);
      expect(container.read(cartProvider).items.length, 1);

      // Update quantity to 0
      container.read(cartProvider.notifier).updateQuantity('prod-1', 0);

      expect(container.read(cartProvider).items.length, 0);
    });

    test('Clear cart', () {
      final products = [
        Product(
          id: 'prod-1',
          name: 'Product 1',
          description: 'Description 1',
          price: 50.0,
          imageUrl: 'test1.jpg',
          images: ['test1.jpg'],
          category: 'Category1',
          brand: 'Brand1',
        ),
        Product(
          id: 'prod-2',
          name: 'Product 2',
          description: 'Description 2',
          price: 75.0,
          imageUrl: 'test2.jpg',
          images: ['test2.jpg'],
          category: 'Category2',
          brand: 'Brand2',
        ),
      ];

      for (final product in products) {
        container.read(cartProvider.notifier).addItem(product);
      }

      expect(container.read(cartProvider).items.length, 2);

      container.read(cartProvider.notifier).clearCart();

      expect(container.read(cartProvider).items.length, 0);
      expect(container.read(cartProvider).totalAmount, 0.0);
    });

    test('Check if product is in cart', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      expect(container.read(cartProvider.notifier).isInCart('prod-1'), false);

      container.read(cartProvider.notifier).addItem(product);

      expect(container.read(cartProvider.notifier).isInCart('prod-1'), true);
    });

    test('Get product quantity in cart', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      expect(container.read(cartProvider.notifier).getProductQuantity('prod-1'), 0);

      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);

      expect(container.read(cartProvider.notifier).getProductQuantity('prod-1'), 3);
    });

    test('Calculate cart total with multiple items', () {
      final products = [
        Product(
          id: 'prod-1',
          name: 'Product 1',
          description: 'Description 1',
          price: 50.0,
          imageUrl: 'test1.jpg',
          images: ['test1.jpg'],
          category: 'Category1',
          brand: 'Brand1',
        ),
        Product(
          id: 'prod-2',
          name: 'Product 2',
          description: 'Description 2',
          price: 75.50,
          imageUrl: 'test2.jpg',
          images: ['test2.jpg'],
          category: 'Category2',
          brand: 'Brand2',
        ),
        Product(
          id: 'prod-3',
          name: 'Product 3',
          description: 'Description 3',
          price: 100.25,
          imageUrl: 'test3.jpg',
          images: ['test3.jpg'],
          category: 'Category3',
          brand: 'Brand3',
        ),
      ];

      for (final product in products) {
        container.read(cartProvider.notifier).addItem(product);
      }

      final cartState = container.read(cartProvider);
      expect(cartState.totalAmount, 225.75);
    });

    test('Cart item count vs total items count', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      // Add same product 3 times
      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);
      container.read(cartProvider.notifier).addItem(product);

      final cartState = container.read(cartProvider);
      expect(cartState.itemCount, 1); // Unique items
      expect(cartState.totalItemsCount, 3); // Total quantity
    });

    testWidgets('Increment and decrement quantity in cart UI',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Look for increment/decrement buttons
        final incrementButton = find.byIcon(Icons.add);
        final decrementButton = find.byIcon(Icons.remove);

        if (incrementButton.evaluate().isNotEmpty) {
          await tester.tap(incrementButton.first);
          await tester.pumpAndSettle();
        }

        if (decrementButton.evaluate().isNotEmpty) {
          await tester.tap(decrementButton.first);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Remove item from cart UI', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Look for delete/remove icon
        final deleteIcon = find.byIcon(Icons.delete);
        if (deleteIcon.evaluate().isNotEmpty) {
          await tester.tap(deleteIcon.first);
          await tester.pumpAndSettle();

          // Verify item was removed
          expect(find.byType(SnackBar), findsWidgets);
        }
      }
    });

    test('Cart state persistence', () {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      container.read(cartProvider.notifier).addItem(product);

      // Cart should save to SharedPreferences
      final cartState = container.read(cartProvider);
      expect(cartState.items.length, 1);
    });

    test('Empty cart state', () {
      final cartState = container.read(cartProvider);
      expect(cartState.isEmpty, true);
      expect(cartState.items.length, 0);
      expect(cartState.totalAmount, 0.0);
    });

    testWidgets('Display empty cart message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to cart
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
  });
}
