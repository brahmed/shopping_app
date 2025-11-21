import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/providers/orders_provider.dart';
import '../fixtures/mock_data.dart';

void main() {
  group('Orders Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have empty initial state', () {
      final ordersState = container.read(ordersProvider);

      expect(ordersState.orders, isEmpty);
      expect(ordersState.isLoading, isFalse);
      expect(ordersState.error, isNull);
    });

    test('should add order successfully', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);

      final state = container.read(ordersProvider);
      expect(state.orders.length, equals(1));
      expect(state.orders.first.id, equals(testOrder.id));
    });

    test('should add multiple orders', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1);
      await notifier.addOrder(MockData.mockOrder2);

      final state = container.read(ordersProvider);
      expect(state.orders.length, equals(2));
    });

    test('should add orders with newest first', () async {
      final notifier = container.read(ordersProvider.notifier);
      final order1 = MockData.mockOrder1;
      final order2 = MockData.mockOrder2;

      await notifier.addOrder(order1);
      await notifier.addOrder(order2);

      final state = container.read(ordersProvider);
      expect(state.orders.first.id, equals(order2.id));
    });

    test('should update order status', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);
      await notifier.updateOrderStatus(testOrder.id, OrderStatus.shipped);

      final state = container.read(ordersProvider);
      final updatedOrder = state.orders.first;

      expect(updatedOrder.status, equals(OrderStatus.shipped));
      expect(updatedOrder.statusUpdates.length, greaterThan(testOrder.statusUpdates.length));
    });

    test('should set deliveryDate when status is delivered', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);
      await notifier.updateOrderStatus(testOrder.id, OrderStatus.delivered);

      final state = container.read(ordersProvider);
      final updatedOrder = state.orders.first;

      expect(updatedOrder.status, equals(OrderStatus.delivered));
      expect(updatedOrder.deliveryDate, isNotNull);
    });

    test('should cancel order', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);
      await notifier.cancelOrder(testOrder.id);

      final state = container.read(ordersProvider);
      final cancelledOrder = state.orders.first;

      expect(cancelledOrder.status, equals(OrderStatus.cancelled));
    });

    test('should return order', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);
      await notifier.returnOrder(testOrder.id);

      final state = container.read(ordersProvider);
      final returnedOrder = state.orders.first;

      expect(returnedOrder.status, equals(OrderStatus.returned));
    });

    test('should update tracking number', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;
      const newTrackingNumber = 'NEW_TRACK_12345';

      await notifier.addOrder(testOrder);
      await notifier.updateTrackingNumber(testOrder.id, newTrackingNumber);

      final state = container.read(ordersProvider);
      final updatedOrder = state.orders.first;

      expect(updatedOrder.trackingNumber, equals(newTrackingNumber));
    });

    test('should get order by id', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);

      final foundOrder = notifier.getOrderById(testOrder.id);

      expect(foundOrder, isNotNull);
      expect(foundOrder!.id, equals(testOrder.id));
    });

    test('should return null for non-existent order id', () {
      final notifier = container.read(ordersProvider.notifier);

      final foundOrder = notifier.getOrderById('non_existent_id');

      expect(foundOrder, isNull);
    });

    test('should get orders by status', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1); // processing
      await notifier.addOrder(MockData.mockOrder2); // delivered

      final processingOrders = notifier.getOrdersByStatus(OrderStatus.processing);
      final deliveredOrders = notifier.getOrdersByStatus(OrderStatus.delivered);

      expect(processingOrders.length, equals(1));
      expect(deliveredOrders.length, equals(1));
    });

    test('should filter active orders correctly', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1); // processing (active)
      await notifier.addOrder(MockData.mockOrder2); // delivered (completed)

      final state = container.read(ordersProvider);
      final activeOrders = state.activeOrders;

      expect(activeOrders.length, equals(1));
      expect(activeOrders.first.status, equals(OrderStatus.processing));
    });

    test('should filter completed orders correctly', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1); // processing
      await notifier.addOrder(MockData.mockOrder2); // delivered

      final state = container.read(ordersProvider);
      final completedOrders = state.completedOrders;

      expect(completedOrders.length, equals(1));
      expect(completedOrders.first.status, equals(OrderStatus.delivered));
    });

    test('should calculate total orders count', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1);
      await notifier.addOrder(MockData.mockOrder2);

      final state = container.read(ordersProvider);

      expect(state.totalOrders, equals(2));
    });

    test('should calculate total spent correctly', () async {
      final notifier = container.read(ordersProvider.notifier);

      // Only delivered orders count
      await notifier.addOrder(MockData.mockOrder2); // delivered: 653.98

      final state = container.read(ordersProvider);

      expect(state.totalSpent, equals(653.98));
    });

    test('should not count non-delivered orders in total spent', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1); // processing

      final state = container.read(ordersProvider);

      expect(state.totalSpent, equals(0.0));
    });

    test('should clear all orders', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1);
      await notifier.addOrder(MockData.mockOrder2);

      var state = container.read(ordersProvider);
      expect(state.orders.length, equals(2));

      await notifier.clearOrders();

      state = container.read(ordersProvider);
      expect(state.orders, isEmpty);
    });

    test('should handle state loading flag', () async {
      final notifier = container.read(ordersProvider.notifier);

      // Initial load starts as loading
      // Note: This test might need adjustment based on actual implementation
      final state = container.read(ordersProvider);
      expect(state.isLoading, isFalse); // After initialization
    });

    test('should preserve existing orders when adding new one', () async {
      final notifier = container.read(ordersProvider.notifier);

      await notifier.addOrder(MockData.mockOrder1);
      final firstState = container.read(ordersProvider);
      expect(firstState.orders.length, equals(1));

      await notifier.addOrder(MockData.mockOrder2);
      final secondState = container.read(ordersProvider);
      expect(secondState.orders.length, equals(2));
      expect(secondState.orders.any((o) => o.id == MockData.mockOrder1.id), isTrue);
    });

    test('should handle order status updates timeline', () async {
      final notifier = container.read(ordersProvider.notifier);
      final testOrder = MockData.mockOrder1;

      await notifier.addOrder(testOrder);
      final initialUpdatesCount = testOrder.statusUpdates.length;

      await notifier.updateOrderStatus(testOrder.id, OrderStatus.shipped);

      final state = container.read(ordersProvider);
      final updatedOrder = state.orders.first;

      expect(updatedOrder.statusUpdates.length, equals(initialUpdatesCount + 1));
      expect(updatedOrder.statusUpdates.last.status, equals(OrderStatus.shipped));
    });
  });
}
