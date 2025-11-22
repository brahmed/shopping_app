import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/orders_provider.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/address_model.dart';

void main() {
  group('OrdersProvider Tests', () {
    late ProviderContainer container;
    late OrderEnhanced testOrder1;
    late OrderEnhanced testOrder2;
    late Address testAddress;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testAddress = Address(
        id: 'addr1',
        userId: 'user1',
        fullName: 'John Doe',
        phoneNumber: '1234567890',
        addressLine1: '123 Main St',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
      );

      final testProduct = Product(
        id: 'prod1',
        name: 'Test Product',
        description: 'Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'electronics',
        brand: 'TestBrand',
      );

      final cartItem = CartItem(product: testProduct, quantity: 2);

      testOrder1 = OrderEnhanced(
        id: 'order1',
        userId: 'user1',
        items: [cartItem],
        subtotal: 199.98,
        totalAmount: 219.98,
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: PaymentMethod.creditCard,
        orderDate: DateTime.now(),
        shippingAddress: testAddress,
      );

      testOrder2 = OrderEnhanced(
        id: 'order2',
        userId: 'user1',
        items: [cartItem],
        subtotal: 199.98,
        totalAmount: 219.98,
        status: OrderStatus.delivered,
        paymentStatus: PaymentStatus.completed,
        paymentMethod: PaymentMethod.paypal,
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        deliveryDate: DateTime.now(),
        shippingAddress: testAddress,
      );

      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(ordersProvider);

        expect(state.orders, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
        expect(state.totalOrders, 0);
        expect(state.totalSpent, 0.0);
      });

      test('should create OrdersState with default values', () {
        const state = OrdersState();

        expect(state.orders, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Add Order', () {
      test('should add order to list', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.length, 1);
        expect(state.orders.first.id, testOrder1.id);
      });

      test('should add multiple orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await notifier.addOrder(testOrder2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.orders.length, 2);
      });

      test('should add new orders at the beginning', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder2);
        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.orders.first.id, testOrder1.id);
      });
    });

    group('Update Order Status', () {
      test('should update order status', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.confirmed);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.status, OrderStatus.confirmed);
      });

      test('should add status update to order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.processing);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        final order = state.orders.first;
        expect(order.statusUpdates, isNotEmpty);
        expect(order.statusUpdates.last.status, OrderStatus.processing);
      });

      test('should set delivery date when status is delivered', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.delivered);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.deliveryDate, isNotNull);
      });

      test('should handle updating non-existent order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.updateOrderStatus('non_existent', OrderStatus.shipped);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders, isEmpty);
      });
    });

    group('Cancel Order', () {
      test('should cancel order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.cancelOrder(testOrder1.id, reason: 'Changed my mind');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.status, OrderStatus.cancelled);
      });

      test('should handle cancelling non-existent order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.cancelOrder('non_existent');
        await Future.delayed(const Duration(milliseconds: 50));

        // Should not throw error
        expect(container.read(ordersProvider).orders, isEmpty);
      });
    });

    group('Return Order', () {
      test('should return order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder2);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.returnOrder(testOrder2.id, reason: 'Defective product');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.status, OrderStatus.returned);
      });
    });

    group('Update Tracking Number', () {
      test('should update tracking number', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateTrackingNumber(testOrder1.id, 'TRACK123456');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.trackingNumber, 'TRACK123456');
      });

      test('should handle updating tracking for non-existent order', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.updateTrackingNumber('non_existent', 'TRACK123');
        await Future.delayed(const Duration(milliseconds: 50));

        expect(container.read(ordersProvider).orders, isEmpty);
      });
    });

    group('Get Order By ID', () {
      test('should get order by ID', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        final order = notifier.getOrderById(testOrder1.id);

        expect(order, isNotNull);
        expect(order?.id, testOrder1.id);
      });

      test('should return null for non-existent order ID', () {
        final notifier = container.read(ordersProvider.notifier);

        final order = notifier.getOrderById('non_existent');

        expect(order, isNull);
      });
    });

    group('Get Orders By Status', () {
      test('should get orders by status', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1); // pending
        await notifier.addOrder(testOrder2); // delivered
        await Future.delayed(const Duration(milliseconds: 100));

        final pendingOrders =
            notifier.getOrdersByStatus(OrderStatus.pending);
        final deliveredOrders =
            notifier.getOrdersByStatus(OrderStatus.delivered);

        expect(pendingOrders.length, 1);
        expect(deliveredOrders.length, 1);
        expect(pendingOrders.first.id, testOrder1.id);
        expect(deliveredOrders.first.id, testOrder2.id);
      });

      test('should return empty list for status with no orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        final shippedOrders = notifier.getOrdersByStatus(OrderStatus.shipped);

        expect(shippedOrders, isEmpty);
      });
    });

    group('State Getters', () {
      test('should calculate total orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await notifier.addOrder(testOrder2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.totalOrders, 2);
      });

      test('should get active orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1); // pending
        await notifier.addOrder(testOrder2); // delivered
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.activeOrders.length, 1);
        expect(state.activeOrders.first.id, testOrder1.id);
      });

      test('should get completed orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1); // pending
        await notifier.addOrder(testOrder2); // delivered
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.completedOrders.length, 1);
        expect(state.completedOrders.first.id, testOrder2.id);
      });

      test('should calculate total spent', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder2); // delivered, 219.98
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.totalSpent, closeTo(219.98, 0.01));
      });

      test('should exclude non-delivered orders from total spent', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1); // pending
        await notifier.addOrder(testOrder2); // delivered
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        // Only delivered order should count
        expect(state.totalSpent, closeTo(219.98, 0.01));
      });
    });

    group('Clear Orders', () {
      test('should clear all orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await notifier.addOrder(testOrder2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.clearOrders();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders, isEmpty);
        expect(state.totalOrders, 0);
      });

      test('should handle clearing empty orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.clearOrders();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders, isEmpty);
      });
    });

    group('Persistence', () {
      test('should save orders to SharedPreferences', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        final ordersData = prefs.getString('user_orders');
        expect(ordersData, isNotNull);
      });

      test('should load orders from SharedPreferences', () async {
        final notifier1 = container.read(ordersProvider.notifier);
        await notifier1.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 100));

        // Create new container to simulate app restart
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.orders, isNotEmpty);
      });

      test('should persist order status updates', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.shipped);
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify persisted
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.orders.first.status, OrderStatus.shipped);
      });

      test('should sort orders by date after loading', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder2); // older
        await notifier.addOrder(testOrder1); // newer
        await Future.delayed(const Duration(milliseconds: 100));

        // Reload
        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        // Should be sorted newest first
        expect(state.orders.first.id, testOrder1.id);
      });
    });

    group('OrdersState copyWith', () {
      test('should copy with new orders', () {
        const original = OrdersState();
        final copied = original.copyWith(orders: [testOrder1]);

        expect(copied.orders.length, 1);
        expect(copied.orders.first.id, testOrder1.id);
      });

      test('should copy with loading state', () {
        const original = OrdersState();
        final copied = original.copyWith(isLoading: true);

        expect(copied.isLoading, true);
        expect(copied.orders, isEmpty);
      });

      test('should copy with error', () {
        const original = OrdersState();
        final copied = original.copyWith(error: 'Test error');

        expect(copied.error, 'Test error');
        expect(copied.isLoading, false);
      });
    });

    group('Edge Cases', () {
      test('should handle many orders', () async {
        final notifier = container.read(ordersProvider.notifier);

        for (int i = 0; i < 50; i++) {
          final order = OrderEnhanced(
            id: 'order_$i',
            userId: 'user1',
            items: testOrder1.items,
            subtotal: 100.0 * i,
            totalAmount: 110.0 * i,
            status: OrderStatus.pending,
            paymentStatus: PaymentStatus.pending,
            paymentMethod: PaymentMethod.creditCard,
            orderDate: DateTime.now().subtract(Duration(days: i)),
            shippingAddress: testAddress,
          );
          await notifier.addOrder(order);
        }
        await Future.delayed(const Duration(milliseconds: 200));

        final state = container.read(ordersProvider);
        expect(state.orders.length, 50);
      });

      test('should handle rapid status updates', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.confirmed);
        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.processing);
        await notifier.updateOrderStatus(testOrder1.id, OrderStatus.shipped);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(ordersProvider);
        expect(state.orders.first.status, OrderStatus.shipped);
        expect(state.orders.first.statusUpdates.length, 3);
      });

      test('should handle empty tracking number', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateTrackingNumber(testOrder1.id, '');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(ordersProvider);
        expect(state.orders.first.trackingNumber, '');
      });

      test('should handle order with multiple status updates', () async {
        final notifier = container.read(ordersProvider.notifier);

        await notifier.addOrder(testOrder1);
        await Future.delayed(const Duration(milliseconds: 50));

        for (var status in [
          OrderStatus.confirmed,
          OrderStatus.processing,
          OrderStatus.shipped,
          OrderStatus.outForDelivery,
          OrderStatus.delivered
        ]) {
          await notifier.updateOrderStatus(testOrder1.id, status);
          await Future.delayed(const Duration(milliseconds: 10));
        }

        final state = container.read(ordersProvider);
        expect(state.orders.first.statusUpdates.length, 5);
        expect(state.orders.first.status, OrderStatus.delivered);
      });

      test('should calculate total spent with multiple delivered orders',
          () async {
        final notifier = container.read(ordersProvider.notifier);

        // Create multiple delivered orders
        for (int i = 0; i < 3; i++) {
          final order = OrderEnhanced(
            id: 'order_$i',
            userId: 'user1',
            items: testOrder1.items,
            subtotal: 100.0,
            totalAmount: 110.0,
            status: OrderStatus.delivered,
            paymentStatus: PaymentStatus.completed,
            paymentMethod: PaymentMethod.creditCard,
            orderDate: DateTime.now().subtract(Duration(days: i)),
            deliveryDate: DateTime.now(),
            shippingAddress: testAddress,
          );
          await notifier.addOrder(order);
        }
        await Future.delayed(const Duration(milliseconds: 150));

        final state = container.read(ordersProvider);
        expect(state.totalSpent, closeTo(330.0, 0.01));
      });
    });
  });
}
