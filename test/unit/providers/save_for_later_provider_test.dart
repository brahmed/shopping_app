import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/save_for_later_provider.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('SaveForLaterProvider Tests', () {
    late ProviderContainer container;
    late Product testProduct1;
    late Product testProduct2;

    setUp() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testProduct1 = Product(
        id: 'prod1',
        name: 'Product 1',
        description: 'Description 1',
        price: 99.99,
        imageUrl: 'img1.jpg',
        images: ['img1.jpg'],
        category: 'electronics',
        brand: 'Brand1',
      );

      testProduct2 = Product(
        id: 'prod2',
        name: 'Product 2',
        description: 'Description 2',
        price: 49.99,
        imageUrl: 'img2.jpg',
        images: ['img2.jpg'],
        category: 'clothing',
        brand: 'Brand2',
      );

      await Future.delayed(const Duration(milliseconds: 100));
    }

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(saveForLaterProvider);

        expect(state.items, isEmpty);
        expect(state.isLoading, false);
        expect(state.itemCount, 0);
        expect(state.isEmpty, true);
        expect(state.isNotEmpty, false);
        expect(state.totalValue, 0.0);
      });
    });

    group('Add Item', () {
      test('should add item to save for later', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.length, 1);
        expect(state.items.first.product.id, testProduct1.id);
        expect(state.items.first.quantity, 1);
      });

      test('should add item with custom quantity', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, quantity: 3);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.first.quantity, 3);
      });

      test('should add item with size and color', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.first.selectedSize, 'M');
        expect(state.items.first.selectedColor, 'Red');
      });

      test('should increment quantity for existing item', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, quantity: 2);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.addItem(testProduct1, quantity: 3);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.length, 1);
        expect(state.items.first.quantity, 5);
      });
    });

    group('Remove Item', () {
      test('should remove item', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.removeItem(testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items, isEmpty);
      });

      test('should remove item with matching size and color', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await notifier.addItem(testProduct1, size: 'L', color: 'Blue');
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.removeItem(testProduct1.id, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.length, 1);
        expect(state.items.first.selectedSize, 'L');
      });
    });

    group('Update Quantity', () {
      test('should update item quantity', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateQuantity(testProduct1.id, 5);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.first.quantity, 5);
      });

      test('should remove item when quantity is zero', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateQuantity(testProduct1.id, 0);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items, isEmpty);
      });

      test('should remove item when quantity is negative', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateQuantity(testProduct1.id, -1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items, isEmpty);
      });
    });

    group('Clear All', () {
      test('should clear all items', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.clearAll();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items, isEmpty);
      });
    });

    group('Queries', () {
      test('should check if product is saved for later', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isInSaveForLater(testProduct1.id), true);
        expect(notifier.isInSaveForLater('non_existent'), false);
      });

      test('should get item', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, size: 'M', color: 'Red');
        await Future.delayed(const Duration(milliseconds: 50));

        final item = notifier.getItem(testProduct1.id, size: 'M', color: 'Red');

        expect(item, isNotNull);
        expect(item?.product.id, testProduct1.id);
      });

      test('should return null for non-existent item', () {
        final notifier = container.read(saveForLaterProvider.notifier);

        final item = notifier.getItem('non_existent');

        expect(item, isNull);
      });
    });

    group('State Getters', () {
      test('should calculate item count', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await notifier.addItem(testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(saveForLaterProvider);
        expect(state.itemCount, 2);
      });

      test('should calculate total value', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, quantity: 2); // 99.99 * 2
        await notifier.addItem(testProduct2, quantity: 1); // 49.99 * 1
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(saveForLaterProvider);
        expect(state.totalValue, closeTo(249.97, 0.01));
      });

      test('should check isEmpty', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        expect(container.read(saveForLaterProvider).isEmpty, true);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(saveForLaterProvider).isEmpty, false);
        expect(container.read(saveForLaterProvider).isNotEmpty, true);
      });
    });

    group('Persistence', () {
      test('should save items to SharedPreferences', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('save_for_later'), isNotNull);
      });

      test('should load items from SharedPreferences', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(saveForLaterProvider);
        expect(state.items, isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle multiple items with same product but different variants', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, size: 'S', color: 'Red');
        await notifier.addItem(testProduct1, size: 'M', color: 'Blue');
        await notifier.addItem(testProduct1, size: 'L', color: 'Green');
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(saveForLaterProvider);
        expect(state.items.length, 3);
      });

      test('should handle large quantities', () async {
        final notifier = container.read(saveForLaterProvider.notifier);

        await notifier.addItem(testProduct1, quantity: 999);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(saveForLaterProvider);
        expect(state.items.first.quantity, 999);
      });
    });
  });
}
