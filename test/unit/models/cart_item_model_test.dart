import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('CartItem Model Tests', () {
    late Product testProduct;
    late CartItem testCartItem;

    setUp(() {
      testProduct = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 50.0,
        imageUrl: 'https://example.com/image.jpg',
        images: ['https://example.com/image.jpg'],
        category: 'Electronics',
        brand: 'Test Brand',
        sizes: ['S', 'M', 'L'],
        colors: ['Red', 'Blue'],
      );

      testCartItem = CartItem(
        product: testProduct,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Red',
      );
    });

    test('should create CartItem instance with all fields', () {
      expect(testCartItem.product, testProduct);
      expect(testCartItem.quantity, 2);
      expect(testCartItem.selectedSize, 'M');
      expect(testCartItem.selectedColor, 'Red');
    });

    test('should have default quantity of 1', () {
      final cartItem = CartItem(product: testProduct);
      expect(cartItem.quantity, 1);
    });

    test('should calculate totalPrice correctly', () {
      expect(testCartItem.totalPrice, 100.0); // 50.0 * 2
    });

    test('should update totalPrice when quantity changes', () {
      testCartItem.quantity = 3;
      expect(testCartItem.totalPrice, 150.0); // 50.0 * 3

      testCartItem.quantity = 1;
      expect(testCartItem.totalPrice, 50.0); // 50.0 * 1
    });

    test('should handle quantity of 0', () {
      testCartItem.quantity = 0;
      expect(testCartItem.totalPrice, 0.0);
    });

    test('should serialize to JSON correctly', () {
      final json = testCartItem.toJson();

      expect(json['quantity'], 2);
      expect(json['selectedSize'], 'M');
      expect(json['selectedColor'], 'Red');
      expect(json['product'], isA<Map<String, dynamic>>());
      expect(json['product']['id'], '1');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'product': {
          'id': '2',
          'name': 'JSON Product',
          'description': 'JSON Description',
          'price': 75.0,
          'imageUrl': 'json.jpg',
          'images': ['json.jpg'],
          'category': 'Clothing',
          'brand': 'JSON Brand',
        },
        'quantity': 5,
        'selectedSize': 'L',
        'selectedColor': 'Blue',
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.product.id, '2');
      expect(cartItem.product.name, 'JSON Product');
      expect(cartItem.quantity, 5);
      expect(cartItem.selectedSize, 'L');
      expect(cartItem.selectedColor, 'Blue');
    });

    test('should handle null optional fields', () {
      final cartItem = CartItem(product: testProduct);

      expect(cartItem.selectedSize, null);
      expect(cartItem.selectedColor, null);
    });

    test('should handle null optional fields in JSON', () {
      final json = {
        'product': {
          'id': '3',
          'name': 'Product',
          'description': 'Description',
          'price': 25.0,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'quantity': 1,
        'selectedSize': null,
        'selectedColor': null,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.selectedSize, null);
      expect(cartItem.selectedColor, null);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testCartItem.toJson();
      final recreatedCartItem = CartItem.fromJson(json);

      expect(recreatedCartItem.product.id, testCartItem.product.id);
      expect(recreatedCartItem.quantity, testCartItem.quantity);
      expect(recreatedCartItem.selectedSize, testCartItem.selectedSize);
      expect(recreatedCartItem.selectedColor, testCartItem.selectedColor);
      expect(recreatedCartItem.totalPrice, testCartItem.totalPrice);
    });

    test('should handle product with discount in totalPrice', () {
      final discountedProduct = Product(
        id: '4',
        name: 'Discounted',
        description: 'Test',
        price: 40.0,
        originalPrice: 50.0,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      final cartItem = CartItem(
        product: discountedProduct,
        quantity: 3,
      );

      // Should use current price, not original price
      expect(cartItem.totalPrice, 120.0); // 40.0 * 3
    });

    test('should handle large quantities', () {
      testCartItem.quantity = 100;
      expect(testCartItem.totalPrice, 5000.0); // 50.0 * 100
    });

    test('should handle decimal prices correctly', () {
      final product = Product(
        id: '5',
        name: 'Decimal Product',
        description: 'Test',
        price: 19.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      final cartItem = CartItem(
        product: product,
        quantity: 3,
      );

      expect(cartItem.totalPrice, closeTo(59.97, 0.01));
    });
  });
}
