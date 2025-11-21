import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_model_enhanced.dart';

// Orders State
class OrdersState {
  final List<OrderEnhanced> orders;
  final bool isLoading;
  final String? error;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  List<OrderEnhanced> get activeOrders {
    return orders.where((order) =>
        order.status != OrderStatus.delivered &&
        order.status != OrderStatus.cancelled &&
        order.status != OrderStatus.returned &&
        order.status != OrderStatus.refunded).toList();
  }

  List<OrderEnhanced> get completedOrders {
    return orders.where((order) =>
        order.status == OrderStatus.delivered ||
        order.status == OrderStatus.cancelled ||
        order.status == OrderStatus.returned ||
        order.status == OrderStatus.refunded).toList();
  }

  int get totalOrders => orders.length;

  double get totalSpent {
    return orders
        .where((order) => order.status == OrderStatus.delivered)
        .fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  OrdersState copyWith({
    List<OrderEnhanced>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Orders Notifier
class OrdersNotifier extends StateNotifier<OrdersState> {
  static const String _ordersKey = 'user_orders';

  OrdersNotifier() : super(const OrdersState()) {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersData = prefs.getString(_ordersKey);
      if (ordersData != null) {
        final List<dynamic> decodedData = json.decode(ordersData);
        final orders = decodedData.map((order) => OrderEnhanced.fromJson(order)).toList();
        // Sort by order date, newest first
        orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        state = OrdersState(orders: orders, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersData = json.encode(state.orders.map((order) => order.toJson()).toList());
      await prefs.setString(_ordersKey, ordersData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addOrder(OrderEnhanced order) async {
    final orders = [order, ...state.orders];
    state = state.copyWith(orders: orders);
    await _saveOrders();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    final orders = state.orders.map((order) {
      if (order.id == orderId) {
        final statusUpdate = OrderStatusUpdate(
          status: newStatus,
          timestamp: DateTime.now(),
        );
        final updates = [...order.statusUpdates, statusUpdate];
        return order.copyWith(
          status: newStatus,
          statusUpdates: updates,
          deliveryDate: newStatus == OrderStatus.delivered ? DateTime.now() : order.deliveryDate,
        );
      }
      return order;
    }).toList();

    state = state.copyWith(orders: orders);
    await _saveOrders();
  }

  Future<void> cancelOrder(String orderId, {String? reason}) async {
    await updateOrderStatus(orderId, OrderStatus.cancelled);
  }

  Future<void> returnOrder(String orderId, {String? reason}) async {
    await updateOrderStatus(orderId, OrderStatus.returned);
  }

  Future<void> updateTrackingNumber(String orderId, String trackingNumber) async {
    final orders = state.orders.map((order) {
      if (order.id == orderId) {
        return order.copyWith(trackingNumber: trackingNumber);
      }
      return order;
    }).toList();

    state = state.copyWith(orders: orders);
    await _saveOrders();
  }

  OrderEnhanced? getOrderById(String orderId) {
    try {
      return state.orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  List<OrderEnhanced> getOrdersByStatus(OrderStatus status) {
    return state.orders.where((order) => order.status == status).toList();
  }

  Future<void> clearOrders() async {
    state = const OrdersState(orders: []);
    await _saveOrders();
  }
}

// Provider
final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  return OrdersNotifier();
});
