import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('Order Model Tests', () {
    late Product testProduct1;
    late Product testProduct2;
    late CartItem cartItem1;
    late CartItem cartItem2;
    late Order testOrder;

    setUp(() {
      testProduct1 = Product(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 50.0,
        imageUrl: 'image1.jpg',
        images: ['image1.jpg'],
        category: 'Electronics',
        brand: 'Brand 1',
      );

      testProduct2 = Product(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 30.0,
        imageUrl: 'image2.jpg',
        images: ['image2.jpg'],
        category: 'Clothing',
        brand: 'Brand 2',
      );

      cartItem1 = CartItem(product: testProduct1, quantity: 2);
      cartItem2 = CartItem(product: testProduct2, quantity: 1);

      testOrder = Order(
        id: 'order123',
        items: [cartItem1, cartItem2],
        totalAmount: 130.0,
        status: OrderStatus.confirmed,
        orderDate: DateTime(2024, 1, 15, 10, 30),
        deliveryDate: DateTime(2024, 1, 20, 14, 0),
        deliveryAddress: '123 Main St, City, State 12345',
        trackingNumber: 'TRACK123456',
      );
    });

    test('should create Order instance with all fields', () {
      expect(testOrder.id, 'order123');
      expect(testOrder.items.length, 2);
      expect(testOrder.totalAmount, 130.0);
      expect(testOrder.status, OrderStatus.confirmed);
      expect(testOrder.orderDate, DateTime(2024, 1, 15, 10, 30));
      expect(testOrder.deliveryDate, DateTime(2024, 1, 20, 14, 0));
      expect(testOrder.deliveryAddress, '123 Main St, City, State 12345');
      expect(testOrder.trackingNumber, 'TRACK123456');
    });

    test('should handle null optional fields', () {
      final order = Order(
        id: 'order456',
        items: [cartItem1],
        totalAmount: 100.0,
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        deliveryAddress: 'Test Address',
      );

      expect(order.deliveryDate, null);
      expect(order.trackingNumber, null);
    });

    test('should return correct status string for all statuses', () {
      expect(
        Order(
          id: '1',
          items: [],
          totalAmount: 0,
          status: OrderStatus.pending,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Pending',
      );

      expect(
        Order(
          id: '2',
          items: [],
          totalAmount: 0,
          status: OrderStatus.confirmed,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Confirmed',
      );

      expect(
        Order(
          id: '3',
          items: [],
          totalAmount: 0,
          status: OrderStatus.processing,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Processing',
      );

      expect(
        Order(
          id: '4',
          items: [],
          totalAmount: 0,
          status: OrderStatus.shipped,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Shipped',
      );

      expect(
        Order(
          id: '5',
          items: [],
          totalAmount: 0,
          status: OrderStatus.delivered,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Delivered',
      );

      expect(
        Order(
          id: '6',
          items: [],
          totalAmount: 0,
          status: OrderStatus.cancelled,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        ).statusString,
        'Cancelled',
      );
    });

    test('should serialize to JSON correctly', () {
      final json = testOrder.toJson();

      expect(json['id'], 'order123');
      expect(json['items'], isA<List>());
      expect(json['items'].length, 2);
      expect(json['totalAmount'], 130.0);
      expect(json['status'], OrderStatus.confirmed.index);
      expect(json['orderDate'], '2024-01-15T10:30:00.000');
      expect(json['deliveryDate'], '2024-01-20T14:00:00.000');
      expect(json['deliveryAddress'], '123 Main St, City, State 12345');
      expect(json['trackingNumber'], 'TRACK123456');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'order789',
        'items': [
          {
            'product': {
              'id': '1',
              'name': 'Product',
              'description': 'Description',
              'price': 25.0,
              'imageUrl': 'test.jpg',
              'images': ['test.jpg'],
              'category': 'Test',
              'brand': 'Test',
            },
            'quantity': 3,
            'selectedSize': null,
            'selectedColor': null,
          }
        ],
        'totalAmount': 75.0,
        'status': 3, // OrderStatus.shipped
        'orderDate': '2024-02-01T12:00:00.000',
        'deliveryDate': '2024-02-05T15:30:00.000',
        'deliveryAddress': '456 Oak Ave, Town, State 67890',
        'trackingNumber': 'TRACK789012',
      };

      final order = Order.fromJson(json);

      expect(order.id, 'order789');
      expect(order.items.length, 1);
      expect(order.totalAmount, 75.0);
      expect(order.status, OrderStatus.shipped);
      expect(order.orderDate, DateTime.parse('2024-02-01T12:00:00.000'));
      expect(order.deliveryDate, DateTime.parse('2024-02-05T15:30:00.000'));
      expect(order.deliveryAddress, '456 Oak Ave, Town, State 67890');
      expect(order.trackingNumber, 'TRACK789012');
    });

    test('should handle null optional fields in JSON', () {
      final json = {
        'id': 'order999',
        'items': [],
        'totalAmount': 0.0,
        'status': 0,
        'orderDate': '2024-01-01T00:00:00.000',
        'deliveryDate': null,
        'deliveryAddress': 'Test Address',
        'trackingNumber': null,
      };

      final order = Order.fromJson(json);

      expect(order.deliveryDate, null);
      expect(order.trackingNumber, null);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testOrder.toJson();
      final recreatedOrder = Order.fromJson(json);

      expect(recreatedOrder.id, testOrder.id);
      expect(recreatedOrder.items.length, testOrder.items.length);
      expect(recreatedOrder.totalAmount, testOrder.totalAmount);
      expect(recreatedOrder.status, testOrder.status);
      expect(recreatedOrder.orderDate, testOrder.orderDate);
      expect(recreatedOrder.deliveryDate, testOrder.deliveryDate);
      expect(recreatedOrder.deliveryAddress, testOrder.deliveryAddress);
      expect(recreatedOrder.trackingNumber, testOrder.trackingNumber);
    });

    test('should handle empty items list', () {
      final order = Order(
        id: 'empty',
        items: [],
        totalAmount: 0.0,
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        deliveryAddress: 'Test',
      );

      expect(order.items, isEmpty);

      final json = order.toJson();
      final recreatedOrder = Order.fromJson(json);

      expect(recreatedOrder.items, isEmpty);
    });

    test('should handle multiple items in JSON', () {
      final json = testOrder.toJson();
      final recreatedOrder = Order.fromJson(json);

      expect(recreatedOrder.items.length, 2);
      expect(recreatedOrder.items[0].product.id, '1');
      expect(recreatedOrder.items[1].product.id, '2');
      expect(recreatedOrder.items[0].quantity, 2);
      expect(recreatedOrder.items[1].quantity, 1);
    });

    test('should handle all OrderStatus enum values', () {
      for (final status in OrderStatus.values) {
        final order = Order(
          id: 'test',
          items: [],
          totalAmount: 0,
          status: status,
          orderDate: DateTime.now(),
          deliveryAddress: 'Test',
        );

        final json = order.toJson();
        final recreatedOrder = Order.fromJson(json);

        expect(recreatedOrder.status, status);
      }
    });

    test('should handle DateTime serialization correctly', () {
      final specificDate = DateTime(2024, 6, 15, 14, 30, 45);
      final order = Order(
        id: 'datetime_test',
        items: [],
        totalAmount: 0,
        status: OrderStatus.pending,
        orderDate: specificDate,
        deliveryAddress: 'Test',
      );

      final json = order.toJson();
      final recreatedOrder = Order.fromJson(json);

      expect(recreatedOrder.orderDate.year, 2024);
      expect(recreatedOrder.orderDate.month, 6);
      expect(recreatedOrder.orderDate.day, 15);
      expect(recreatedOrder.orderDate.hour, 14);
      expect(recreatedOrder.orderDate.minute, 30);
      expect(recreatedOrder.orderDate.second, 45);
    });
  });
}
