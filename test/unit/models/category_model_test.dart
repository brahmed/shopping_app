import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/category_model.dart';

void main() {
  group('Category Model Tests', () {
    late Category testCategory;

    setUp(() {
      testCategory = Category(
        id: 'cat1',
        name: 'Electronics',
        iconName: 'laptop',
        imageUrl: 'https://example.com/electronics.jpg',
      );
    });

    test('should create Category instance with all fields', () {
      expect(testCategory.id, 'cat1');
      expect(testCategory.name, 'Electronics');
      expect(testCategory.iconName, 'laptop');
      expect(testCategory.imageUrl, 'https://example.com/electronics.jpg');
    });

    test('should serialize to JSON correctly', () {
      final json = testCategory.toJson();

      expect(json['id'], 'cat1');
      expect(json['name'], 'Electronics');
      expect(json['iconName'], 'laptop');
      expect(json['imageUrl'], 'https://example.com/electronics.jpg');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'cat2',
        'name': 'Clothing',
        'iconName': 'shirt',
        'imageUrl': 'https://example.com/clothing.jpg',
      };

      final category = Category.fromJson(json);

      expect(category.id, 'cat2');
      expect(category.name, 'Clothing');
      expect(category.iconName, 'shirt');
      expect(category.imageUrl, 'https://example.com/clothing.jpg');
    });

    test('should handle missing imageUrl with empty string default', () {
      final json = {
        'id': 'cat3',
        'name': 'Sports',
        'iconName': 'ball',
        'imageUrl': null,
      };

      final category = Category.fromJson(json);

      expect(category.imageUrl, '');
    });

    test('should preserve data through JSON round-trip', () {
      final json = testCategory.toJson();
      final recreatedCategory = Category.fromJson(json);

      expect(recreatedCategory.id, testCategory.id);
      expect(recreatedCategory.name, testCategory.name);
      expect(recreatedCategory.iconName, testCategory.iconName);
      expect(recreatedCategory.imageUrl, testCategory.imageUrl);
    });

    test('should handle special characters in names', () {
      final category = Category(
        id: 'cat4',
        name: 'Home & Garden',
        iconName: 'home-icon',
        imageUrl: 'test.jpg',
      );

      final json = category.toJson();
      final recreatedCategory = Category.fromJson(json);

      expect(recreatedCategory.name, 'Home & Garden');
    });

    test('should handle empty strings', () {
      final category = Category(
        id: '',
        name: '',
        iconName: '',
        imageUrl: '',
      );

      final json = category.toJson();
      final recreatedCategory = Category.fromJson(json);

      expect(recreatedCategory.id, '');
      expect(recreatedCategory.name, '');
      expect(recreatedCategory.iconName, '');
      expect(recreatedCategory.imageUrl, '');
    });
  });
}
