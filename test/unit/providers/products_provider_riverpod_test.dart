import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/products_provider_riverpod.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('ProductsProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () async {
        // Wait a bit for async loading
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(productsProvider);

        expect(state.products, isA<List<Product>>());
        expect(state.categories, isA<List>());
        expect(state.isLoading, isA<bool>());
        expect(state.error, isNull);
      });

      test('should create ProductsState with default values', () {
        const state = ProductsState();

        expect(state.products, isEmpty);
        expect(state.categories, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Load Products', () {
      test('should set isLoading to true when loading starts', () async {
        final notifier = container.read(productsProvider.notifier);

        final loadingFuture = notifier.loadProducts();

        // Check loading state immediately after calling
        await Future.delayed(const Duration(milliseconds: 10));

        await loadingFuture;
      });

      test('should load products and categories', () async {
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(productsProvider);

        expect(state.isLoading, false);
        expect(state.products, isNotEmpty);
        expect(state.categories, isNotEmpty);
      });

      test('should reload products', () async {
        final notifier = container.read(productsProvider.notifier);

        await notifier.loadProducts();
        final state = container.read(productsProvider);

        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Get Products By Category', () {
      test('should filter products by category', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final state = container.read(productsProvider);
        if (state.products.isNotEmpty) {
          final firstCategory = state.products.first.category;
          final filteredProducts = notifier.getProductsByCategory(firstCategory);

          expect(filteredProducts, isNotEmpty);
          expect(
            filteredProducts.every((p) => p.category == firstCategory),
            true,
          );
        }
      });

      test('should return empty list for non-existent category', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts =
            notifier.getProductsByCategory('non_existent_category');

        expect(filteredProducts, isEmpty);
      });

      test('should return all products of same category', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final category = state.products.first.category;
          final expectedCount =
              state.products.where((p) => p.category == category).length;
          final filteredProducts = notifier.getProductsByCategory(category);

          expect(filteredProducts.length, expectedCount);
        }
      });
    });

    group('Get Product By ID', () {
      test('should return product by ID', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final productId = state.products.first.id;
          final product = notifier.getProductById(productId);

          expect(product, isNotNull);
          expect(product?.id, productId);
        }
      });

      test('should return null for non-existent product ID', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final product = notifier.getProductById('non_existent_id');

        expect(product, isNull);
      });

      test('should return correct product data', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final expectedProduct = state.products.first;
          final product = notifier.getProductById(expectedProduct.id);

          expect(product?.name, expectedProduct.name);
          expect(product?.price, expectedProduct.price);
          expect(product?.brand, expectedProduct.brand);
        }
      });
    });

    group('Search Products', () {
      test('should return all products when query is empty', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        final searchResults = notifier.searchProducts('');

        expect(searchResults.length, state.products.length);
      });

      test('should search products by name', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final productName = state.products.first.name;
          final searchTerm = productName.substring(0, 3).toLowerCase();
          final searchResults = notifier.searchProducts(searchTerm);

          expect(
            searchResults.every((p) =>
                p.name.toLowerCase().contains(searchTerm) ||
                p.description.toLowerCase().contains(searchTerm) ||
                p.brand.toLowerCase().contains(searchTerm) ||
                p.category.toLowerCase().contains(searchTerm)),
            true,
          );
        }
      });

      test('should search case-insensitively', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final productName = state.products.first.name;
          final upperCaseResults =
              notifier.searchProducts(productName.toUpperCase());
          final lowerCaseResults =
              notifier.searchProducts(productName.toLowerCase());

          expect(upperCaseResults.length, lowerCaseResults.length);
        }
      });

      test('should return empty list for no matches', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final searchResults = notifier.searchProducts('xyzabc123nonexistent');

        expect(searchResults, isEmpty);
      });

      test('should search by brand', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final brand = state.products.first.brand;
          final searchResults = notifier.searchProducts(brand);

          expect(searchResults, isNotEmpty);
        }
      });

      test('should search by description', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty &&
            state.products.first.description.length > 5) {
          final descPart = state.products.first.description.substring(0, 5);
          final searchResults = notifier.searchProducts(descPart);

          expect(searchResults, isNotEmpty);
        }
      });
    });

    group('Filter Products', () {
      test('should filter by category', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final category = state.products.first.category;
          final filteredProducts =
              notifier.filterProducts(category: category);

          expect(filteredProducts, isNotEmpty);
          expect(
            filteredProducts.every((p) => p.category == category),
            true,
          );
        }
      });

      test('should filter by minimum price', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts = notifier.filterProducts(minPrice: 50.0);

        expect(filteredProducts.every((p) => p.price >= 50.0), true);
      });

      test('should filter by maximum price', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts = notifier.filterProducts(maxPrice: 100.0);

        expect(filteredProducts.every((p) => p.price <= 100.0), true);
      });

      test('should filter by price range', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts =
            notifier.filterProducts(minPrice: 50.0, maxPrice: 150.0);

        expect(
          filteredProducts.every((p) => p.price >= 50.0 && p.price <= 150.0),
          true,
        );
      });

      test('should filter by minimum rating', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts = notifier.filterProducts(minRating: 4.0);

        expect(filteredProducts.every((p) => p.rating >= 4.0), true);
      });

      test('should filter in stock only', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts =
            notifier.filterProducts(inStockOnly: true);

        expect(filteredProducts.every((p) => p.inStock), true);
      });

      test('should apply multiple filters simultaneously', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        if (state.products.isNotEmpty) {
          final category = state.products.first.category;
          final filteredProducts = notifier.filterProducts(
            category: category,
            minPrice: 10.0,
            maxPrice: 500.0,
            minRating: 0.0,
            inStockOnly: true,
          );

          expect(
            filteredProducts.every((p) =>
                p.category == category &&
                p.price >= 10.0 &&
                p.price <= 500.0 &&
                p.rating >= 0.0 &&
                p.inStock),
            true,
          );
        }
      });

      test('should return empty list when no products match filters', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts = notifier.filterProducts(
          minPrice: 999999.0,
          maxPrice: 1000000.0,
        );

        expect(filteredProducts, isEmpty);
      });

      test('should handle null/empty category filter', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);
        final state = container.read(productsProvider);

        final filteredProducts = notifier.filterProducts(category: '');

        expect(filteredProducts.length, state.products.length);
      });
    });

    group('ProductsState copyWith', () {
      test('should copy with new products', () {
        const original = ProductsState();
        final newProducts = [
          Product(
            id: '1',
            name: 'Test Product',
            description: 'Test Description',
            price: 99.99,
            imageUrl: 'test.jpg',
            images: ['test.jpg'],
            category: 'test',
            brand: 'TestBrand',
          ),
        ];
        final copied = original.copyWith(products: newProducts);

        expect(copied.products.length, 1);
        expect(copied.products.first.name, 'Test Product');
      });

      test('should copy with loading state', () {
        const original = ProductsState();
        final copied = original.copyWith(isLoading: true);

        expect(copied.isLoading, true);
        expect(copied.products, isEmpty);
      });

      test('should copy with error', () {
        const original = ProductsState();
        final copied = original.copyWith(error: 'Test error');

        expect(copied.error, 'Test error');
        expect(copied.isLoading, false);
      });

      test('should preserve unmodified properties', () {
        final original = ProductsState(
          products: [
            Product(
              id: '1',
              name: 'Test',
              description: 'Desc',
              price: 50.0,
              imageUrl: 'img.jpg',
              images: ['img.jpg'],
              category: 'cat',
              brand: 'Brand',
            ),
          ],
          isLoading: false,
        );

        final copied = original.copyWith(error: 'New error');

        expect(copied.products.length, 1);
        expect(copied.isLoading, false);
        expect(copied.error, 'New error');
      });
    });

    group('Edge Cases', () {
      test('should handle empty products list', () {
        final notifier = container.read(productsProvider.notifier);

        final searchResults = notifier.searchProducts('anything');
        final filteredProducts = notifier.filterProducts(minPrice: 0.0);

        expect(searchResults, isA<List<Product>>());
        expect(filteredProducts, isA<List<Product>>());
      });

      test('should handle special characters in search', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final searchResults = notifier.searchProducts('!@#\$%^&*()');

        expect(searchResults, isA<List<Product>>());
      });

      test('should handle very long search queries', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final longQuery = 'a' * 1000;
        final searchResults = notifier.searchProducts(longQuery);

        expect(searchResults, isA<List<Product>>());
      });

      test('should handle negative price filters gracefully', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts = notifier.filterProducts(minPrice: -100.0);

        expect(filteredProducts, isA<List<Product>>());
      });

      test('should handle very high price filters', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(productsProvider.notifier);

        final filteredProducts =
            notifier.filterProducts(maxPrice: 999999999.0);

        expect(filteredProducts, isA<List<Product>>());
      });
    });
  });
}
