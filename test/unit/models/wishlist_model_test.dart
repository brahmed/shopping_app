import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/wishlist_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('Wishlist Model Tests', () {
    late Wishlist testWishlist;
    late Product testProduct1;
    late Product testProduct2;
    late DateTime testCreatedAt;

    setUp(() {
      testCreatedAt = DateTime(2024, 1, 15, 10, 30);

      testProduct1 = Product(
        id: 'prod1',
        name: 'Product 1',
        description: 'Description 1',
        price: 99.99,
        imageUrl: 'https://example.com/prod1.jpg',
        images: ['https://example.com/prod1.jpg'],
        category: 'Electronics',
        brand: 'Brand A',
      );

      testProduct2 = Product(
        id: 'prod2',
        name: 'Product 2',
        description: 'Description 2',
        price: 49.99,
        imageUrl: 'https://example.com/prod2.jpg',
        images: ['https://example.com/prod2.jpg'],
        category: 'Clothing',
        brand: 'Brand B',
      );

      testWishlist = Wishlist(
        id: 'wishlist1',
        userId: 'user1',
        name: 'My Birthday Wishlist',
        type: WishlistType.birthday,
        products: [testProduct1, testProduct2],
        createdAt: testCreatedAt,
        isPrivate: false,
        description: 'Items I want for my birthday',
      );
    });

    test('should create Wishlist instance with all fields', () {
      expect(testWishlist.id, 'wishlist1');
      expect(testWishlist.userId, 'user1');
      expect(testWishlist.name, 'My Birthday Wishlist');
      expect(testWishlist.type, WishlistType.birthday);
      expect(testWishlist.products.length, 2);
      expect(testWishlist.createdAt, testCreatedAt);
      expect(testWishlist.isPrivate, false);
      expect(testWishlist.description, 'Items I want for my birthday');
    });

    test('should have default values for optional fields', () {
      final wishlist = Wishlist(
        id: 'wishlist2',
        userId: 'user2',
        name: 'Default Wishlist',
        type: WishlistType.general,
        createdAt: DateTime.now(),
      );

      expect(wishlist.products, isEmpty);
      expect(wishlist.isPrivate, false);
      expect(wishlist.description, null);
    });

    test('should calculate productCount correctly', () {
      expect(testWishlist.productCount, 2);

      final emptyWishlist = Wishlist(
        id: 'wishlist3',
        userId: 'user3',
        name: 'Empty',
        type: WishlistType.general,
        createdAt: DateTime.now(),
      );

      expect(emptyWishlist.productCount, 0);
    });

    test('should calculate totalValue correctly', () {
      expect(testWishlist.totalValue, 149.98); // 99.99 + 49.99
    });

    test('should calculate totalValue as 0 for empty wishlist', () {
      final emptyWishlist = Wishlist(
        id: 'wishlist4',
        userId: 'user4',
        name: 'Empty',
        type: WishlistType.general,
        createdAt: DateTime.now(),
      );

      expect(emptyWishlist.totalValue, 0.0);
    });

    test('should serialize to JSON correctly', () {
      final json = testWishlist.toJson();

      expect(json['id'], 'wishlist1');
      expect(json['userId'], 'user1');
      expect(json['name'], 'My Birthday Wishlist');
      expect(json['type'], WishlistType.birthday.index);
      expect(json['products'], isA<List>());
      expect(json['products'].length, 2);
      expect(json['createdAt'], testCreatedAt.toIso8601String());
      expect(json['isPrivate'], false);
      expect(json['description'], 'Items I want for my birthday');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'wishlist5',
        'userId': 'user5',
        'name': 'Wedding Registry',
        'type': WishlistType.wedding.index,
        'products': [
          {
            'id': 'prod3',
            'name': 'Product 3',
            'description': 'Description 3',
            'price': 199.99,
            'imageUrl': 'https://example.com/prod3.jpg',
            'images': ['https://example.com/prod3.jpg'],
            'category': 'Home',
            'brand': 'Brand C',
          },
        ],
        'createdAt': '2024-02-20T14:30:00.000',
        'isPrivate': true,
        'description': 'Our wedding registry',
      };

      final wishlist = Wishlist.fromJson(json);

      expect(wishlist.id, 'wishlist5');
      expect(wishlist.userId, 'user5');
      expect(wishlist.name, 'Wedding Registry');
      expect(wishlist.type, WishlistType.wedding);
      expect(wishlist.products.length, 1);
      expect(wishlist.products[0].id, 'prod3');
      expect(wishlist.isPrivate, true);
      expect(wishlist.description, 'Our wedding registry');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'wishlist6',
        'userId': 'user6',
        'name': 'Minimal Wishlist',
        'type': WishlistType.general.index,
        'createdAt': '2024-01-10T12:00:00.000',
      };

      final wishlist = Wishlist.fromJson(json);

      expect(wishlist.id, 'wishlist6');
      expect(wishlist.products, isEmpty);
      expect(wishlist.isPrivate, false);
      expect(wishlist.description, null);
    });

    test('should handle null products array in JSON', () {
      final json = {
        'id': 'wishlist7',
        'userId': 'user7',
        'name': 'Test',
        'type': WishlistType.general.index,
        'products': null,
        'createdAt': '2024-01-10T12:00:00.000',
      };

      final wishlist = Wishlist.fromJson(json);

      expect(wishlist.products, isEmpty);
    });

    test('should handle null isPrivate in JSON', () {
      final json = {
        'id': 'wishlist8',
        'userId': 'user8',
        'name': 'Test',
        'type': WishlistType.general.index,
        'createdAt': '2024-01-10T12:00:00.000',
        'isPrivate': null,
      };

      final wishlist = Wishlist.fromJson(json);

      expect(wishlist.isPrivate, false);
    });

    test('should copyWith correctly - updating single field', () {
      final updatedWishlist = testWishlist.copyWith(name: 'Updated Name');

      expect(updatedWishlist.name, 'Updated Name');
      expect(updatedWishlist.id, testWishlist.id);
      expect(updatedWishlist.userId, testWishlist.userId);
      expect(updatedWishlist.type, testWishlist.type);
      expect(updatedWishlist.products, testWishlist.products);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updatedWishlist = testWishlist.copyWith(
        name: 'New Name',
        isPrivate: true,
        description: 'New description',
      );

      expect(updatedWishlist.name, 'New Name');
      expect(updatedWishlist.isPrivate, true);
      expect(updatedWishlist.description, 'New description');
      expect(updatedWishlist.id, testWishlist.id);
      expect(updatedWishlist.type, testWishlist.type);
    });

    test('should copyWith correctly - updating products list', () {
      final newProduct = Product(
        id: 'prod3',
        name: 'Product 3',
        description: 'Description 3',
        price: 29.99,
        imageUrl: 'https://example.com/prod3.jpg',
        images: ['https://example.com/prod3.jpg'],
        category: 'Sports',
        brand: 'Brand C',
      );

      final updatedWishlist = testWishlist.copyWith(
        products: [newProduct],
      );

      expect(updatedWishlist.products.length, 1);
      expect(updatedWishlist.products[0].id, 'prod3');
      expect(updatedWishlist.totalValue, 29.99);
    });

    test('should copyWith correctly - no changes', () {
      final copiedWishlist = testWishlist.copyWith();

      expect(copiedWishlist.id, testWishlist.id);
      expect(copiedWishlist.userId, testWishlist.userId);
      expect(copiedWishlist.name, testWishlist.name);
      expect(copiedWishlist.type, testWishlist.type);
      expect(copiedWishlist.products, testWishlist.products);
      expect(copiedWishlist.createdAt, testWishlist.createdAt);
      expect(copiedWishlist.isPrivate, testWishlist.isPrivate);
      expect(copiedWishlist.description, testWishlist.description);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testWishlist.toJson();
      final recreatedWishlist = Wishlist.fromJson(json);

      expect(recreatedWishlist.id, testWishlist.id);
      expect(recreatedWishlist.userId, testWishlist.userId);
      expect(recreatedWishlist.name, testWishlist.name);
      expect(recreatedWishlist.type, testWishlist.type);
      expect(recreatedWishlist.products.length, testWishlist.products.length);
      expect(recreatedWishlist.createdAt.toIso8601String(),
          testWishlist.createdAt.toIso8601String());
      expect(recreatedWishlist.isPrivate, testWishlist.isPrivate);
      expect(recreatedWishlist.description, testWishlist.description);
    });

    test('should handle all WishlistType enum values', () {
      final types = [
        WishlistType.general,
        WishlistType.birthday,
        WishlistType.wedding,
        WishlistType.christmas,
        WishlistType.custom,
      ];

      for (final type in types) {
        final wishlist = Wishlist(
          id: 'test',
          userId: 'user',
          name: 'Test',
          type: type,
          createdAt: DateTime.now(),
        );

        final json = wishlist.toJson();
        final recreated = Wishlist.fromJson(json);

        expect(recreated.type, type);
      }
    });

    test('should handle empty products array', () {
      final wishlist = Wishlist(
        id: 'wishlist9',
        userId: 'user9',
        name: 'Empty',
        type: WishlistType.general,
        products: [],
        createdAt: DateTime.now(),
      );

      expect(wishlist.products, isEmpty);
      expect(wishlist.productCount, 0);
      expect(wishlist.totalValue, 0.0);

      final json = wishlist.toJson();
      final recreated = Wishlist.fromJson(json);

      expect(recreated.products, isEmpty);
      expect(recreated.productCount, 0);
    });

    test('should calculate totalValue with products of different prices', () {
      final product1 = Product(
        id: 'p1',
        name: 'Expensive',
        description: 'Desc',
        price: 999.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'Brand',
      );

      final product2 = Product(
        id: 'p2',
        name: 'Cheap',
        description: 'Desc',
        price: 0.01,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Misc',
        brand: 'Brand',
      );

      final wishlist = Wishlist(
        id: 'wishlist10',
        userId: 'user10',
        name: 'Mixed',
        type: WishlistType.general,
        products: [product1, product2],
        createdAt: DateTime.now(),
      );

      expect(wishlist.totalValue, 1000.00);
      expect(wishlist.productCount, 2);
    });

    test('should handle wishlist with many products', () {
      final products = List.generate(
        100,
        (index) => Product(
          id: 'prod$index',
          name: 'Product $index',
          description: 'Description $index',
          price: 10.0,
          imageUrl: 'test.jpg',
          images: ['test.jpg'],
          category: 'Test',
          brand: 'Brand',
        ),
      );

      final wishlist = Wishlist(
        id: 'wishlist11',
        userId: 'user11',
        name: 'Large Wishlist',
        type: WishlistType.general,
        products: products,
        createdAt: DateTime.now(),
      );

      expect(wishlist.productCount, 100);
      expect(wishlist.totalValue, 1000.0);

      final json = wishlist.toJson();
      final recreated = Wishlist.fromJson(json);

      expect(recreated.productCount, 100);
      expect(recreated.totalValue, 1000.0);
    });

    test('should handle special characters in name and description', () {
      final wishlist = Wishlist(
        id: 'wishlist12',
        userId: 'user12',
        name: 'Special !@#\$%^&*() Name',
        type: WishlistType.custom,
        createdAt: DateTime.now(),
        description: 'Description with special chars: <>&"\' ',
      );

      final json = wishlist.toJson();
      final recreated = Wishlist.fromJson(json);

      expect(recreated.name, wishlist.name);
      expect(recreated.description, wishlist.description);
    });
  });
}
