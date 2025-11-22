import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/comparison_provider.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('ComparisonProvider Tests', () {
    late ProviderContainer container;
    late List<Product> testProducts;

    setUp() {
      container = ProviderContainer();

      testProducts = List.generate(
        5,
        (i) => Product(
          id: 'prod$i',
          name: 'Product $i',
          description: 'Description $i',
          price: 100.0 + (i * 10),
          originalPrice: 120.0 + (i * 10),
          imageUrl: 'img$i.jpg',
          images: ['img$i.jpg'],
          category: 'electronics',
          brand: 'Brand ${i % 2}',
          rating: 4.0 + (i * 0.2),
          reviewCount: 10 + (i * 5),
          inStock: i % 2 == 0,
        ),
      );
    }

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(comparisonProvider);

        expect(state.products, isEmpty);
        expect(state.isEmpty, true);
        expect(state.isFull, false);
        expect(state.count, 0);
        expect(state.canCompare, false);
      });

      test('should have correct max products limit', () {
        expect(ComparisonState.maxProducts, 4);
      });
    });

    group('Add Product', () {
      test('should add product to comparison', () {
        final notifier = container.read(comparisonProvider.notifier);

        final result = notifier.addProduct(testProducts[0]);

        expect(result, true);
        final state = container.read(comparisonProvider);
        expect(state.products.length, 1);
        expect(state.products.first.id, testProducts[0].id);
      });

      test('should add multiple products', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);
        notifier.addProduct(testProducts[2]);

        final state = container.read(comparisonProvider);
        expect(state.products.length, 3);
        expect(state.canCompare, true);
      });

      test('should not add duplicate product', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        final result = notifier.addProduct(testProducts[0]);

        expect(result, false);
        final state = container.read(comparisonProvider);
        expect(state.products.length, 1);
      });

      test('should not add product when limit reached', () {
        final notifier = container.read(comparisonProvider.notifier);

        // Add 4 products (max limit)
        for (int i = 0; i < 4; i++) {
          notifier.addProduct(testProducts[i]);
        }

        final result = notifier.addProduct(testProducts[4]);

        expect(result, false);
        final state = container.read(comparisonProvider);
        expect(state.products.length, 4);
        expect(state.isFull, true);
      });
    });

    group('Remove Product', () {
      test('should remove product from comparison', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.removeProduct(testProducts[0].id);

        final state = container.read(comparisonProvider);
        expect(state.products, isEmpty);
      });

      test('should remove correct product from multiple', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);
        notifier.addProduct(testProducts[2]);

        notifier.removeProduct(testProducts[1].id);

        final state = container.read(comparisonProvider);
        expect(state.products.length, 2);
        expect(state.products.any((p) => p.id == testProducts[1].id), false);
        expect(state.products.any((p) => p.id == testProducts[0].id), true);
        expect(state.products.any((p) => p.id == testProducts[2].id), true);
      });

      test('should handle removing non-existent product', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.removeProduct('non_existent');

        final state = container.read(comparisonProvider);
        expect(state.products.length, 1);
      });
    });

    group('Clear All', () {
      test('should clear all products', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);
        notifier.addProduct(testProducts[2]);

        notifier.clearAll();

        final state = container.read(comparisonProvider);
        expect(state.products, isEmpty);
        expect(state.isEmpty, true);
        expect(state.canCompare, false);
      });
    });

    group('Is In Comparison', () {
      test('should check if product is in comparison', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        expect(notifier.isInComparison(testProducts[0].id), true);
        expect(notifier.isInComparison('non_existent'), false);
      });
    });

    group('Replace Product', () {
      test('should replace product at index', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);
        notifier.addProduct(testProducts[2]);

        notifier.replaceProduct(1, testProducts[3]);

        final state = container.read(comparisonProvider);
        expect(state.products[1].id, testProducts[3].id);
        expect(state.products.any((p) => p.id == testProducts[1].id), false);
      });

      test('should not replace with invalid index', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        notifier.replaceProduct(5, testProducts[1]); // Invalid index

        final state = container.read(comparisonProvider);
        expect(state.products.length, 1);
        expect(state.products.first.id, testProducts[0].id);
      });

      test('should not replace with negative index', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        notifier.replaceProduct(-1, testProducts[1]);

        final state = container.read(comparisonProvider);
        expect(state.products.length, 1);
        expect(state.products.first.id, testProducts[0].id);
      });
    });

    group('Get Comparison Data', () {
      test('should return empty map when no products', () {
        final notifier = container.read(comparisonProvider.notifier);

        final data = notifier.getComparisonData();

        expect(data, isEmpty);
      });

      test('should generate comparison data for products', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);

        final data = notifier.getComparisonData();

        expect(data['Names'], isNotEmpty);
        expect(data['Prices'], isNotEmpty);
        expect(data['Original Prices'], isNotEmpty);
        expect(data['Brands'], isNotEmpty);
        expect(data['Ratings'], isNotEmpty);
        expect(data['Reviews'], isNotEmpty);
        expect(data['In Stock'], isNotEmpty);
        expect(data['Discount'], isNotEmpty);
      });

      test('should include correct product names', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);

        final data = notifier.getComparisonData();

        expect(data['Names'], contains(testProducts[0].name));
        expect(data['Names'], contains(testProducts[1].name));
      });

      test('should format prices correctly', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        final data = notifier.getComparisonData();
        final prices = data['Prices'] as List;

        expect(prices.first, contains('\$'));
        expect(prices.first, contains('100.00'));
      });

      test('should show N/A for missing original price', () {
        final notifier = container.read(comparisonProvider.notifier);

        final productNoOriginal = Product(
          id: 'no_original',
          name: 'No Original',
          description: 'Desc',
          price: 50.0,
          imageUrl: 'img.jpg',
          images: ['img.jpg'],
          category: 'cat',
          brand: 'Brand',
        );

        notifier.addProduct(productNoOriginal);

        final data = notifier.getComparisonData();
        final originalPrices = data['Original Prices'] as List;

        expect(originalPrices.first, 'N/A');
      });

      test('should show discount percentage', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        final data = notifier.getComparisonData();
        final discounts = data['Discount'] as List;

        expect(discounts.first, contains('%'));
      });

      test('should show in stock status', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]); // in stock
        notifier.addProduct(testProducts[1]); // not in stock

        final data = notifier.getComparisonData();
        final stockStatus = data['In Stock'] as List;

        expect(stockStatus[0], 'Yes');
        expect(stockStatus[1], 'No');
      });

      test('should include review counts', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        final data = notifier.getComparisonData();
        final reviews = data['Reviews'] as List;

        expect(reviews.first, contains('reviews'));
      });

      test('should include star ratings', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);

        final data = notifier.getComparisonData();
        final ratings = data['Ratings'] as List;

        expect(ratings.first, contains('⭐'));
      });
    });

    group('State Getters', () {
      test('should count products correctly', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);

        final state = container.read(comparisonProvider);
        expect(state.count, 2);
      });

      test('should check isEmpty correctly', () {
        final notifier = container.read(comparisonProvider.notifier);

        expect(container.read(comparisonProvider).isEmpty, true);

        notifier.addProduct(testProducts[0]);

        expect(container.read(comparisonProvider).isEmpty, false);
      });

      test('should check isFull correctly', () {
        final notifier = container.read(comparisonProvider.notifier);

        expect(container.read(comparisonProvider).isFull, false);

        for (int i = 0; i < 4; i++) {
          notifier.addProduct(testProducts[i]);
        }

        expect(container.read(comparisonProvider).isFull, true);
      });

      test('should check canCompare correctly', () {
        final notifier = container.read(comparisonProvider.notifier);

        expect(container.read(comparisonProvider).canCompare, false);

        notifier.addProduct(testProducts[0]);
        expect(container.read(comparisonProvider).canCompare, false);

        notifier.addProduct(testProducts[1]);
        expect(container.read(comparisonProvider).canCompare, true);
      });
    });

    group('Edge Cases', () {
      test('should handle rapid additions', () {
        final notifier = container.read(comparisonProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.addProduct(testProducts[i % 5]);
        }

        final state = container.read(comparisonProvider);
        expect(state.products.length, lessThanOrEqualTo(4));
      });

      test('should handle products with no discount', () {
        final notifier = container.read(comparisonProvider.notifier);

        final noDiscountProduct = Product(
          id: 'no_discount',
          name: 'No Discount',
          description: 'Desc',
          price: 50.0,
          imageUrl: 'img.jpg',
          images: ['img.jpg'],
          category: 'cat',
          brand: 'Brand',
        );

        notifier.addProduct(noDiscountProduct);

        final data = notifier.getComparisonData();
        final discounts = data['Discount'] as List;

        expect(discounts.first, 'None');
      });

      test('should handle products from different categories', () {
        final notifier = container.read(comparisonProvider.notifier);

        final product1 = testProducts[0].copyWith(category: 'electronics');
        final product2 = testProducts[1].copyWith(category: 'clothing');

        notifier.addProduct(product1);
        notifier.addProduct(product2);

        final state = container.read(comparisonProvider);
        expect(state.products.length, 2);
      });

      test('should maintain product order', () {
        final notifier = container.read(comparisonProvider.notifier);

        notifier.addProduct(testProducts[0]);
        notifier.addProduct(testProducts[1]);
        notifier.addProduct(testProducts[2]);

        final state = container.read(comparisonProvider);
        expect(state.products[0].id, testProducts[0].id);
        expect(state.products[1].id, testProducts[1].id);
        expect(state.products[2].id, testProducts[2].id);
      });
    });
  });
}
