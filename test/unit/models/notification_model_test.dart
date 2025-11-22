import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/notification_model.dart';

void main() {
  group('AppNotification Model Tests', () {
    late AppNotification testNotification;
    late DateTime testTimestamp;

    setUp(() {
      testTimestamp = DateTime(2024, 1, 15, 10, 30);
      testNotification = AppNotification(
        id: 'notif1',
        title: 'Order Shipped',
        message: 'Your order #12345 has been shipped and is on its way!',
        type: NotificationType.order,
        timestamp: testTimestamp,
        isRead: false,
        imageUrl: 'https://example.com/order-image.jpg',
        actionUrl: '/orders/12345',
        data: {'orderId': '12345', 'trackingNumber': 'ABC123'},
      );
    });

    test('should create AppNotification instance with all fields', () {
      expect(testNotification.id, 'notif1');
      expect(testNotification.title, 'Order Shipped');
      expect(testNotification.message, contains('Your order #12345'));
      expect(testNotification.type, NotificationType.order);
      expect(testNotification.timestamp, testTimestamp);
      expect(testNotification.isRead, false);
      expect(testNotification.imageUrl, 'https://example.com/order-image.jpg');
      expect(testNotification.actionUrl, '/orders/12345');
      expect(testNotification.data, isNotNull);
      expect(testNotification.data!['orderId'], '12345');
    });

    test('should have default values for optional fields', () {
      final notification = AppNotification(
        id: 'notif2',
        title: 'Test',
        message: 'Test message',
        type: NotificationType.general,
        timestamp: DateTime.now(),
      );

      expect(notification.isRead, false);
      expect(notification.imageUrl, null);
      expect(notification.actionUrl, null);
      expect(notification.data, null);
    });

    test('should return correct typeString for order notification', () {
      expect(testNotification.typeString, 'Order Update');
    });

    test('should return correct typeString for priceAlert notification', () {
      final notification = AppNotification(
        id: 'notif3',
        title: 'Price Drop',
        message: 'Price dropped!',
        type: NotificationType.priceAlert,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Price Alert');
    });

    test('should return correct typeString for backInStock notification', () {
      final notification = AppNotification(
        id: 'notif4',
        title: 'Back in Stock',
        message: 'Item is back in stock!',
        type: NotificationType.backInStock,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Back in Stock');
    });

    test('should return correct typeString for promotion notification', () {
      final notification = AppNotification(
        id: 'notif5',
        title: 'Special Offer',
        message: 'Get 50% off!',
        type: NotificationType.promotion,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Promotion');
    });

    test('should return correct typeString for general notification', () {
      final notification = AppNotification(
        id: 'notif6',
        title: 'General',
        message: 'General message',
        type: NotificationType.general,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Notification');
    });

    test('should return correct typeString for delivery notification', () {
      final notification = AppNotification(
        id: 'notif7',
        title: 'Out for Delivery',
        message: 'Your order is out for delivery',
        type: NotificationType.delivery,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Delivery Update');
    });

    test('should return correct typeString for review notification', () {
      final notification = AppNotification(
        id: 'notif8',
        title: 'Review Request',
        message: 'Please review your purchase',
        type: NotificationType.review,
        timestamp: DateTime.now(),
      );
      expect(notification.typeString, 'Review');
    });

    test('should serialize to JSON correctly', () {
      final json = testNotification.toJson();

      expect(json['id'], 'notif1');
      expect(json['title'], 'Order Shipped');
      expect(json['message'], contains('Your order #12345'));
      expect(json['type'], NotificationType.order.index);
      expect(json['timestamp'], testTimestamp.toIso8601String());
      expect(json['isRead'], false);
      expect(json['imageUrl'], 'https://example.com/order-image.jpg');
      expect(json['actionUrl'], '/orders/12345');
      expect(json['data'], isA<Map<String, dynamic>>());
      expect(json['data']['orderId'], '12345');
    });

    test('should serialize to JSON with null optional fields', () {
      final notification = AppNotification(
        id: 'notif9',
        title: 'Test',
        message: 'Test',
        type: NotificationType.general,
        timestamp: testTimestamp,
      );

      final json = notification.toJson();

      expect(json['id'], 'notif9');
      expect(json['imageUrl'], null);
      expect(json['actionUrl'], null);
      expect(json['data'], null);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'notif10',
        'title': 'Price Alert',
        'message': 'The price of your watched item has dropped!',
        'type': NotificationType.priceAlert.index,
        'timestamp': '2024-02-20T14:30:00.000',
        'isRead': true,
        'imageUrl': 'https://example.com/product.jpg',
        'actionUrl': '/products/prod123',
        'data': {'productId': 'prod123', 'oldPrice': '99.99', 'newPrice': '79.99'},
      };

      final notification = AppNotification.fromJson(json);

      expect(notification.id, 'notif10');
      expect(notification.title, 'Price Alert');
      expect(notification.message, contains('price of your watched item'));
      expect(notification.type, NotificationType.priceAlert);
      expect(notification.isRead, true);
      expect(notification.imageUrl, 'https://example.com/product.jpg');
      expect(notification.actionUrl, '/products/prod123');
      expect(notification.data, isNotNull);
      expect(notification.data!['productId'], 'prod123');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'notif11',
        'title': 'Minimal Notification',
        'message': 'Minimal message',
        'type': NotificationType.general.index,
        'timestamp': '2024-01-10T12:00:00.000',
      };

      final notification = AppNotification.fromJson(json);

      expect(notification.id, 'notif11');
      expect(notification.title, 'Minimal Notification');
      expect(notification.isRead, false);
      expect(notification.imageUrl, null);
      expect(notification.actionUrl, null);
      expect(notification.data, null);
    });

    test('should handle null isRead in JSON', () {
      final json = {
        'id': 'notif12',
        'title': 'Test',
        'message': 'Test',
        'type': NotificationType.general.index,
        'timestamp': '2024-01-10T12:00:00.000',
        'isRead': null,
      };

      final notification = AppNotification.fromJson(json);

      expect(notification.isRead, false);
    });

    test('should copyWith correctly - updating single field', () {
      final updatedNotification = testNotification.copyWith(isRead: true);

      expect(updatedNotification.isRead, true);
      expect(updatedNotification.id, testNotification.id);
      expect(updatedNotification.title, testNotification.title);
      expect(updatedNotification.message, testNotification.message);
      expect(updatedNotification.type, testNotification.type);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updatedNotification = testNotification.copyWith(
        title: 'Updated Title',
        message: 'Updated message',
        isRead: true,
      );

      expect(updatedNotification.title, 'Updated Title');
      expect(updatedNotification.message, 'Updated message');
      expect(updatedNotification.isRead, true);
      expect(updatedNotification.id, testNotification.id);
      expect(updatedNotification.type, testNotification.type);
    });

    test('should copyWith correctly - no changes', () {
      final copiedNotification = testNotification.copyWith();

      expect(copiedNotification.id, testNotification.id);
      expect(copiedNotification.title, testNotification.title);
      expect(copiedNotification.message, testNotification.message);
      expect(copiedNotification.type, testNotification.type);
      expect(copiedNotification.timestamp, testNotification.timestamp);
      expect(copiedNotification.isRead, testNotification.isRead);
      expect(copiedNotification.imageUrl, testNotification.imageUrl);
      expect(copiedNotification.actionUrl, testNotification.actionUrl);
      expect(copiedNotification.data, testNotification.data);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testNotification.toJson();
      final recreatedNotification = AppNotification.fromJson(json);

      expect(recreatedNotification.id, testNotification.id);
      expect(recreatedNotification.title, testNotification.title);
      expect(recreatedNotification.message, testNotification.message);
      expect(recreatedNotification.type, testNotification.type);
      expect(recreatedNotification.timestamp.toIso8601String(),
          testNotification.timestamp.toIso8601String());
      expect(recreatedNotification.isRead, testNotification.isRead);
      expect(recreatedNotification.imageUrl, testNotification.imageUrl);
      expect(recreatedNotification.actionUrl, testNotification.actionUrl);
      expect(recreatedNotification.data, testNotification.data);
    });

    test('should handle all NotificationType enum values', () {
      final types = [
        NotificationType.order,
        NotificationType.priceAlert,
        NotificationType.backInStock,
        NotificationType.promotion,
        NotificationType.general,
        NotificationType.delivery,
        NotificationType.review,
      ];

      for (final type in types) {
        final notification = AppNotification(
          id: 'test',
          title: 'Test',
          message: 'Test',
          type: type,
          timestamp: DateTime.now(),
        );

        final json = notification.toJson();
        final recreated = AppNotification.fromJson(json);

        expect(recreated.type, type);
      }
    });

    test('should handle empty data map', () {
      final notification = AppNotification(
        id: 'notif13',
        title: 'Test',
        message: 'Test',
        type: NotificationType.general,
        timestamp: DateTime.now(),
        data: {},
      );

      expect(notification.data, isEmpty);

      final json = notification.toJson();
      final recreated = AppNotification.fromJson(json);

      expect(recreated.data, isEmpty);
    });

    test('should handle complex nested data in data field', () {
      final complexData = {
        'level1': {
          'level2': {
            'value': 'nested',
            'items': ['a', 'b', 'c'],
          }
        },
        'simpleValue': 123,
      };

      final notification = AppNotification(
        id: 'notif14',
        title: 'Complex Data',
        message: 'Test',
        type: NotificationType.general,
        timestamp: DateTime.now(),
        data: complexData,
      );

      final json = notification.toJson();
      final recreated = AppNotification.fromJson(json);

      expect(recreated.data, isNotNull);
      expect(recreated.data!['simpleValue'], 123);
      expect(recreated.data!['level1']['level2']['value'], 'nested');
    });

    test('should parse timestamp correctly from different ISO8601 formats', () {
      final json1 = {
        'id': 'notif15',
        'title': 'Test',
        'message': 'Test',
        'type': NotificationType.general.index,
        'timestamp': '2024-01-15T10:30:00.000',
      };

      final json2 = {
        'id': 'notif16',
        'title': 'Test',
        'message': 'Test',
        'type': NotificationType.general.index,
        'timestamp': '2024-01-15T10:30:00Z',
      };

      final notification1 = AppNotification.fromJson(json1);
      final notification2 = AppNotification.fromJson(json2);

      expect(notification1.timestamp, isA<DateTime>());
      expect(notification2.timestamp, isA<DateTime>());
    });
  });
}
