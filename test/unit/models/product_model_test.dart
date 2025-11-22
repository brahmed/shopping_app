import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('Product Model Tests', () {
    late Product testProduct;
    late Product testProductWithDiscount;

    setUp(() {
      testProduct = Product(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
        images: ['https://example.com/image1.jpg', 'https://example.com/image2.jpg'],
        category: 'Electronics',
        brand: 'Test Brand',
      );

      testProductWithDiscount = Product(
        id: '2',
        name: 'Discounted Product',
        description: 'Discounted Description',
        price: 79.99,
        originalPrice: 99.99,
        imageUrl: 'https://example.com/discount.jpg',
        images: ['https://example.com/discount.jpg'],
        category: 'Clothing',
        rating: 4.5,
        reviewCount: 100,
        inStock: true,
        sizes: ['S', 'M', 'L'],
        colors: ['Red', 'Blue'],
        brand: 'Discount Brand',
      );
    });

    test('should create Product instance with required fields', () {
      expect(testProduct.id, '1');
      expect(testProduct.name, 'Test Product');
      expect(testProduct.description, 'Test Description');
      expect(testProduct.price, 99.99);
      expect(testProduct.imageUrl, 'https://example.com/image.jpg');
      expect(testProduct.category, 'Electronics');
      expect(testProduct.brand, 'Test Brand');
    });

    test('should have default values for optional fields', () {
      expect(testProduct.originalPrice, null);
      expect(testProduct.rating, 0.0);
      expect(testProduct.reviewCount, 0);
      expect(testProduct.inStock, true);
      expect(testProduct.sizes, isEmpty);
      expect(testProduct.colors, isEmpty);
    });

    test('should calculate discount percentage correctly', () {
      expect(testProduct.discountPercentage, 0);
      expect(testProductWithDiscount.discountPercentage, closeTo(20.0, 0.1));
    });

    test('should return 0 discount when originalPrice is null', () {
      expect(testProduct.hasDiscount, false);
      expect(testProduct.discountPercentage, 0);
    });

    test('should return 0 discount when originalPrice <= price', () {
      final product = Product(
        id: '3',
        name: 'Test',
        description: 'Test',
        price: 100.0,
        originalPrice: 90.0, // Less than price
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Test',
        brand: 'Test',
      );
      expect(product.discountPercentage, 0);
      expect(product.hasDiscount, false);
    });

    test('hasDiscount should return true when there is a discount', () {
      expect(testProductWithDiscount.hasDiscount, true);
    });

    test('should serialize to JSON correctly', () {
      final json = testProductWithDiscount.toJson();

      expect(json['id'], '2');
      expect(json['name'], 'Discounted Product');
      expect(json['description'], 'Discounted Description');
      expect(json['price'], 79.99);
      expect(json['originalPrice'], 99.99);
      expect(json['imageUrl'], 'https://example.com/discount.jpg');
      expect(json['images'], ['https://example.com/discount.jpg']);
      expect(json['category'], 'Clothing');
      expect(json['rating'], 4.5);
      expect(json['reviewCount'], 100);
      expect(json['inStock'], true);
      expect(json['sizes'], ['S', 'M', 'L']);
      expect(json['colors'], ['Red', 'Blue']);
      expect(json['brand'], 'Discount Brand');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': '3',
        'name': 'JSON Product',
        'description': 'JSON Description',
        'price': 49.99,
        'originalPrice': 59.99,
        'imageUrl': 'https://example.com/json.jpg',
        'images': ['https://example.com/json1.jpg', 'https://example.com/json2.jpg'],
        'category': 'Sports',
        'rating': 4.8,
        'reviewCount': 250,
        'inStock': false,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'White', 'Gray'],
        'brand': 'JSON Brand',
      };

      final product = Product.fromJson(json);

      expect(product.id, '3');
      expect(product.name, 'JSON Product');
      expect(product.description, 'JSON Description');
      expect(product.price, 49.99);
      expect(product.originalPrice, 59.99);
      expect(product.imageUrl, 'https://example.com/json.jpg');
      expect(product.images, ['https://example.com/json1.jpg', 'https://example.com/json2.jpg']);
      expect(product.category, 'Sports');
      expect(product.rating, 4.8);
      expect(product.reviewCount, 250);
      expect(product.inStock, false);
      expect(product.sizes, ['XS', 'S', 'M', 'L', 'XL']);
      expect(product.colors, ['Black', 'White', 'Gray']);
      expect(product.brand, 'JSON Brand');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': '4',
        'name': 'Minimal Product',
        'description': 'Minimal Description',
        'price': 25.0,
        'imageUrl': 'minimal.jpg',
        'category': 'Test',
        'brand': 'Test Brand',
      };

      final product = Product.fromJson(json);

      expect(product.id, '4');
      expect(product.originalPrice, null);
      expect(product.rating, 0.0);
      expect(product.reviewCount, 0);
      expect(product.inStock, true);
      expect(product.sizes, isEmpty);
      expect(product.colors, isEmpty);
      expect(product.images, ['minimal.jpg']); // Should default to imageUrl
    });

    test('should handle numeric types in JSON (int/double conversion)', () {
      final json = {
        'id': '5',
        'name': 'Numeric Test',
        'description': 'Test',
        'price': 100, // int instead of double
        'originalPrice': 120, // int instead of double
        'imageUrl': 'test.jpg',
        'images': ['test.jpg'],
        'category': 'Test',
        'rating': 5, // int instead of double
        'reviewCount': 50,
        'inStock': true,
        'brand': 'Test',
      };

      final product = Product.fromJson(json);

      expect(product.price, 100.0);
      expect(product.originalPrice, 120.0);
      expect(product.rating, 5.0);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testProductWithDiscount.toJson();
      final recreatedProduct = Product.fromJson(json);

      expect(recreatedProduct.id, testProductWithDiscount.id);
      expect(recreatedProduct.name, testProductWithDiscount.name);
      expect(recreatedProduct.description, testProductWithDiscount.description);
      expect(recreatedProduct.price, testProductWithDiscount.price);
      expect(recreatedProduct.originalPrice, testProductWithDiscount.originalPrice);
      expect(recreatedProduct.imageUrl, testProductWithDiscount.imageUrl);
      expect(recreatedProduct.images, testProductWithDiscount.images);
      expect(recreatedProduct.category, testProductWithDiscount.category);
      expect(recreatedProduct.rating, testProductWithDiscount.rating);
      expect(recreatedProduct.reviewCount, testProductWithDiscount.reviewCount);
      expect(recreatedProduct.inStock, testProductWithDiscount.inStock);
      expect(recreatedProduct.sizes, testProductWithDiscount.sizes);
      expect(recreatedProduct.colors, testProductWithDiscount.colors);
      expect(recreatedProduct.brand, testProductWithDiscount.brand);
    });

    test('should handle empty arrays in JSON', () {
      final json = {
        'id': '6',
        'name': 'Empty Arrays',
        'description': 'Test',
        'price': 50.0,
        'imageUrl': 'test.jpg',
        'images': <String>[],
        'category': 'Test',
        'sizes': <String>[],
        'colors': <String>[],
        'brand': 'Test',
      };

      final product = Product.fromJson(json);

      expect(product.images, isEmpty);
      expect(product.sizes, isEmpty);
      expect(product.colors, isEmpty);
    });

    test('should handle exact discount calculation edge cases', () {
      final product1 = Product(
        id: '1',
        name: 'Test',
        description: 'Test',
        price: 50.0,
        originalPrice: 100.0, // 50% discount
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      expect(product1.discountPercentage, 50.0);

      final product2 = Product(
        id: '2',
        name: 'Test',
        description: 'Test',
        price: 75.0,
        originalPrice: 100.0, // 25% discount
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Test',
        brand: 'Test',
      );

      expect(product2.discountPercentage, 25.0);
    });
  });
}
