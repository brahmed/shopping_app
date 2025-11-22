import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/cart_provider_riverpod.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/cart_item_model.dart';

void main() {
  group('CartProvider Tests', () {
    late ProviderContainer container;
    late Product testProduct1;
    late Product testProduct2;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testProduct1 = Product(
        id: '1',
        name: 'Test Product 1',
        description: 'Description 1',
        price: 99.99,
        imageUrl: 'test1.jpg',
        images: ['test1.jpg'],
        category: 'electronics',
        brand: 'TestBrand',
        sizes: ['S', 'M', 'L'],
        colors: ['Red', 'Blue'],
      );

      testProduct2 = Product(
        id: '2',
        name: 'Test Product 2',
        description: 'Description 2',
        price: 49.99,
        imageUrl: 'test2.jpg',
        images: ['test2.jpg'],
        category: 'clothing',
        brand: 'BrandTest',
      );

      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(cartProvider);

        expect(state.items, isEmpty);
        expect(state.isLoading, false);
        expect(state.itemCount, 0);
        expect(state.totalItemsCount, 0);
        expect(state.totalAmount, 0.0);
        expect(state.isEmpty, true);
      });

      test('should create CartState with default values', () {
        const state = CartState();

        expect(state.items, isEmpty);
        expect(state.isLoading, false);
      });
    });

    group('Add Item', () {
      test('should add item to cart', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 1);
        expect(state.items.first.product.id, testProduct1.id);
        expect(state.items.first.quantity, 1);
      });

      test('should add item with size and color', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.selectedSize, 'M');
        expect(state.items.first.selectedColor, 'Red');
      });

      test('should increment quantity when adding same item', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 1);
        expect(state.items.first.quantity, 2);
      });

      test('should add as separate item when size differs', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, size: 'S');
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct1, size: 'M');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 2);
      });

      test('should add as separate item when color differs', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct1, color: 'Blue');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 2);
      });

      test('should add multiple different products', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 2);
      });
    });

    group('Remove Item', () {
      test('should remove item from cart', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeItem(testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
      });

      test('should remove correct item when multiple exist', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeItem(testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 1);
        expect(state.items.first.product.id, testProduct2.id);
      });

      test('should handle removing non-existent item', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeItem('non_existent_id');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.length, 1);
      });
    });

    group('Update Quantity', () {
      test('should update item quantity', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 5);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.quantity, 5);
      });

      test('should remove item when quantity set to zero', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 0);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
      });

      test('should remove item when quantity set to negative', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, -1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
      });

      test('should update quantity with size and color', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 3, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.quantity, 3);
      });

      test('should not update when size/color mismatch', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 5, size: 'L', color: 'Blue');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.quantity, 1); // Should remain unchanged
      });
    });

    group('Clear Cart', () {
      test('should clear all items from cart', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.clearCart();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
        expect(state.isEmpty, true);
      });

      test('should handle clearing empty cart', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.clearCart();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
      });
    });

    group('Cart Queries', () {
      test('should check if product is in cart', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isInCart(testProduct1.id), true);
        expect(notifier.isInCart('non_existent'), false);
      });

      test('should get product quantity', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 3);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.getProductQuantity(testProduct1.id), 3);
      });

      test('should return 0 for non-existent product quantity', () async {
        final notifier = container.read(cartProvider.notifier);

        expect(notifier.getProductQuantity('non_existent'), 0);
      });
    });

    group('Cart State Getters', () {
      test('should calculate item count', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.itemCount, 2);
      });

      test('should calculate total items count', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));
        notifier.updateQuantity(testProduct1.id, 3);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 50));
        notifier.updateQuantity(testProduct2.id, 2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.totalItemsCount, 5); // 3 + 2
      });

      test('should calculate total amount', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1); // 99.99
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addItem(testProduct2); // 49.99
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.totalAmount, closeTo(149.98, 0.01));
      });

      test('should calculate total amount with quantities', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1); // 99.99
        await Future.delayed(const Duration(milliseconds: 50));
        notifier.updateQuantity(testProduct1.id, 2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.totalAmount, closeTo(199.98, 0.01));
      });

      test('should check if cart is empty', () async {
        final notifier = container.read(cartProvider.notifier);

        expect(container.read(cartProvider).isEmpty, true);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(cartProvider).isEmpty, false);

        notifier.clearCart();
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(cartProvider).isEmpty, true);
      });
    });

    group('Persistence', () {
      test('should save cart to SharedPreferences', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        final cartData = prefs.getString('shopping_cart');
        expect(cartData, isNotNull);
      });

      test('should load cart from SharedPreferences', () async {
        // Add item and wait for save
        final notifier1 = container.read(cartProvider.notifier);
        notifier1.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        // Create new container to simulate app restart
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(cartProvider);
        expect(state.items, isNotEmpty);
      });

      test('should persist quantity updates', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 5);
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify persisted
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(cartProvider);
        expect(state.items.first.quantity, 5);
      });

      test('should persist cart clear', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.clearCart();
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        final cartData = prefs.getString('shopping_cart');
        expect(cartData, isNotNull);
      });
    });

    group('CartState copyWith', () {
      test('should copy with new items', () {
        final item = CartItem(product: testProduct1, quantity: 1);
        const original = CartState();
        final copied = original.copyWith(items: [item]);

        expect(copied.items.length, 1);
        expect(copied.items.first.product.id, testProduct1.id);
      });

      test('should copy with loading state', () {
        const original = CartState();
        final copied = original.copyWith(isLoading: true);

        expect(copied.isLoading, true);
        expect(copied.items, isEmpty);
      });

      test('should preserve unmodified properties', () {
        final item = CartItem(product: testProduct1, quantity: 2);
        final original = CartState(items: [item], isLoading: false);
        final copied = original.copyWith(isLoading: true);

        expect(copied.items.length, 1);
        expect(copied.isLoading, true);
      });
    });

    group('Edge Cases', () {
      test('should handle adding same product many times', () async {
        final notifier = container.read(cartProvider.notifier);

        for (int i = 0; i < 100; i++) {
          notifier.addItem(testProduct1);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(cartProvider);
        expect(state.items.length, 1);
        expect(state.items.first.quantity, 100);
      });

      test('should handle very large quantities', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.updateQuantity(testProduct1.id, 999999);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.quantity, 999999);
      });

      test('should handle many different products', () async {
        final notifier = container.read(cartProvider.notifier);

        for (int i = 0; i < 50; i++) {
          final product = Product(
            id: 'product_$i',
            name: 'Product $i',
            description: 'Description $i',
            price: 10.0 * i,
            imageUrl: 'test.jpg',
            images: ['test.jpg'],
            category: 'test',
            brand: 'TestBrand',
          );
          notifier.addItem(product);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(cartProvider);
        expect(state.items.length, 50);
      });

      test('should handle rapid add/remove operations', () async {
        final notifier = container.read(cartProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.addItem(testProduct1);
          notifier.removeItem(testProduct1.id);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(cartProvider);
        expect(state.items, isEmpty);
      });

      test('should handle null size and color', () async {
        final notifier = container.read(cartProvider.notifier);

        notifier.addItem(testProduct1, size: null, color: null);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(cartProvider);
        expect(state.items.first.selectedSize, isNull);
        expect(state.items.first.selectedColor, isNull);
      });
    });
  });
}
