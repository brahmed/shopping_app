import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('OrderEnhanced Model Tests', () {
    late OrderEnhanced testOrder;
    late CartItem testCartItem1;
    late CartItem testCartItem2;
    late Product testProduct1;
    late Product testProduct2;
    late Address testShippingAddress;
    late Address testBillingAddress;
    late OrderStatusUpdate testStatusUpdate1;
    late OrderStatusUpdate testStatusUpdate2;
    late DateTime testOrderDate;
    late DateTime testDeliveryDate;
    late DateTime testEstimatedDelivery;

    setUp(() {
      testOrderDate = DateTime(2024, 1, 15, 10, 30);
      testDeliveryDate = DateTime(2024, 1, 20, 14, 00);
      testEstimatedDelivery = DateTime(2024, 1, 19, 00, 00);

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

      testCartItem1 = CartItem(
        product: testProduct1,
        quantity: 2,
        selectedSize: 'Large',
        selectedColor: 'Black',
      );

      testCartItem2 = CartItem(
        product: testProduct2,
        quantity: 1,
      );

      testShippingAddress = Address(
        id: 'addr1',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main St',
        addressLine2: 'Apt 4B',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
        landmark: 'Near Central Park',
        isDefault: true,
        type: AddressType.home,
      );

      testBillingAddress = Address(
        id: 'addr2',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '456 Business Ave',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10002',
        type: AddressType.work,
      );

      testStatusUpdate1 = OrderStatusUpdate(
        status: OrderStatus.confirmed,
        timestamp: DateTime(2024, 1, 15, 11, 00),
        notes: 'Order confirmed',
      );

      testStatusUpdate2 = OrderStatusUpdate(
        status: OrderStatus.shipped,
        timestamp: DateTime(2024, 1, 17, 9, 00),
        notes: 'Order shipped via Express Delivery',
      );

      testOrder = OrderEnhanced(
        id: 'order1',
        userId: 'user1',
        items: [testCartItem1, testCartItem2],
        subtotal: 249.97,
        discount: 25.00,
        shippingCost: 10.00,
        tax: 20.00,
        totalAmount: 254.97,
        status: OrderStatus.delivered,
        paymentStatus: PaymentStatus.completed,
        paymentMethod: PaymentMethod.creditCard,
        orderDate: testOrderDate,
        deliveryDate: testDeliveryDate,
        estimatedDelivery: testEstimatedDelivery,
        shippingAddress: testShippingAddress,
        billingAddress: testBillingAddress,
        trackingNumber: 'TRACK123456',
        couponCode: 'SAVE25',
        orderNotes: 'Please deliver before 5 PM',
        isGift: true,
        giftMessage: 'Happy Birthday!',
        statusUpdates: [testStatusUpdate1, testStatusUpdate2],
      );
    });

    test('should create OrderEnhanced instance with all fields', () {
      expect(testOrder.id, 'order1');
      expect(testOrder.userId, 'user1');
      expect(testOrder.items.length, 2);
      expect(testOrder.subtotal, 249.97);
      expect(testOrder.discount, 25.00);
      expect(testOrder.shippingCost, 10.00);
      expect(testOrder.tax, 20.00);
      expect(testOrder.totalAmount, 254.97);
      expect(testOrder.status, OrderStatus.delivered);
      expect(testOrder.paymentStatus, PaymentStatus.completed);
      expect(testOrder.paymentMethod, PaymentMethod.creditCard);
      expect(testOrder.orderDate, testOrderDate);
      expect(testOrder.deliveryDate, testDeliveryDate);
      expect(testOrder.estimatedDelivery, testEstimatedDelivery);
      expect(testOrder.trackingNumber, 'TRACK123456');
      expect(testOrder.couponCode, 'SAVE25');
      expect(testOrder.orderNotes, 'Please deliver before 5 PM');
      expect(testOrder.isGift, true);
      expect(testOrder.giftMessage, 'Happy Birthday!');
      expect(testOrder.statusUpdates.length, 2);
    });

    test('should have default values for optional fields', () {
      final order = OrderEnhanced(
        id: 'order2',
        userId: 'user2',
        items: [testCartItem1],
        subtotal: 199.98,
        totalAmount: 219.98,
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: PaymentMethod.paypal,
        orderDate: DateTime.now(),
        shippingAddress: testShippingAddress,
      );

      expect(order.discount, 0.0);
      expect(order.shippingCost, 0.0);
      expect(order.tax, 0.0);
      expect(order.deliveryDate, null);
      expect(order.estimatedDelivery, null);
      expect(order.billingAddress, null);
      expect(order.trackingNumber, null);
      expect(order.couponCode, null);
      expect(order.orderNotes, null);
      expect(order.isGift, false);
      expect(order.giftMessage, null);
      expect(order.statusUpdates, isEmpty);
    });

    test('should calculate itemCount correctly', () {
      expect(testOrder.itemCount, 3); // 2 + 1
    });

    test('should calculate itemCount with single item', () {
      final order = OrderEnhanced(
        id: 'order3',
        userId: 'user3',
        items: [testCartItem1],
        subtotal: 199.98,
        totalAmount: 199.98,
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: PaymentMethod.cashOnDelivery,
        orderDate: DateTime.now(),
        shippingAddress: testShippingAddress,
      );

      expect(order.itemCount, 2);
    });

    test('should return true for canCancel when status is pending', () {
      final order = testOrder.copyWith(status: OrderStatus.pending);
      expect(order.canCancel, true);
    });

    test('should return true for canCancel when status is confirmed', () {
      final order = testOrder.copyWith(status: OrderStatus.confirmed);
      expect(order.canCancel, true);
    });

    test('should return false for canCancel when status is shipped', () {
      final order = testOrder.copyWith(status: OrderStatus.shipped);
      expect(order.canCancel, false);
    });

    test('should return true for canReturn when delivered within 30 days', () {
      final recentDelivery = DateTime.now().subtract(const Duration(days: 10));
      final order = testOrder.copyWith(
        status: OrderStatus.delivered,
        deliveryDate: recentDelivery,
      );
      expect(order.canReturn, true);
    });

    test('should return false for canReturn when delivered over 30 days ago', () {
      final oldDelivery = DateTime.now().subtract(const Duration(days: 31));
      final order = testOrder.copyWith(
        status: OrderStatus.delivered,
        deliveryDate: oldDelivery,
      );
      expect(order.canReturn, false);
    });

    test('should return false for canReturn when not delivered', () {
      final order = testOrder.copyWith(status: OrderStatus.shipped);
      expect(order.canReturn, false);
    });

    test('should return correct statusString for pending', () {
      final order = testOrder.copyWith(status: OrderStatus.pending);
      expect(order.statusString, 'Pending');
    });

    test('should return correct statusString for confirmed', () {
      final order = testOrder.copyWith(status: OrderStatus.confirmed);
      expect(order.statusString, 'Confirmed');
    });

    test('should return correct statusString for processing', () {
      final order = testOrder.copyWith(status: OrderStatus.processing);
      expect(order.statusString, 'Processing');
    });

    test('should return correct statusString for shipped', () {
      final order = testOrder.copyWith(status: OrderStatus.shipped);
      expect(order.statusString, 'Shipped');
    });

    test('should return correct statusString for outForDelivery', () {
      final order = testOrder.copyWith(status: OrderStatus.outForDelivery);
      expect(order.statusString, 'Out for Delivery');
    });

    test('should return correct statusString for delivered', () {
      expect(testOrder.statusString, 'Delivered');
    });

    test('should return correct statusString for cancelled', () {
      final order = testOrder.copyWith(status: OrderStatus.cancelled);
      expect(order.statusString, 'Cancelled');
    });

    test('should return correct statusString for returned', () {
      final order = testOrder.copyWith(status: OrderStatus.returned);
      expect(order.statusString, 'Returned');
    });

    test('should return correct statusString for refunded', () {
      final order = testOrder.copyWith(status: OrderStatus.refunded);
      expect(order.statusString, 'Refunded');
    });

    test('should return correct paymentMethodString for creditCard', () {
      expect(testOrder.paymentMethodString, 'Credit Card');
    });

    test('should return correct paymentMethodString for debitCard', () {
      final order = testOrder.copyWith(paymentMethod: PaymentMethod.debitCard);
      expect(order.paymentMethodString, 'Debit Card');
    });

    test('should return correct paymentMethodString for paypal', () {
      final order = testOrder.copyWith(paymentMethod: PaymentMethod.paypal);
      expect(order.paymentMethodString, 'PayPal');
    });

    test('should return correct paymentMethodString for applePay', () {
      final order = testOrder.copyWith(paymentMethod: PaymentMethod.applePay);
      expect(order.paymentMethodString, 'Apple Pay');
    });

    test('should return correct paymentMethodString for googlePay', () {
      final order = testOrder.copyWith(paymentMethod: PaymentMethod.googlePay);
      expect(order.paymentMethodString, 'Google Pay');
    });

    test('should return correct paymentMethodString for cashOnDelivery', () {
      final order = testOrder.copyWith(paymentMethod: PaymentMethod.cashOnDelivery);
      expect(order.paymentMethodString, 'Cash on Delivery');
    });

    test('should serialize to JSON correctly', () {
      final json = testOrder.toJson();

      expect(json['id'], 'order1');
      expect(json['userId'], 'user1');
      expect(json['items'], isA<List>());
      expect(json['items'].length, 2);
      expect(json['subtotal'], 249.97);
      expect(json['discount'], 25.00);
      expect(json['shippingCost'], 10.00);
      expect(json['tax'], 20.00);
      expect(json['totalAmount'], 254.97);
      expect(json['status'], OrderStatus.delivered.index);
      expect(json['paymentStatus'], PaymentStatus.completed.index);
      expect(json['paymentMethod'], PaymentMethod.creditCard.index);
      expect(json['orderDate'], testOrderDate.toIso8601String());
      expect(json['deliveryDate'], testDeliveryDate.toIso8601String());
      expect(json['estimatedDelivery'], testEstimatedDelivery.toIso8601String());
      expect(json['shippingAddress'], isA<Map<String, dynamic>>());
      expect(json['billingAddress'], isA<Map<String, dynamic>>());
      expect(json['trackingNumber'], 'TRACK123456');
      expect(json['couponCode'], 'SAVE25');
      expect(json['orderNotes'], 'Please deliver before 5 PM');
      expect(json['isGift'], true);
      expect(json['giftMessage'], 'Happy Birthday!');
      expect(json['statusUpdates'], isA<List>());
      expect(json['statusUpdates'].length, 2);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'order2',
        'userId': 'user2',
        'items': [
          {
            'product': {
              'id': 'prod3',
              'name': 'Product 3',
              'description': 'Description 3',
              'price': 79.99,
              'imageUrl': 'test.jpg',
              'images': ['test.jpg'],
              'category': 'Sports',
              'brand': 'Brand C',
            },
            'quantity': 3,
            'selectedSize': 'Medium',
            'selectedColor': 'Blue',
          }
        ],
        'subtotal': 239.97,
        'discount': 20.00,
        'shippingCost': 15.00,
        'tax': 18.00,
        'totalAmount': 252.97,
        'status': OrderStatus.shipped.index,
        'paymentStatus': PaymentStatus.completed.index,
        'paymentMethod': PaymentMethod.paypal.index,
        'orderDate': '2024-02-01T10:00:00.000',
        'deliveryDate': null,
        'estimatedDelivery': '2024-02-05T00:00:00.000',
        'shippingAddress': {
          'id': 'addr3',
          'userId': 'user2',
          'fullName': 'Jane Smith',
          'phoneNumber': '+0987654321',
          'addressLine1': '789 Oak St',
          'addressLine2': '',
          'city': 'Los Angeles',
          'state': 'CA',
          'country': 'USA',
          'zipCode': '90001',
          'type': 'home',
        },
        'billingAddress': null,
        'trackingNumber': 'TRACK789',
        'couponCode': 'SAVE20',
        'orderNotes': 'Ring doorbell',
        'isGift': false,
        'giftMessage': null,
        'statusUpdates': [],
      };

      final order = OrderEnhanced.fromJson(json);

      expect(order.id, 'order2');
      expect(order.userId, 'user2');
      expect(order.items.length, 1);
      expect(order.items[0].quantity, 3);
      expect(order.subtotal, 239.97);
      expect(order.discount, 20.00);
      expect(order.status, OrderStatus.shipped);
      expect(order.paymentMethod, PaymentMethod.paypal);
      expect(order.deliveryDate, null);
      expect(order.billingAddress, null);
      expect(order.isGift, false);
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'order3',
        'userId': 'user3',
        'items': [
          {
            'product': {
              'id': 'prod4',
              'name': 'Product 4',
              'description': 'Description 4',
              'price': 50.00,
              'imageUrl': 'test.jpg',
              'images': ['test.jpg'],
              'category': 'Test',
              'brand': 'Test',
            },
            'quantity': 1,
          }
        ],
        'subtotal': 50.00,
        'totalAmount': 50.00,
        'status': OrderStatus.pending.index,
        'paymentStatus': PaymentStatus.pending.index,
        'paymentMethod': PaymentMethod.cashOnDelivery.index,
        'orderDate': '2024-01-01T00:00:00.000',
        'shippingAddress': {
          'id': 'addr4',
          'userId': 'user3',
          'fullName': 'Test User',
          'phoneNumber': '+1111111111',
          'addressLine1': 'Test St',
          'city': 'Test City',
          'state': 'TS',
          'country': 'Test',
          'zipCode': '00000',
          'type': 'home',
        },
      };

      final order = OrderEnhanced.fromJson(json);

      expect(order.discount, 0.0);
      expect(order.shippingCost, 0.0);
      expect(order.tax, 0.0);
      expect(order.deliveryDate, null);
      expect(order.estimatedDelivery, null);
      expect(order.billingAddress, null);
      expect(order.trackingNumber, null);
      expect(order.couponCode, null);
      expect(order.orderNotes, null);
      expect(order.isGift, false);
      expect(order.giftMessage, null);
      expect(order.statusUpdates, isEmpty);
    });

    test('should handle numeric type conversion in JSON', () {
      final json = {
        'id': 'order4',
        'userId': 'user4',
        'items': [
          {
            'product': {
              'id': 'prod5',
              'name': 'Product 5',
              'description': 'Description 5',
              'price': 100,
              'imageUrl': 'test.jpg',
              'images': ['test.jpg'],
              'category': 'Test',
              'brand': 'Test',
            },
            'quantity': 1,
          }
        ],
        'subtotal': 100,
        'discount': 10,
        'shippingCost': 5,
        'tax': 8,
        'totalAmount': 103,
        'status': OrderStatus.pending.index,
        'paymentStatus': PaymentStatus.pending.index,
        'paymentMethod': PaymentMethod.creditCard.index,
        'orderDate': '2024-01-01T00:00:00.000',
        'shippingAddress': {
          'id': 'addr5',
          'userId': 'user4',
          'fullName': 'Test',
          'phoneNumber': '+1234567890',
          'addressLine1': 'Test',
          'city': 'Test',
          'state': 'TS',
          'country': 'Test',
          'zipCode': '00000',
          'type': 'home',
        },
      };

      final order = OrderEnhanced.fromJson(json);

      expect(order.subtotal, 100.0);
      expect(order.discount, 10.0);
      expect(order.shippingCost, 5.0);
      expect(order.tax, 8.0);
      expect(order.totalAmount, 103.0);
    });

    test('should copyWith correctly - updating single field', () {
      final updated = testOrder.copyWith(status: OrderStatus.cancelled);

      expect(updated.status, OrderStatus.cancelled);
      expect(updated.id, testOrder.id);
      expect(updated.userId, testOrder.userId);
      expect(updated.totalAmount, testOrder.totalAmount);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updated = testOrder.copyWith(
        status: OrderStatus.shipped,
        trackingNumber: 'NEW123',
        orderNotes: 'Updated notes',
      );

      expect(updated.status, OrderStatus.shipped);
      expect(updated.trackingNumber, 'NEW123');
      expect(updated.orderNotes, 'Updated notes');
      expect(updated.id, testOrder.id);
    });

    test('should copyWith correctly - no changes', () {
      final copied = testOrder.copyWith();

      expect(copied.id, testOrder.id);
      expect(copied.userId, testOrder.userId);
      expect(copied.status, testOrder.status);
      expect(copied.totalAmount, testOrder.totalAmount);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testOrder.toJson();
      final recreated = OrderEnhanced.fromJson(json);

      expect(recreated.id, testOrder.id);
      expect(recreated.userId, testOrder.userId);
      expect(recreated.items.length, testOrder.items.length);
      expect(recreated.subtotal, testOrder.subtotal);
      expect(recreated.discount, testOrder.discount);
      expect(recreated.status, testOrder.status);
      expect(recreated.paymentMethod, testOrder.paymentMethod);
      expect(recreated.trackingNumber, testOrder.trackingNumber);
      expect(recreated.isGift, testOrder.isGift);
      expect(recreated.giftMessage, testOrder.giftMessage);
    });

    test('should handle all OrderStatus enum values', () {
      const statuses = OrderStatus.values;

      for (final status in statuses) {
        final order = testOrder.copyWith(status: status);
        final json = order.toJson();
        final recreated = OrderEnhanced.fromJson(json);

        expect(recreated.status, status);
      }
    });

    test('should handle all PaymentMethod enum values', () {
      const methods = PaymentMethod.values;

      for (final method in methods) {
        final order = testOrder.copyWith(paymentMethod: method);
        final json = order.toJson();
        final recreated = OrderEnhanced.fromJson(json);

        expect(recreated.paymentMethod, method);
      }
    });

    test('should handle all PaymentStatus enum values', () {
      const statuses = PaymentStatus.values;

      for (final status in statuses) {
        final order = testOrder.copyWith(paymentStatus: status);
        final json = order.toJson();
        final recreated = OrderEnhanced.fromJson(json);

        expect(recreated.paymentStatus, status);
      }
    });
  });

  group('OrderStatusUpdate Model Tests', () {
    late OrderStatusUpdate testStatusUpdate;
    late DateTime testTimestamp;

    setUp(() {
      testTimestamp = DateTime(2024, 1, 15, 10, 30);

      testStatusUpdate = OrderStatusUpdate(
        status: OrderStatus.shipped,
        timestamp: testTimestamp,
        notes: 'Order has been shipped via Express Delivery',
      );
    });

    test('should create OrderStatusUpdate instance with all fields', () {
      expect(testStatusUpdate.status, OrderStatus.shipped);
      expect(testStatusUpdate.timestamp, testTimestamp);
      expect(testStatusUpdate.notes, 'Order has been shipped via Express Delivery');
    });

    test('should have null notes when not provided', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.confirmed,
        timestamp: DateTime.now(),
      );

      expect(update.notes, null);
    });

    test('should serialize to JSON correctly', () {
      final json = testStatusUpdate.toJson();

      expect(json['status'], OrderStatus.shipped.index);
      expect(json['timestamp'], testTimestamp.toIso8601String());
      expect(json['notes'], 'Order has been shipped via Express Delivery');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'status': OrderStatus.delivered.index,
        'timestamp': '2024-01-20T14:00:00.000',
        'notes': 'Package delivered successfully',
      };

      final update = OrderStatusUpdate.fromJson(json);

      expect(update.status, OrderStatus.delivered);
      expect(update.notes, 'Package delivered successfully');
    });

    test('should handle missing notes in JSON', () {
      final json = {
        'status': OrderStatus.processing.index,
        'timestamp': '2024-01-16T09:00:00.000',
      };

      final update = OrderStatusUpdate.fromJson(json);

      expect(update.status, OrderStatus.processing);
      expect(update.notes, null);
    });

    test('should handle null notes in JSON', () {
      final json = {
        'status': OrderStatus.processing.index,
        'timestamp': '2024-01-16T09:00:00.000',
        'notes': null,
      };

      final update = OrderStatusUpdate.fromJson(json);

      expect(update.notes, null);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testStatusUpdate.toJson();
      final recreated = OrderStatusUpdate.fromJson(json);

      expect(recreated.status, testStatusUpdate.status);
      expect(recreated.timestamp.toIso8601String(),
          testStatusUpdate.timestamp.toIso8601String());
      expect(recreated.notes, testStatusUpdate.notes);
    });

    test('should handle all OrderStatus enum values', () {
      const statuses = OrderStatus.values;

      for (final status in statuses) {
        final update = OrderStatusUpdate(
          status: status,
          timestamp: DateTime.now(),
        );

        final json = update.toJson();
        final recreated = OrderStatusUpdate.fromJson(json);

        expect(recreated.status, status);
      }
    });

    test('should handle empty notes', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.confirmed,
        timestamp: DateTime.now(),
        notes: '',
      );

      expect(update.notes, '');

      final json = update.toJson();
      final recreated = OrderStatusUpdate.fromJson(json);

      expect(recreated.notes, '');
    });

    test('should handle long notes', () {
      final longNotes = 'Status update notes. ' * 100;
      final update = OrderStatusUpdate(
        status: OrderStatus.shipped,
        timestamp: DateTime.now(),
        notes: longNotes,
      );

      expect(update.notes!.length, longNotes.length);

      final json = update.toJson();
      final recreated = OrderStatusUpdate.fromJson(json);

      expect(recreated.notes, longNotes);
    });

    test('should handle special characters in notes', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.delivered,
        timestamp: DateTime.now(),
        notes: 'Delivered at 5:00 PM! Left with neighbor. Thanks! :)',
      );

      final json = update.toJson();
      final recreated = OrderStatusUpdate.fromJson(json);

      expect(recreated.notes, update.notes);
    });
  });
}
