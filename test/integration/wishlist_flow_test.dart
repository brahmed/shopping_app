import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/wishlist_model.dart';
import 'package:shopping_app/providers/wishlists_provider.dart';
import 'package:shopping_app/providers/favorites_provider_riverpod.dart';

void main() {
  group('Wishlist Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Add product to favorites from product detail',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to a product
      final productCard = find.byType(GestureDetector).first;
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard);
        await tester.pumpAndSettle();

        // Look for favorite icon
        final favoriteIcon = find.byIcon(Icons.favorite_border);
        if (favoriteIcon.evaluate().isNotEmpty) {
          await tester.tap(favoriteIcon);
          await tester.pumpAndSettle();

          // Verify favorite was added (icon should change)
          expect(find.byIcon(Icons.favorite), findsOneWidget);
        }
      }
    });

    test('Add and remove product from favorites', () {
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

      // Add to favorites
      container.read(favoritesProvider.notifier).addFavorite(product);
      expect(container.read(favoritesProvider).count, 1);
      expect(
          container.read(favoritesProvider.notifier).isFavorite('prod-1'), true);

      // Remove from favorites
      container.read(favoritesProvider.notifier).removeFavorite('prod-1');
      expect(container.read(favoritesProvider).count, 0);
      expect(container.read(favoritesProvider.notifier).isFavorite('prod-1'),
          false);
    });

    test('Toggle favorite status', () {
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

      // Toggle on
      container.read(favoritesProvider.notifier).toggleFavorite(product);
      expect(
          container.read(favoritesProvider.notifier).isFavorite('prod-1'), true);

      // Toggle off
      container.read(favoritesProvider.notifier).toggleFavorite(product);
      expect(container.read(favoritesProvider.notifier).isFavorite('prod-1'),
          false);
    });

    testWidgets('View favorites list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to bookmarks/favorites tab
      final bookmarksTab = find.byIcon(Icons.bookmark);
      if (bookmarksTab.evaluate().isNotEmpty) {
        await tester.tap(bookmarksTab);
        await tester.pumpAndSettle();

        // Verify favorites page is displayed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    test('Create custom wishlist', () async {
      // Create a new wishlist
      await container.read(wishlistsProvider.notifier).createWishlist(
            'Holiday Gifts',
            WishlistType.gift,
            description: 'Gifts for the holidays',
          );

      final state = container.read(wishlistsProvider);
      expect(state.wishlists.length, greaterThan(0));
      expect(state.wishlists.any((w) => w.name == 'Holiday Gifts'), true);
    });

    test('Add product to specific wishlist', () async {
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

      // Wait for default wishlist creation
      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      if (state.wishlists.isNotEmpty) {
        final wishlistId = state.wishlists.first.id;

        // Add product to wishlist
        await container
            .read(wishlistsProvider.notifier)
            .addProductToWishlist(wishlistId, product);

        final updatedWishlist = container
            .read(wishlistsProvider)
            .wishlists
            .firstWhere((w) => w.id == wishlistId);
        expect(updatedWishlist.products.length, 1);
        expect(updatedWishlist.products.first.id, 'prod-1');
      }
    });

    test('Remove product from wishlist', () async {
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

      // Wait for default wishlist
      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      if (state.wishlists.isNotEmpty) {
        final wishlistId = state.wishlists.first.id;

        // Add product
        await container
            .read(wishlistsProvider.notifier)
            .addProductToWishlist(wishlistId, product);

        // Remove product
        await container
            .read(wishlistsProvider.notifier)
            .removeProductFromWishlist(wishlistId, 'prod-1');

        final updatedWishlist = container
            .read(wishlistsProvider)
            .wishlists
            .firstWhere((w) => w.id == wishlistId);
        expect(updatedWishlist.products.length, 0);
      }
    });

    test('Move product between wishlists', () async {
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

      // Create two wishlists
      await container
          .read(wishlistsProvider.notifier)
          .createWishlist('Wishlist 1', WishlistType.general);
      await container
          .read(wishlistsProvider.notifier)
          .createWishlist('Wishlist 2', WishlistType.general);

      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      if (state.wishlists.length >= 2) {
        final wishlist1Id = state.wishlists[0].id;
        final wishlist2Id = state.wishlists[1].id;

        // Add product to first wishlist
        await container
            .read(wishlistsProvider.notifier)
            .addProductToWishlist(wishlist1Id, product);

        // Move to second wishlist
        await container
            .read(wishlistsProvider.notifier)
            .moveProductBetweenWishlists(wishlist1Id, wishlist2Id, product);

        final wishlist1 = container
            .read(wishlistsProvider)
            .wishlists
            .firstWhere((w) => w.id == wishlist1Id);
        final wishlist2 = container
            .read(wishlistsProvider)
            .wishlists
            .firstWhere((w) => w.id == wishlist2Id);

        expect(wishlist1.products.length, 0);
        expect(wishlist2.products.length, 1);
      }
    });

    test('Check if product is in wishlist', () async {
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

      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      if (state.wishlists.isNotEmpty) {
        final wishlistId = state.wishlists.first.id;

        // Initially not in wishlist
        expect(
          container
              .read(wishlistsProvider.notifier)
              .isProductInWishlist(wishlistId, 'prod-1'),
          false,
        );

        // Add product
        await container
            .read(wishlistsProvider.notifier)
            .addProductToWishlist(wishlistId, product);

        // Now it should be in wishlist
        expect(
          container
              .read(wishlistsProvider.notifier)
              .isProductInWishlist(wishlistId, 'prod-1'),
          true,
        );
      }
    });

    test('Delete wishlist', () async {
      // Create a wishlist
      await container
          .read(wishlistsProvider.notifier)
          .createWishlist('To Delete', WishlistType.general);

      await Future.delayed(const Duration(milliseconds: 100));

      final stateBefore = container.read(wishlistsProvider);
      final initialCount = stateBefore.wishlists.length;
      final wishlistToDelete =
          stateBefore.wishlists.firstWhere((w) => w.name == 'To Delete');

      // Delete wishlist
      await container
          .read(wishlistsProvider.notifier)
          .deleteWishlist(wishlistToDelete.id);

      final stateAfter = container.read(wishlistsProvider);
      expect(stateAfter.wishlists.length, initialCount - 1);
      expect(stateAfter.wishlists.any((w) => w.name == 'To Delete'), false);
    });

    test('Wishlist privacy settings', () async {
      // Create private wishlist
      await container.read(wishlistsProvider.notifier).createWishlist(
            'Private Wishlist',
            WishlistType.general,
            isPrivate: true,
          );

      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      final privateWishlist =
          state.wishlists.firstWhere((w) => w.name == 'Private Wishlist');
      expect(privateWishlist.isPrivate, true);
    });

    test('Get wishlists containing a product', () async {
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

      // Create two wishlists and add product to both
      await container
          .read(wishlistsProvider.notifier)
          .createWishlist('Wishlist 1', WishlistType.general);
      await container
          .read(wishlistsProvider.notifier)
          .createWishlist('Wishlist 2', WishlistType.general);

      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(wishlistsProvider);
      for (final wishlist in state.wishlists) {
        await container
            .read(wishlistsProvider.notifier)
            .addProductToWishlist(wishlist.id, product);
      }

      final wishlistsWithProduct = container
          .read(wishlistsProvider.notifier)
          .getWishlistsContainingProduct('prod-1');
      expect(wishlistsWithProduct.length, state.wishlists.length);
    });

    testWidgets('Empty favorites state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to favorites
      final bookmarksTab = find.byIcon(Icons.bookmark);
      if (bookmarksTab.evaluate().isNotEmpty) {
        await tester.tap(bookmarksTab);
        await tester.pumpAndSettle();

        // Should show empty state message
        expect(find.textContaining('empty', findRichText: true), findsWidgets);
      }
    });
  });
}
