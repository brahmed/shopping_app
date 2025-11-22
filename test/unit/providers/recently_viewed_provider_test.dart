import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/recently_viewed_provider.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('RecentlyViewedProvider Tests', () {
    late ProviderContainer container;
    late List<Product> testProducts;

    setUp() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testProducts = List.generate(
        25,
        (i) => Product(
          id: 'prod$i',
          name: 'Product $i',
          description: 'Description $i',
          price: 10.0 * (i + 1),
          imageUrl: 'img$i.jpg',
          images: ['img$i.jpg'],
          category: 'category${i % 3}',
          brand: 'Brand${i % 5}',
        ),
      );

      await Future.delayed(const Duration(milliseconds: 100));
    }

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(recentlyViewedProvider);

        expect(state.products, isEmpty);
        expect(state.isLoading, false);
        expect(state.isEmpty, true);
        expect(state.isNotEmpty, false);
        expect(state.count, 0);
      });
    });

    group('Add Product', () {
      test('should add product to recently viewed', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 1);
        expect(state.products.first.id, testProducts[0].id);
      });

      test('should add product at the beginning', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.first.id, testProducts[1].id);
      });

      test('should move existing product to front when added again', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await notifier.addProduct(testProducts[2]);
        await Future.delayed(const Duration(milliseconds: 100));

        // Add testProducts[0] again
        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.first.id, testProducts[0].id);
        expect(state.products.length, 3); // Should still be 3
      });

      test('should limit to maximum 20 products', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        // Add 25 products
        for (var product in testProducts) {
          await notifier.addProduct(product);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 20); // Should be limited to 20
      });

      test('should keep most recent 20 products', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        // Add 25 products
        for (var product in testProducts) {
          await notifier.addProduct(product);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(recentlyViewedProvider);
        // Last product added should be first
        expect(state.products.first.id, testProducts.last.id);
        // First product should not be in the list (exceeded limit)
        expect(state.products.any((p) => p.id == testProducts[0].id), false);
      });
    });

    group('Remove Product', () {
      test('should remove product from recently viewed', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.removeProduct(testProducts[0].id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products, isEmpty);
      });

      test('should remove correct product from multiple', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await notifier.addProduct(testProducts[2]);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.removeProduct(testProducts[1].id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 2);
        expect(state.products.any((p) => p.id == testProducts[1].id), false);
        expect(state.products.any((p) => p.id == testProducts[0].id), true);
        expect(state.products.any((p) => p.id == testProducts[2].id), true);
      });

      test('should handle removing non-existent product', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.removeProduct('non_existent');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 1);
      });
    });

    group('Clear All', () {
      test('should clear all products', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await notifier.addProduct(testProducts[2]);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.clearAll();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products, isEmpty);
        expect(state.isEmpty, true);
      });

      test('should handle clearing when already empty', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.clearAll();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        expect(state.products, isEmpty);
      });
    });

    group('Has Viewed', () {
      test('should check if product has been viewed', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.hasViewed(testProducts[0].id), true);
        expect(notifier.hasViewed('non_existent'), false);
      });

      test('should return false after product is removed', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.removeProduct(testProducts[0].id);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.hasViewed(testProducts[0].id), false);
      });
    });

    group('State Getters', () {
      test('should calculate count correctly', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await notifier.addProduct(testProducts[2]);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.count, 3);
      });

      test('should check isEmpty correctly', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        expect(container.read(recentlyViewedProvider).isEmpty, true);
        expect(container.read(recentlyViewedProvider).isNotEmpty, false);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(recentlyViewedProvider).isEmpty, false);
        expect(container.read(recentlyViewedProvider).isNotEmpty, true);
      });
    });

    group('Persistence', () {
      test('should save products to SharedPreferences', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('recently_viewed'), isNotNull);
      });

      test('should load products from SharedPreferences', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 2);
      });

      test('should persist order of products', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await notifier.addProduct(testProducts[1]);
        await notifier.addProduct(testProducts[2]);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.first.id, testProducts[2].id);
      });
    });

    group('Edge Cases', () {
      test('should handle rapid additions', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.addProduct(testProducts[i]);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 10);
      });

      test('should handle adding same product multiple times in quick succession', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        for (int i = 0; i < 5; i++) {
          notifier.addProduct(testProducts[0]);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 1);
      });

      test('should maintain product data integrity', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        await notifier.addProduct(testProducts[0]);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(recentlyViewedProvider);
        final viewedProduct = state.products.first;

        expect(viewedProduct.name, testProducts[0].name);
        expect(viewedProduct.price, testProducts[0].price);
        expect(viewedProduct.brand, testProducts[0].brand);
      });

      test('should handle products with similar names', () async {
        final notifier = container.read(recentlyViewedProvider.notifier);

        final similarProducts = [
          Product(
            id: '1',
            name: 'Product A',
            description: 'Desc',
            price: 10.0,
            imageUrl: 'img.jpg',
            images: ['img.jpg'],
            category: 'cat',
            brand: 'Brand',
          ),
          Product(
            id: '2',
            name: 'Product A',
            description: 'Desc',
            price: 20.0,
            imageUrl: 'img.jpg',
            images: ['img.jpg'],
            category: 'cat',
            brand: 'Brand',
          ),
        ];

        await notifier.addProduct(similarProducts[0]);
        await notifier.addProduct(similarProducts[1]);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(recentlyViewedProvider);
        expect(state.products.length, 2);
      });
    });
  });
}
