import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/services/product_service.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/category_model.dart';

void main() {
  group('ProductService Tests', () {
    late ProductService service;

    setUp(() {
      service = ProductService();
    });

    group('getCategories', () {
      test('should return list of categories', () async {
        final categories = await service.getCategories();

        expect(categories, isNotEmpty);
        expect(categories, isA<List<Category>>());
      });

      test('should return exactly 6 categories', () async {
        final categories = await service.getCategories();

        expect(categories.length, 6);
      });

      test('should return categories with correct IDs', () async {
        final categories = await service.getCategories();

        final categoryIds = categories.map((c) => c.id).toList();

        expect(categoryIds, contains('electronics'));
        expect(categoryIds, contains('clothing'));
        expect(categoryIds, contains('shoes'));
        expect(categoryIds, contains('accessories'));
        expect(categoryIds, contains('sports'));
        expect(categoryIds, contains('home'));
      });

      test('should return categories with correct names', () async {
        final categories = await service.getCategories();

        final categoryNames = categories.map((c) => c.name).toList();

        expect(categoryNames, contains('Electronics'));
        expect(categoryNames, contains('Clothing'));
        expect(categoryNames, contains('Shoes'));
        expect(categoryNames, contains('Accessories'));
        expect(categoryNames, contains('Sports'));
        expect(categoryNames, contains('Home & Garden'));
      });

      test('should return categories with icon names', () async {
        final categories = await service.getCategories();

        for (final category in categories) {
          expect(category.iconName, isNotEmpty);
          expect(category.iconName, isA<String>());
        }
      });

      test('should return categories with image URLs', () async {
        final categories = await service.getCategories();

        for (final category in categories) {
          expect(category.imageUrl, isNotEmpty);
          expect(category.imageUrl, contains('http'));
        }
      });

      test('should simulate network delay', () async {
        final stopwatch = Stopwatch()..start();
        await service.getCategories();
        stopwatch.stop();

        // Should take at least 500ms due to network delay
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(500));
      });

      test('should return same categories on multiple calls', () async {
        final categories1 = await service.getCategories();
        final categories2 = await service.getCategories();

        expect(categories1.length, categories2.length);

        for (int i = 0; i < categories1.length; i++) {
          expect(categories1[i].id, categories2[i].id);
          expect(categories1[i].name, categories2[i].name);
        }
      });
    });

    group('getProducts', () {
      test('should return list of products', () async {
        final products = await service.getProducts();

        expect(products, isNotEmpty);
        expect(products, isA<List<Product>>());
      });

      test('should return exactly 15 products', () async {
        final products = await service.getProducts();

        expect(products.length, 15);
      });

      test('should return products with required fields', () async {
        final products = await service.getProducts();

        for (final product in products) {
          expect(product.id, isNotEmpty);
          expect(product.name, isNotEmpty);
          expect(product.description, isNotEmpty);
          expect(product.price, greaterThan(0));
          expect(product.imageUrl, isNotEmpty);
          expect(product.images, isNotEmpty);
          expect(product.category, isNotEmpty);
          expect(product.brand, isNotEmpty);
        }
      });

      test('should return products across all 6 categories', () async {
        final products = await service.getProducts();

        final categories = products.map((p) => p.category).toSet();

        expect(categories, contains('electronics'));
        expect(categories, contains('clothing'));
        expect(categories, contains('shoes'));
        expect(categories, contains('accessories'));
        expect(categories, contains('sports'));
        expect(categories, contains('home'));
      });

      test('should return at least 3 electronics products', () async {
        final products = await service.getProducts();

        final electronicsProducts =
            products.where((p) => p.category == 'electronics').toList();

        expect(electronicsProducts.length, greaterThanOrEqualTo(3));
      });

      test('should return products with valid ratings', () async {
        final products = await service.getProducts();

        for (final product in products) {
          expect(product.rating, greaterThanOrEqualTo(0));
          expect(product.rating, lessThanOrEqualTo(5));
        }
      });

      test('should return products with review counts', () async {
        final products = await service.getProducts();

        for (final product in products) {
          expect(product.reviewCount, greaterThanOrEqualTo(0));
        }
      });

      test('should return some products with discounts', () async {
        final products = await service.getProducts();

        final discountedProducts =
            products.where((p) => p.hasDiscount).toList();

        expect(discountedProducts, isNotEmpty);
      });

      test('should return products with originalPrice when discounted', () async {
        final products = await service.getProducts();

        for (final product in products) {
          if (product.originalPrice != null) {
            expect(product.originalPrice!, greaterThan(product.price));
          }
        }
      });

      test('should return clothing products with sizes', () async {
        final products = await service.getProducts();

        final clothingProducts =
            products.where((p) => p.category == 'clothing').toList();

        for (final product in clothingProducts) {
          expect(product.sizes, isNotEmpty);
        }
      });

      test('should return products with colors', () async {
        final products = await service.getProducts();

        final productsWithColors =
            products.where((p) => p.colors.isNotEmpty).toList();

        expect(productsWithColors, isNotEmpty);
      });

      test('should simulate network delay', () async {
        final stopwatch = Stopwatch()..start();
        await service.getProducts();
        stopwatch.stop();

        // Should take at least 500ms due to network delay
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(500));
      });

      test('should return same products on multiple calls', () async {
        final products1 = await service.getProducts();
        final products2 = await service.getProducts();

        expect(products1.length, products2.length);

        for (int i = 0; i < products1.length; i++) {
          expect(products1[i].id, products2[i].id);
          expect(products1[i].name, products2[i].name);
        }
      });

      test('should have unique product IDs', () async {
        final products = await service.getProducts();

        final productIds = products.map((p) => p.id).toList();
        final uniqueIds = productIds.toSet();

        expect(productIds.length, equals(uniqueIds.length));
      });

      test('should return specific known products', () async {
        final products = await service.getProducts();

        final productNames = products.map((p) => p.name).toList();

        expect(productNames, contains('Wireless Headphones'));
        expect(productNames, contains('Smart Watch Pro'));
        expect(productNames, contains('Cotton T-Shirt'));
        expect(productNames, contains('Running Shoes'));
        expect(productNames, contains('Yoga Mat'));
        expect(productNames, contains('Coffee Maker'));
      });
    });

    group('getProductById', () {
      test('should return product when ID exists', () async {
        final product = await service.getProductById('1');

        expect(product, isNotNull);
        expect(product!.id, '1');
      });

      test('should return correct product for valid ID', () async {
        final product = await service.getProductById('1');

        expect(product, isNotNull);
        expect(product!.name, 'Wireless Headphones');
        expect(product.category, 'electronics');
      });

      test('should return null when ID does not exist', () async {
        final product = await service.getProductById('999');

        expect(product, isNull);
      });

      test('should return null for empty ID', () async {
        final product = await service.getProductById('');

        expect(product, isNull);
      });

      test('should return null for invalid ID format', () async {
        final product = await service.getProductById('invalid-id-xyz');

        expect(product, isNull);
      });

      test('should return different products for different IDs', () async {
        final product1 = await service.getProductById('1');
        final product2 = await service.getProductById('2');

        expect(product1, isNotNull);
        expect(product2, isNotNull);
        expect(product1!.id, isNot(equals(product2!.id)));
        expect(product1.name, isNot(equals(product2.name)));
      });

      test('should return products for all valid IDs (1-15)', () async {
        for (int i = 1; i <= 15; i++) {
          final product = await service.getProductById('$i');
          expect(product, isNotNull);
          expect(product!.id, '$i');
        }
      });

      test('should simulate network delay', () async {
        final stopwatch = Stopwatch()..start();
        await service.getProductById('1');
        stopwatch.stop();

        // Should take at least 500ms due to network delay
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(500));
      });

      test('should return same product on multiple calls with same ID', () async {
        final product1 = await service.getProductById('5');
        final product2 = await service.getProductById('5');

        expect(product1, isNotNull);
        expect(product2, isNotNull);
        expect(product1!.id, product2!.id);
        expect(product1.name, product2.name);
        expect(product1.price, product2.price);
      });

      test('should return product with complete data', () async {
        final product = await service.getProductById('1');

        expect(product, isNotNull);
        expect(product!.id, isNotEmpty);
        expect(product.name, isNotEmpty);
        expect(product.description, isNotEmpty);
        expect(product.price, greaterThan(0));
        expect(product.imageUrl, isNotEmpty);
        expect(product.images, isNotEmpty);
        expect(product.category, isNotEmpty);
        expect(product.brand, isNotEmpty);
      });

      test('should return discounted product with originalPrice', () async {
        final product = await service.getProductById('1');

        expect(product, isNotNull);
        expect(product!.originalPrice, isNotNull);
        expect(product.hasDiscount, isTrue);
      });

      test('should handle concurrent requests', () async {
        final futures = [
          service.getProductById('1'),
          service.getProductById('2'),
          service.getProductById('3'),
          service.getProductById('4'),
          service.getProductById('5'),
        ];

        final results = await Future.wait(futures);

        expect(results.length, 5);
        for (final product in results) {
          expect(product, isNotNull);
        }
      });
    });

    group('Integration Tests', () {
      test('should have matching category IDs between getCategories and getProducts', () async {
        final categories = await service.getCategories();
        final products = await service.getProducts();

        final categoryIds = categories.map((c) => c.id).toSet();
        final productCategoryIds = products.map((p) => p.category).toSet();

        for (final productCategoryId in productCategoryIds) {
          expect(categoryIds, contains(productCategoryId),
              reason: 'Product category $productCategoryId should exist in categories');
        }
      });

      test('should have products for each category', () async {
        final categories = await service.getCategories();
        final products = await service.getProducts();

        for (final category in categories) {
          final categoryProducts =
              products.where((p) => p.category == category.id).toList();

          expect(categoryProducts, isNotEmpty,
              reason: 'Category ${category.name} should have at least one product');
        }
      });

      test('should return valid products from getProductById that match getProducts', () async {
        final products = await service.getProducts();
        final firstProduct = products.first;

        final productById = await service.getProductById(firstProduct.id);

        expect(productById, isNotNull);
        expect(productById!.id, firstProduct.id);
        expect(productById.name, firstProduct.name);
        expect(productById.price, firstProduct.price);
      });
    });
  });
}
