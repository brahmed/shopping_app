import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/favorites_provider_riverpod.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('FavoritesProvider Tests', () {
    late ProviderContainer container;
    late Product testProduct1;
    late Product testProduct2;
    late Product testProduct3;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testProduct1 = Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium wireless headphones',
        price: 99.99,
        imageUrl: 'headphones.jpg',
        images: ['headphones.jpg'],
        category: 'electronics',
        brand: 'AudioTech',
      );

      testProduct2 = Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Feature-rich smartwatch',
        price: 199.99,
        imageUrl: 'watch.jpg',
        images: ['watch.jpg'],
        category: 'electronics',
        brand: 'TechGear',
      );

      testProduct3 = Product(
        id: '3',
        name: 'Running Shoes',
        description: 'Comfortable running shoes',
        price: 79.99,
        imageUrl: 'shoes.jpg',
        images: ['shoes.jpg'],
        category: 'sports',
        brand: 'SportsFit',
      );

      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(favoritesProvider);

        expect(state.favorites, isEmpty);
        expect(state.isLoading, false);
        expect(state.count, 0);
        expect(state.isEmpty, true);
      });

      test('should create FavoritesState with default values', () {
        const state = FavoritesState();

        expect(state.favorites, isEmpty);
        expect(state.isLoading, false);
      });
    });

    group('Add Favorite', () {
      test('should add product to favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 1);
        expect(state.favorites.first.id, testProduct1.id);
      });

      test('should not add duplicate product', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 1);
      });

      test('should add multiple different products', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 3);
      });
    });

    group('Remove Favorite', () {
      test('should remove product from favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeFavorite(testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
      });

      test('should remove correct product when multiple exist', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        notifier.removeFavorite(testProduct2.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 2);
        expect(state.favorites.any((p) => p.id == testProduct2.id), false);
        expect(state.favorites.any((p) => p.id == testProduct1.id), true);
        expect(state.favorites.any((p) => p.id == testProduct3.id), true);
      });

      test('should handle removing non-existent product', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeFavorite('non_existent_id');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 1);
      });
    });

    group('Toggle Favorite', () {
      test('should add product when not in favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 1);
        expect(notifier.isFavorite(testProduct1.id), true);
      });

      test('should remove product when already in favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
        expect(notifier.isFavorite(testProduct1.id), false);
      });

      test('should toggle multiple times correctly', () async {
        final notifier = container.read(favoritesProvider.notifier);

        // Add
        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));
        expect(notifier.isFavorite(testProduct1.id), true);

        // Remove
        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));
        expect(notifier.isFavorite(testProduct1.id), false);

        // Add again
        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));
        expect(notifier.isFavorite(testProduct1.id), true);
      });
    });

    group('Is Favorite', () {
      test('should return true for favorited product', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isFavorite(testProduct1.id), true);
      });

      test('should return false for non-favorited product', () {
        final notifier = container.read(favoritesProvider.notifier);

        expect(notifier.isFavorite(testProduct1.id), false);
      });

      test('should return false after removal', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.removeFavorite(testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isFavorite(testProduct1.id), false);
      });
    });

    group('Clear Favorites', () {
      test('should clear all favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        notifier.clearFavorites();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
        expect(state.count, 0);
        expect(state.isEmpty, true);
      });

      test('should handle clearing empty favorites', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.clearFavorites();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
      });
    });

    group('State Getters', () {
      test('should calculate count correctly', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.count, 2);
      });

      test('should check isEmpty correctly', () async {
        final notifier = container.read(favoritesProvider.notifier);

        expect(container.read(favoritesProvider).isEmpty, true);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(favoritesProvider).isEmpty, false);

        notifier.clearFavorites();
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(favoritesProvider).isEmpty, true);
      });
    });

    group('Persistence', () {
      test('should save favorites to SharedPreferences', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        final favoritesData = prefs.getString('favorites');
        expect(favoritesData, isNotNull);
      });

      test('should load favorites from SharedPreferences', () async {
        final notifier1 = container.read(favoritesProvider.notifier);
        notifier1.addFavorite(testProduct1);
        notifier1.addFavorite(testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        // Create new container to simulate app restart
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 2);
      });

      test('should persist toggle operations', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.toggleFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final notifier2 = container.read(favoritesProvider.notifier);
        expect(notifier2.isFavorite(testProduct1.id), true);
      });

      test('should persist clear operation', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        notifier.clearFavorites();
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
      });
    });

    group('FavoritesState copyWith', () {
      test('should copy with new favorites', () {
        const original = FavoritesState();
        final copied = original.copyWith(favorites: [testProduct1]);

        expect(copied.favorites.length, 1);
        expect(copied.favorites.first.id, testProduct1.id);
      });

      test('should copy with loading state', () {
        const original = FavoritesState();
        final copied = original.copyWith(isLoading: true);

        expect(copied.isLoading, true);
        expect(copied.favorites, isEmpty);
      });

      test('should preserve unmodified properties', () {
        final original = FavoritesState(favorites: [testProduct1], isLoading: false);
        final copied = original.copyWith(isLoading: true);

        expect(copied.favorites.length, 1);
        expect(copied.isLoading, true);
      });
    });

    group('Edge Cases', () {
      test('should handle adding many products', () async {
        final notifier = container.read(favoritesProvider.notifier);

        for (int i = 0; i < 100; i++) {
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
          notifier.addFavorite(product);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 100);
      });

      test('should handle rapid toggle operations', () async {
        final notifier = container.read(favoritesProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.toggleFavorite(testProduct1);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        // After even number of toggles, should not be in favorites
        expect(notifier.isFavorite(testProduct1.id), false);
      });

      test('should handle rapid add/remove same product', () async {
        final notifier = container.read(favoritesProvider.notifier);

        for (int i = 0; i < 10; i++) {
          notifier.addFavorite(testProduct1);
          notifier.removeFavorite(testProduct1.id);
        }
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites, isEmpty);
      });

      test('should maintain favorites list order', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites[0].id, testProduct1.id);
        expect(state.favorites[1].id, testProduct2.id);
        expect(state.favorites[2].id, testProduct3.id);
      });

      test('should handle removing from middle of list', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.addFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        notifier.removeFavorite(testProduct2.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 2);
        expect(state.favorites[0].id, testProduct1.id);
        expect(state.favorites[1].id, testProduct3.id);
      });

      test('should handle products with same name but different IDs', () async {
        final notifier = container.read(favoritesProvider.notifier);

        final product1 = Product(
          id: '1',
          name: 'Same Name',
          description: 'Desc 1',
          price: 10.0,
          imageUrl: 'img1.jpg',
          images: ['img1.jpg'],
          category: 'cat',
          brand: 'Brand',
        );

        final product2 = Product(
          id: '2',
          name: 'Same Name',
          description: 'Desc 2',
          price: 20.0,
          imageUrl: 'img2.jpg',
          images: ['img2.jpg'],
          category: 'cat',
          brand: 'Brand',
        );

        notifier.addFavorite(product1);
        notifier.addFavorite(product2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 2);
      });
    });

    group('Combined Operations', () {
      test('should handle mixed operations', () async {
        final notifier = container.read(favoritesProvider.notifier);

        notifier.addFavorite(testProduct1);
        notifier.toggleFavorite(testProduct2);
        notifier.addFavorite(testProduct3);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(container.read(favoritesProvider).favorites.length, 3);

        notifier.removeFavorite(testProduct1.id);
        notifier.toggleFavorite(testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(favoritesProvider);
        expect(state.favorites.length, 1);
        expect(state.favorites.first.id, testProduct3.id);
      });
    });
  });
}
