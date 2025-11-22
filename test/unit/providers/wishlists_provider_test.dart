import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/wishlists_provider.dart';
import 'package:shopping_app/models/wishlist_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('WishlistsProvider Tests', () {
    late ProviderContainer container;
    late Product testProduct1;
    late Product testProduct2;

    setUp(() async {
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
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have default wishlist', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);

        expect(state.wishlists, isNotEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
        expect(state.selectedWishlistId, isNotNull);
      });

      test('should have correct initial values', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);

        expect(state.totalWishlists, greaterThanOrEqualTo(1));
        expect(state.defaultWishlist, isNotNull);
      });
    });

    group('Create Wishlist', () {
      test('should create new wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('Birthday Wishlist', WishlistType.birthday);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(wishlistsProvider);
        expect(state.wishlists.any((w) => w.name == 'Birthday Wishlist'), true);
      });

      test('should create wishlist with description', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist(
          'Wedding Wishlist',
          WishlistType.wedding,
          description: 'Our wedding registry',
        );
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(wishlistsProvider);
        final wishlist = state.wishlists.firstWhere((w) => w.name == 'Wedding Wishlist');
        expect(wishlist.description, 'Our wedding registry');
      });

      test('should create private wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist(
          'Private List',
          WishlistType.custom,
          isPrivate: true,
        );
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(wishlistsProvider);
        final wishlist = state.wishlists.firstWhere((w) => w.name == 'Private List');
        expect(wishlist.isPrivate, true);
      });
    });

    group('Delete Wishlist', () {
      test('should delete wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('To Delete', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.firstWhere((w) => w.name == 'To Delete').id;

        await notifier.deleteWishlist(wishlistId);
        await Future.delayed(const Duration(milliseconds: 50));

        final newState = container.read(wishlistsProvider);
        expect(newState.wishlists.any((w) => w.id == wishlistId), false);
      });

      test('should update selected wishlist when deleting current', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('Second List', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        final selectedId = state.selectedWishlistId;

        if (selectedId != null) {
          await notifier.deleteWishlist(selectedId);
          await Future.delayed(const Duration(milliseconds: 50));

          final newState = container.read(wishlistsProvider);
          expect(newState.selectedWishlistId, isNotNull);
        }
      });
    });

    group('Update Wishlist', () {
      test('should update wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlist = state.wishlists.first;

        final updatedWishlist = wishlist.copyWith(
          name: 'Updated Name',
          description: 'Updated description',
        );

        await notifier.updateWishlist(updatedWishlist);
        await Future.delayed(const Duration(milliseconds: 50));

        final newState = container.read(wishlistsProvider);
        final updated = newState.wishlists.firstWhere((w) => w.id == wishlist.id);
        expect(updated.name, 'Updated Name');
        expect(updated.description, 'Updated description');
      });
    });

    group('Select Wishlist', () {
      test('should select wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('New List', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        final newListId = state.wishlists.firstWhere((w) => w.name == 'New List').id;

        notifier.selectWishlist(newListId);

        final newState = container.read(wishlistsProvider);
        expect(newState.selectedWishlistId, newListId);
      });
    });

    group('Add Product To Wishlist', () {
      test('should add product to wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        final newState = container.read(wishlistsProvider);
        final wishlist = newState.wishlists.firstWhere((w) => w.id == wishlistId);
        expect(wishlist.products.any((p) => p.id == testProduct1.id), true);
      });

      test('should not add duplicate product', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final newState = container.read(wishlistsProvider);
        final wishlist = newState.wishlists.firstWhere((w) => w.id == wishlistId);
        final count = wishlist.products.where((p) => p.id == testProduct1.id).length;
        expect(count, 1);
      });

      test('should add multiple different products', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await notifier.addProductToWishlist(wishlistId, testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        final newState = container.read(wishlistsProvider);
        final wishlist = newState.wishlists.firstWhere((w) => w.id == wishlistId);
        expect(wishlist.products.length, 2);
      });
    });

    group('Remove Product From Wishlist', () {
      test('should remove product from wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.removeProductFromWishlist(wishlistId, testProduct1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final newState = container.read(wishlistsProvider);
        final wishlist = newState.wishlists.firstWhere((w) => w.id == wishlistId);
        expect(wishlist.products.any((p) => p.id == testProduct1.id), false);
      });
    });

    group('Move Product Between Wishlists', () {
      test('should move product between wishlists', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('List 2', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        final wishlist1Id = state.wishlists.first.id;
        final wishlist2Id = state.wishlists.last.id;

        await notifier.addProductToWishlist(wishlist1Id, testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.moveProductBetweenWishlists(wishlist1Id, wishlist2Id, testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final newState = container.read(wishlistsProvider);
        final w1 = newState.wishlists.firstWhere((w) => w.id == wishlist1Id);
        final w2 = newState.wishlists.firstWhere((w) => w.id == wishlist2Id);

        expect(w1.products.any((p) => p.id == testProduct1.id), false);
        expect(w2.products.any((p) => p.id == testProduct1.id), true);
      });
    });

    group('Product Checks', () {
      test('should check if product is in wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isProductInWishlist(wishlistId, testProduct1.id), true);
        expect(notifier.isProductInWishlist(wishlistId, 'non_existent'), false);
      });

      test('should check if product is in any wishlist', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.isProductInAnyWishlist(testProduct1.id), true);
        expect(notifier.isProductInAnyWishlist('non_existent'), false);
      });

      test('should get wishlists containing product', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('List 2', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        final wishlist1Id = state.wishlists.first.id;
        final wishlist2Id = state.wishlists.last.id;

        await notifier.addProductToWishlist(wishlist1Id, testProduct1);
        await notifier.addProductToWishlist(wishlist2Id, testProduct1);
        await Future.delayed(const Duration(milliseconds: 100));

        final wishlists = notifier.getWishlistsContainingProduct(testProduct1.id);
        expect(wishlists.length, 2);
      });
    });

    group('State Getters', () {
      test('should count total wishlists', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('List 1', WishlistType.general);
        await notifier.createWishlist('List 2', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        expect(state.totalWishlists, greaterThanOrEqualTo(3));
      });

      test('should count total products across wishlists', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);
        final wishlistId = state.wishlists.first.id;

        await notifier.addProductToWishlist(wishlistId, testProduct1);
        await notifier.addProductToWishlist(wishlistId, testProduct2);
        await Future.delayed(const Duration(milliseconds: 100));

        final newState = container.read(wishlistsProvider);
        expect(newState.totalProducts, greaterThanOrEqualTo(2));
      });

      test('should get selected wishlist', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(wishlistsProvider);

        expect(state.selectedWishlist, isNotNull);
      });
    });

    group('Wishlist Model', () {
      test('should calculate product count', () {
        final wishlist = Wishlist(
          id: 'w1',
          userId: 'user1',
          name: 'Test',
          type: WishlistType.general,
          products: [testProduct1, testProduct2],
          createdAt: DateTime.now(),
        );

        expect(wishlist.productCount, 2);
      });

      test('should calculate total value', () {
        final wishlist = Wishlist(
          id: 'w1',
          userId: 'user1',
          name: 'Test',
          type: WishlistType.general,
          products: [testProduct1, testProduct2],
          createdAt: DateTime.now(),
        );

        expect(wishlist.totalValue, closeTo(149.98, 0.01));
      });
    });

    group('Persistence', () {
      test('should save wishlists to SharedPreferences', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('New List', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('user_wishlists'), isNotNull);
      });

      test('should load wishlists from SharedPreferences', () async {
        final notifier = container.read(wishlistsProvider.notifier);

        await notifier.createWishlist('Saved List', WishlistType.general);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(wishlistsProvider);
        expect(state.wishlists.any((w) => w.name == 'Saved List'), true);
      });
    });
  });
}
