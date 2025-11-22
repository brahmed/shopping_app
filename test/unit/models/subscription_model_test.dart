import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/subscription_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('Subscription Model Tests', () {
    late Subscription testSubscription;
    late Product testProduct;
    late DateTime testStartDate;
    late DateTime testNextDeliveryDate;
    late DateTime testEndDate;

    setUp(() {
      testStartDate = DateTime(2024, 1, 1);
      testNextDeliveryDate = DateTime(2024, 2, 1);
      testEndDate = DateTime(2024, 12, 31);

      testProduct = Product(
        id: 'prod1',
        name: 'Coffee Beans',
        description: 'Premium coffee beans',
        price: 29.99,
        imageUrl: 'https://example.com/coffee.jpg',
        images: ['https://example.com/coffee.jpg'],
        category: 'Food',
        brand: 'Coffee Co',
      );

      testSubscription = Subscription(
        id: 'sub1',
        userId: 'user1',
        product: testProduct,
        quantity: 2,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: testStartDate,
        nextDeliveryDate: testNextDeliveryDate,
        endDate: testEndDate,
        discountPercentage: 10.0,
        selectedSize: 'Large',
        selectedColor: 'Dark Roast',
      );
    });

    test('should create Subscription instance with all fields', () {
      expect(testSubscription.id, 'sub1');
      expect(testSubscription.userId, 'user1');
      expect(testSubscription.product.id, 'prod1');
      expect(testSubscription.quantity, 2);
      expect(testSubscription.frequency, SubscriptionFrequency.monthly);
      expect(testSubscription.status, SubscriptionStatus.active);
      expect(testSubscription.startDate, testStartDate);
      expect(testSubscription.nextDeliveryDate, testNextDeliveryDate);
      expect(testSubscription.endDate, testEndDate);
      expect(testSubscription.discountPercentage, 10.0);
      expect(testSubscription.selectedSize, 'Large');
      expect(testSubscription.selectedColor, 'Dark Roast');
    });

    test('should have default values for optional fields', () {
      final subscription = Subscription(
        id: 'sub2',
        userId: 'user2',
        product: testProduct,
        frequency: SubscriptionFrequency.weekly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
      );

      expect(subscription.quantity, 1);
      expect(subscription.nextDeliveryDate, null);
      expect(subscription.endDate, null);
      expect(subscription.discountPercentage, 0.0);
      expect(subscription.selectedSize, null);
      expect(subscription.selectedColor, null);
    });

    test('should calculate discountedPrice correctly', () {
      expect(testSubscription.discountedPrice, closeTo(26.991, 0.01)); // 29.99 * 0.9
    });

    test('should calculate discountedPrice with no discount', () {
      final subscription = Subscription(
        id: 'sub3',
        userId: 'user3',
        product: testProduct,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
      );

      expect(subscription.discountedPrice, 29.99);
    });

    test('should calculate totalPrice correctly', () {
      expect(testSubscription.totalPrice, closeTo(53.982, 0.01)); // 26.991 * 2
    });

    test('should calculate totalPrice with quantity of 1', () {
      final subscription = Subscription(
        id: 'sub4',
        userId: 'user4',
        product: testProduct,
        quantity: 1,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
      );

      expect(subscription.totalPrice, 29.99);
    });

    test('should return correct frequencyString for weekly', () {
      final subscription = testSubscription.copyWith(
        frequency: SubscriptionFrequency.weekly,
      );
      expect(subscription.frequencyString, 'Weekly');
    });

    test('should return correct frequencyString for biweekly', () {
      final subscription = testSubscription.copyWith(
        frequency: SubscriptionFrequency.biweekly,
      );
      expect(subscription.frequencyString, 'Every 2 Weeks');
    });

    test('should return correct frequencyString for monthly', () {
      expect(testSubscription.frequencyString, 'Monthly');
    });

    test('should return correct frequencyString for bimonthly', () {
      final subscription = testSubscription.copyWith(
        frequency: SubscriptionFrequency.bimonthly,
      );
      expect(subscription.frequencyString, 'Every 2 Months');
    });

    test('should return correct frequencyString for quarterly', () {
      final subscription = testSubscription.copyWith(
        frequency: SubscriptionFrequency.quarterly,
      );
      expect(subscription.frequencyString, 'Quarterly');
    });

    test('should return correct statusString for active', () {
      expect(testSubscription.statusString, 'Active');
    });

    test('should return correct statusString for paused', () {
      final subscription = testSubscription.copyWith(
        status: SubscriptionStatus.paused,
      );
      expect(subscription.statusString, 'Paused');
    });

    test('should return correct statusString for cancelled', () {
      final subscription = testSubscription.copyWith(
        status: SubscriptionStatus.cancelled,
      );
      expect(subscription.statusString, 'Cancelled');
    });

    test('should return correct statusString for expired', () {
      final subscription = testSubscription.copyWith(
        status: SubscriptionStatus.expired,
      );
      expect(subscription.statusString, 'Expired');
    });

    test('should serialize to JSON correctly', () {
      final json = testSubscription.toJson();

      expect(json['id'], 'sub1');
      expect(json['userId'], 'user1');
      expect(json['product'], isA<Map<String, dynamic>>());
      expect(json['product']['id'], 'prod1');
      expect(json['quantity'], 2);
      expect(json['frequency'], SubscriptionFrequency.monthly.index);
      expect(json['status'], SubscriptionStatus.active.index);
      expect(json['startDate'], testStartDate.toIso8601String());
      expect(json['nextDeliveryDate'], testNextDeliveryDate.toIso8601String());
      expect(json['endDate'], testEndDate.toIso8601String());
      expect(json['discountPercentage'], 10.0);
      expect(json['selectedSize'], 'Large');
      expect(json['selectedColor'], 'Dark Roast');
    });

    test('should serialize to JSON with null optional fields', () {
      final subscription = Subscription(
        id: 'sub5',
        userId: 'user5',
        product: testProduct,
        frequency: SubscriptionFrequency.weekly,
        status: SubscriptionStatus.active,
        startDate: testStartDate,
      );

      final json = subscription.toJson();

      expect(json['nextDeliveryDate'], null);
      expect(json['endDate'], null);
      expect(json['selectedSize'], null);
      expect(json['selectedColor'], null);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'sub6',
        'userId': 'user6',
        'product': {
          'id': 'prod2',
          'name': 'Test Product',
          'description': 'Test Description',
          'price': 49.99,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test Brand',
        },
        'quantity': 3,
        'frequency': SubscriptionFrequency.biweekly.index,
        'status': SubscriptionStatus.paused.index,
        'startDate': '2024-01-15T00:00:00.000',
        'nextDeliveryDate': '2024-02-01T00:00:00.000',
        'endDate': '2024-12-31T00:00:00.000',
        'discountPercentage': 15.0,
        'selectedSize': 'Medium',
        'selectedColor': 'Blue',
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.id, 'sub6');
      expect(subscription.userId, 'user6');
      expect(subscription.product.id, 'prod2');
      expect(subscription.quantity, 3);
      expect(subscription.frequency, SubscriptionFrequency.biweekly);
      expect(subscription.status, SubscriptionStatus.paused);
      expect(subscription.discountPercentage, 15.0);
      expect(subscription.selectedSize, 'Medium');
      expect(subscription.selectedColor, 'Blue');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'sub7',
        'userId': 'user7',
        'product': {
          'id': 'prod3',
          'name': 'Test',
          'description': 'Test',
          'price': 19.99,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'frequency': SubscriptionFrequency.monthly.index,
        'status': SubscriptionStatus.active.index,
        'startDate': '2024-01-01T00:00:00.000',
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.quantity, 1);
      expect(subscription.nextDeliveryDate, null);
      expect(subscription.endDate, null);
      expect(subscription.discountPercentage, 0.0);
      expect(subscription.selectedSize, null);
      expect(subscription.selectedColor, null);
    });

    test('should handle null quantity in JSON', () {
      final json = {
        'id': 'sub8',
        'userId': 'user8',
        'product': {
          'id': 'prod4',
          'name': 'Test',
          'description': 'Test',
          'price': 19.99,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'quantity': null,
        'frequency': SubscriptionFrequency.monthly.index,
        'status': SubscriptionStatus.active.index,
        'startDate': '2024-01-01T00:00:00.000',
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.quantity, 1);
    });

    test('should handle null discountPercentage in JSON', () {
      final json = {
        'id': 'sub9',
        'userId': 'user9',
        'product': {
          'id': 'prod5',
          'name': 'Test',
          'description': 'Test',
          'price': 19.99,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'frequency': SubscriptionFrequency.monthly.index,
        'status': SubscriptionStatus.active.index,
        'startDate': '2024-01-01T00:00:00.000',
        'discountPercentage': null,
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.discountPercentage, 0.0);
    });

    test('should handle numeric types in JSON (int/double conversion)', () {
      final json = {
        'id': 'sub10',
        'userId': 'user10',
        'product': {
          'id': 'prod6',
          'name': 'Test',
          'description': 'Test',
          'price': 25,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'frequency': SubscriptionFrequency.monthly.index,
        'status': SubscriptionStatus.active.index,
        'startDate': '2024-01-01T00:00:00.000',
        'discountPercentage': 20,
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.discountPercentage, 20.0);
    });

    test('should copyWith correctly - updating single field', () {
      final updated = testSubscription.copyWith(quantity: 5);

      expect(updated.quantity, 5);
      expect(updated.id, testSubscription.id);
      expect(updated.userId, testSubscription.userId);
      expect(updated.status, testSubscription.status);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updated = testSubscription.copyWith(
        quantity: 3,
        status: SubscriptionStatus.paused,
        discountPercentage: 20.0,
      );

      expect(updated.quantity, 3);
      expect(updated.status, SubscriptionStatus.paused);
      expect(updated.discountPercentage, 20.0);
      expect(updated.id, testSubscription.id);
    });

    test('should copyWith correctly - no changes', () {
      final copied = testSubscription.copyWith();

      expect(copied.id, testSubscription.id);
      expect(copied.userId, testSubscription.userId);
      expect(copied.quantity, testSubscription.quantity);
      expect(copied.frequency, testSubscription.frequency);
      expect(copied.status, testSubscription.status);
      expect(copied.discountPercentage, testSubscription.discountPercentage);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testSubscription.toJson();
      final recreated = Subscription.fromJson(json);

      expect(recreated.id, testSubscription.id);
      expect(recreated.userId, testSubscription.userId);
      expect(recreated.product.id, testSubscription.product.id);
      expect(recreated.quantity, testSubscription.quantity);
      expect(recreated.frequency, testSubscription.frequency);
      expect(recreated.status, testSubscription.status);
      expect(recreated.startDate.toIso8601String(),
          testSubscription.startDate.toIso8601String());
      expect(recreated.nextDeliveryDate?.toIso8601String(),
          testSubscription.nextDeliveryDate?.toIso8601String());
      expect(recreated.endDate?.toIso8601String(),
          testSubscription.endDate?.toIso8601String());
      expect(recreated.discountPercentage, testSubscription.discountPercentage);
      expect(recreated.selectedSize, testSubscription.selectedSize);
      expect(recreated.selectedColor, testSubscription.selectedColor);
    });

    test('should handle all SubscriptionFrequency enum values', () {
      final frequencies = [
        SubscriptionFrequency.weekly,
        SubscriptionFrequency.biweekly,
        SubscriptionFrequency.monthly,
        SubscriptionFrequency.bimonthly,
        SubscriptionFrequency.quarterly,
      ];

      for (final frequency in frequencies) {
        final subscription = Subscription(
          id: 'test',
          userId: 'user',
          product: testProduct,
          frequency: frequency,
          status: SubscriptionStatus.active,
          startDate: DateTime.now(),
        );

        final json = subscription.toJson();
        final recreated = Subscription.fromJson(json);

        expect(recreated.frequency, frequency);
      }
    });

    test('should handle all SubscriptionStatus enum values', () {
      final statuses = [
        SubscriptionStatus.active,
        SubscriptionStatus.paused,
        SubscriptionStatus.cancelled,
        SubscriptionStatus.expired,
      ];

      for (final status in statuses) {
        final subscription = Subscription(
          id: 'test',
          userId: 'user',
          product: testProduct,
          frequency: SubscriptionFrequency.monthly,
          status: status,
          startDate: DateTime.now(),
        );

        final json = subscription.toJson();
        final recreated = Subscription.fromJson(json);

        expect(recreated.status, status);
      }
    });

    test('should calculate prices correctly with high discount', () {
      final subscription = Subscription(
        id: 'sub11',
        userId: 'user11',
        product: testProduct,
        quantity: 1,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        discountPercentage: 50.0,
      );

      expect(subscription.discountedPrice, closeTo(14.995, 0.01)); // 29.99 * 0.5
      expect(subscription.totalPrice, closeTo(14.995, 0.01));
    });

    test('should calculate prices correctly with zero discount', () {
      final subscription = Subscription(
        id: 'sub12',
        userId: 'user12',
        product: testProduct,
        quantity: 1,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        discountPercentage: 0.0,
      );

      expect(subscription.discountedPrice, 29.99);
      expect(subscription.totalPrice, 29.99);
    });

    test('should calculate prices correctly with large quantity', () {
      final subscription = Subscription(
        id: 'sub13',
        userId: 'user13',
        product: testProduct,
        quantity: 100,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        discountPercentage: 10.0,
      );

      expect(subscription.totalPrice, closeTo(2699.1, 0.1)); // 29.99 * 0.9 * 100
    });

    test('should handle dates properly in different formats', () {
      final json = {
        'id': 'sub14',
        'userId': 'user14',
        'product': {
          'id': 'prod7',
          'name': 'Test',
          'description': 'Test',
          'price': 10.0,
          'imageUrl': 'test.jpg',
          'images': ['test.jpg'],
          'category': 'Test',
          'brand': 'Test',
        },
        'frequency': SubscriptionFrequency.monthly.index,
        'status': SubscriptionStatus.active.index,
        'startDate': '2024-01-01T00:00:00Z',
        'nextDeliveryDate': '2024-02-01T12:30:00.000Z',
      };

      final subscription = Subscription.fromJson(json);

      expect(subscription.startDate, isA<DateTime>());
      expect(subscription.nextDeliveryDate, isA<DateTime>());
    });
  });
}
