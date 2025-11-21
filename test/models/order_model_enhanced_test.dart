import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import '../fixtures/mock_data.dart';

void main() {
  group('OrderEnhanced Model Tests', () {
    late OrderEnhanced testOrder;

    setUp(() {
      testOrder = MockData.mockOrder1;
    });

    test('should create an OrderEnhanced instance', () {
      expect(testOrder, isA<OrderEnhanced>());
      expect(testOrder.id, equals('order_1'));
      expect(testOrder.userId, equals('user_1'));
      expect(testOrder.items.length, greaterThan(0));
      expect(testOrder.status, equals(OrderStatus.processing));
      expect(testOrder.paymentStatus, equals(PaymentStatus.completed));
      expect(testOrder.paymentMethod, equals(PaymentMethod.creditCard));
    });

    group('Computed Properties Tests', () {
      test('should calculate itemCount correctly', () {
        expect(testOrder.itemCount, equals(3));
      });

      test('should determine canCancel correctly', () {
        final pendingOrder = testOrder.copyWith(status: OrderStatus.pending);
        expect(pendingOrder.canCancel, isTrue);

        final confirmedOrder = testOrder.copyWith(status: OrderStatus.confirmed);
        expect(confirmedOrder.canCancel, isTrue);

        final shippedOrder = testOrder.copyWith(status: OrderStatus.shipped);
        expect(shippedOrder.canCancel, isFalse);

        final deliveredOrder = testOrder.copyWith(status: OrderStatus.delivered);
        expect(deliveredOrder.canCancel, isFalse);
      });

      test('should determine canReturn correctly for delivered order', () {
        final deliveryDate = DateTime.now().subtract(const Duration(days: 15));
        final deliveredOrder = testOrder.copyWith(
          status: OrderStatus.delivered,
          deliveryDate: deliveryDate,
        );

        expect(deliveredOrder.canReturn, isTrue);
      });

      test('should not allow return after 30 days', () {
        final oldDeliveryDate = DateTime.now().subtract(const Duration(days: 35));
        final oldOrder = testOrder.copyWith(
          status: OrderStatus.delivered,
          deliveryDate: oldDeliveryDate,
        );

        expect(oldOrder.canReturn, isFalse);
      });

      test('should not allow return if not delivered', () {
        final pendingOrder = testOrder.copyWith(status: OrderStatus.pending);
        expect(pendingOrder.canReturn, isFalse);
      });

      test('should get correct statusString', () {
        expect(testOrder.statusString, equals('Processing'));

        final pendingOrder = testOrder.copyWith(status: OrderStatus.pending);
        expect(pendingOrder.statusString, equals('Pending'));

        final deliveredOrder = testOrder.copyWith(status: OrderStatus.delivered);
        expect(deliveredOrder.statusString, equals('Delivered'));

        final cancelledOrder = testOrder.copyWith(status: OrderStatus.cancelled);
        expect(cancelledOrder.statusString, equals('Cancelled'));
      });

      test('should get correct paymentMethodString', () {
        expect(testOrder.paymentMethodString, equals('Credit Card'));

        final paypalOrder = testOrder.copyWith(paymentMethod: PaymentMethod.paypal);
        expect(paypalOrder.paymentMethodString, equals('PayPal'));

        final codOrder = testOrder.copyWith(paymentMethod: PaymentMethod.cashOnDelivery);
        expect(codOrder.paymentMethodString, equals('Cash on Delivery'));
      });
    });

    group('OrderStatus Enum Tests', () {
      test('should handle all OrderStatus values', () {
        expect(OrderStatus.pending, equals(OrderStatus.pending));
        expect(OrderStatus.confirmed, equals(OrderStatus.confirmed));
        expect(OrderStatus.processing, equals(OrderStatus.processing));
        expect(OrderStatus.shipped, equals(OrderStatus.shipped));
        expect(OrderStatus.outForDelivery, equals(OrderStatus.outForDelivery));
        expect(OrderStatus.delivered, equals(OrderStatus.delivered));
        expect(OrderStatus.cancelled, equals(OrderStatus.cancelled));
        expect(OrderStatus.returned, equals(OrderStatus.returned));
        expect(OrderStatus.refunded, equals(OrderStatus.refunded));
      });
    });

    group('PaymentMethod Enum Tests', () {
      test('should handle all PaymentMethod values', () {
        expect(PaymentMethod.creditCard, equals(PaymentMethod.creditCard));
        expect(PaymentMethod.debitCard, equals(PaymentMethod.debitCard));
        expect(PaymentMethod.paypal, equals(PaymentMethod.paypal));
        expect(PaymentMethod.applePay, equals(PaymentMethod.applePay));
        expect(PaymentMethod.googlePay, equals(PaymentMethod.googlePay));
        expect(PaymentMethod.cashOnDelivery, equals(PaymentMethod.cashOnDelivery));
      });
    });

    group('PaymentStatus Enum Tests', () {
      test('should handle all PaymentStatus values', () {
        expect(PaymentStatus.pending, equals(PaymentStatus.pending));
        expect(PaymentStatus.processing, equals(PaymentStatus.processing));
        expect(PaymentStatus.completed, equals(PaymentStatus.completed));
        expect(PaymentStatus.failed, equals(PaymentStatus.failed));
        expect(PaymentStatus.refunded, equals(PaymentStatus.refunded));
      });
    });

    test('should serialize to JSON correctly', () {
      final json = testOrder.toJson();

      expect(json['id'], equals('order_1'));
      expect(json['userId'], equals('user_1'));
      expect(json['items'], isA<List>());
      expect(json['subtotal'], equals(testOrder.subtotal));
      expect(json['discount'], equals(testOrder.discount));
      expect(json['shippingCost'], equals(testOrder.shippingCost));
      expect(json['tax'], equals(testOrder.tax));
      expect(json['totalAmount'], equals(testOrder.totalAmount));
      expect(json['status'], isA<int>());
      expect(json['paymentStatus'], isA<int>());
      expect(json['paymentMethod'], isA<int>());
      expect(json['shippingAddress'], isA<Map>());
    });

    test('should deserialize from JSON correctly', () {
      final json = testOrder.toJson();
      final deserialized = OrderEnhanced.fromJson(json);

      expect(deserialized.id, equals(testOrder.id));
      expect(deserialized.userId, equals(testOrder.userId));
      expect(deserialized.items.length, equals(testOrder.items.length));
      expect(deserialized.subtotal, equals(testOrder.subtotal));
      expect(deserialized.discount, equals(testOrder.discount));
      expect(deserialized.totalAmount, equals(testOrder.totalAmount));
      expect(deserialized.status, equals(testOrder.status));
      expect(deserialized.paymentStatus, equals(testOrder.paymentStatus));
      expect(deserialized.paymentMethod, equals(testOrder.paymentMethod));
    });

    test('should handle gift order', () {
      final giftOrder = testOrder.copyWith(
        isGift: true,
        giftMessage: 'Happy Birthday!',
      );

      expect(giftOrder.isGift, isTrue);
      expect(giftOrder.giftMessage, equals('Happy Birthday!'));

      final json = giftOrder.toJson();
      expect(json['isGift'], isTrue);
      expect(json['giftMessage'], equals('Happy Birthday!'));
    });

    test('should handle order notes', () {
      final orderWithNotes = testOrder.copyWith(
        orderNotes: 'Please ring doorbell',
      );

      expect(orderWithNotes.orderNotes, equals('Please ring doorbell'));
    });

    test('should handle tracking number', () {
      expect(testOrder.trackingNumber, equals('TRACK123456'));

      final json = testOrder.toJson();
      expect(json['trackingNumber'], equals('TRACK123456'));
    });

    test('should handle status updates list', () {
      expect(testOrder.statusUpdates, isNotEmpty);
      expect(testOrder.statusUpdates.length, equals(3));
      expect(testOrder.statusUpdates[0].status, equals(OrderStatus.pending));
    });

    test('should handle billing address separately from shipping', () {
      final billingAddress = MockData.mockAddress2;
      final orderWithBilling = testOrder.copyWith(
        billingAddress: billingAddress,
      );

      expect(orderWithBilling.billingAddress, isNotNull);
      expect(orderWithBilling.billingAddress!.id, equals('address_2'));
      expect(orderWithBilling.shippingAddress.id, equals('address_1'));
    });

    test('should handle estimated delivery date', () {
      expect(testOrder.estimatedDelivery, isNotNull);
      expect(testOrder.estimatedDelivery, isA<DateTime>());
    });

    test('should handle actual delivery date', () {
      final deliveredOrder = MockData.mockOrder2;
      expect(deliveredOrder.deliveryDate, isNotNull);
      expect(deliveredOrder.status, equals(OrderStatus.delivered));
    });

    test('should copyWith updated values correctly', () {
      final updated = testOrder.copyWith(
        status: OrderStatus.shipped,
        trackingNumber: 'NEW_TRACK_999',
      );

      expect(updated.status, equals(OrderStatus.shipped));
      expect(updated.trackingNumber, equals('NEW_TRACK_999'));
      expect(updated.id, equals(testOrder.id));
      expect(updated.userId, equals(testOrder.userId));
    });

    test('should handle default values correctly', () {
      final minimalOrder = OrderEnhanced(
        id: 'minimal_1',
        userId: 'user_99',
        items: [MockData.mockCartItem1],
        subtotal: 100.0,
        totalAmount: 100.0,
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: PaymentMethod.creditCard,
        orderDate: DateTime.now(),
        shippingAddress: MockData.mockAddress1,
      );

      expect(minimalOrder.discount, equals(0.0));
      expect(minimalOrder.shippingCost, equals(0.0));
      expect(minimalOrder.tax, equals(0.0));
      expect(minimalOrder.isGift, isFalse);
      expect(minimalOrder.statusUpdates, isEmpty);
    });
  });

  group('OrderStatusUpdate Tests', () {
    test('should create OrderStatusUpdate instance', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.shipped,
        timestamp: DateTime(2024, 3, 2),
        notes: 'Package shipped from warehouse',
      );

      expect(update.status, equals(OrderStatus.shipped));
      expect(update.timestamp.day, equals(2));
      expect(update.notes, equals('Package shipped from warehouse'));
    });

    test('should serialize OrderStatusUpdate to JSON', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.delivered,
        timestamp: DateTime(2024, 3, 5, 16, 30),
        notes: 'Delivered to customer',
      );

      final json = update.toJson();

      expect(json['status'], isA<int>());
      expect(json['timestamp'], isA<String>());
      expect(json['notes'], equals('Delivered to customer'));
    });

    test('should deserialize OrderStatusUpdate from JSON', () {
      final json = {
        'status': OrderStatus.processing.index,
        'timestamp': '2024-03-02T09:00:00.000',
        'notes': 'Order being prepared',
      };

      final update = OrderStatusUpdate.fromJson(json);

      expect(update.status, equals(OrderStatus.processing));
      expect(update.timestamp.day, equals(2));
      expect(update.notes, equals('Order being prepared'));
    });

    test('should handle optional notes', () {
      final update = OrderStatusUpdate(
        status: OrderStatus.confirmed,
        timestamp: DateTime.now(),
      );

      expect(update.notes, isNull);

      final json = update.toJson();
      expect(json['notes'], isNull);
    });
  });
}
