import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_model_enhanced.dart';
import '../repositories/orders_repository.dart';
import '../data/remote/api_client.dart';
import '../services/connectivity_service.dart';

// Orders State
class OrdersState {
  final List<OrderEnhanced> orders;
  final bool isLoading;
  final String? error;
  final bool isOfflineMode;
  final int pendingSyncCount;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
    this.isOfflineMode = false,
    this.pendingSyncCount = 0,
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
    String? Function()? error,
    bool? isOfflineMode,
    int? pendingSyncCount,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
      pendingSyncCount: pendingSyncCount ?? this.pendingSyncCount,
    );
  }
}

// Orders Notifier with online-first and offline queue support
class OrdersNotifier extends StateNotifier<OrdersState> {
  final OrdersRepository _repository;
  final ConnectivityService _connectivityService;
  final String _userId; // TODO: Get from auth service

  OrdersNotifier(
    this._repository,
    this._connectivityService, [
    this._userId = 'user123',
  ]) : super(const OrdersState()) {
    _loadOrders();
  }

  /// Load orders with online-first strategy
  Future<void> _loadOrders() async {
    state = state.copyWith(isLoading: true, error: () => null);

    try {
      final orders = await _repository.getOrders(_userId);

      state = OrdersState(
        orders: orders,
        isLoading: false,
        isOfflineMode: !_connectivityService.isOnline,
      );
    } on OfflineException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => e.message,
        isOfflineMode: true,
      );
    } on NetworkException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => 'Network error: ${e.message}',
        isOfflineMode: true,
      );
    } on TimeoutException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => 'Request timeout: ${e.message}',
        isOfflineMode: true,
      );
    } on ServerException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => 'Server error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => 'Error loading orders: ${e.toString()}',
      );
    }
  }

  /// Add new order (with offline queue support)
  Future<void> addOrder(OrderEnhanced order) async {
    try {
      final createdOrder = await _repository.createOrder(order);

      // Add to state
      final orders = [createdOrder, ...state.orders];
      state = state.copyWith(
        orders: orders,
        isOfflineMode: !_connectivityService.isOnline,
      );

      // If offline, increment pending sync count
      if (!_connectivityService.isOnline) {
        state = state.copyWith(pendingSyncCount: state.pendingSyncCount + 1);
      }
    } catch (e) {
      state = state.copyWith(
        error: () => 'Failed to create order: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Update order status (with offline queue support)
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final updatedOrder =
          await _repository.updateOrderStatus(_userId, orderId, newStatus);

      // Update in state
      final orders = state.orders.map((order) {
        if (order.id == orderId) {
          return updatedOrder;
        }
        return order;
      }).toList();

      state = state.copyWith(
        orders: orders,
        isOfflineMode: !_connectivityService.isOnline,
      );

      // If offline, increment pending sync count
      if (!_connectivityService.isOnline) {
        state = state.copyWith(pendingSyncCount: state.pendingSyncCount + 1);
      }
    } catch (e) {
      state = state.copyWith(
        error: () => 'Failed to update order status: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Cancel order (with offline queue support)
  Future<void> cancelOrder(String orderId, {String? reason}) async {
    try {
      final cancelledOrder = await _repository.cancelOrder(_userId, orderId);

      // Update in state
      final orders = state.orders.map((order) {
        if (order.id == orderId) {
          return cancelledOrder;
        }
        return order;
      }).toList();

      state = state.copyWith(
        orders: orders,
        isOfflineMode: !_connectivityService.isOnline,
      );

      // If offline, increment pending sync count
      if (!_connectivityService.isOnline) {
        state = state.copyWith(pendingSyncCount: state.pendingSyncCount + 1);
      }
    } catch (e) {
      state = state.copyWith(
        error: () => 'Failed to cancel order: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Return order (with offline queue support)
  Future<void> returnOrder(String orderId, {String? reason}) async {
    try {
      final returnedOrder =
          await _repository.returnOrder(_userId, orderId, reason ?? 'Customer request');

      // Update in state
      final orders = state.orders.map((order) {
        if (order.id == orderId) {
          return returnedOrder;
        }
        return order;
      }).toList();

      state = state.copyWith(
        orders: orders,
        isOfflineMode: !_connectivityService.isOnline,
      );

      // If offline, increment pending sync count
      if (!_connectivityService.isOnline) {
        state = state.copyWith(pendingSyncCount: state.pendingSyncCount + 1);
      }
    } catch (e) {
      state = state.copyWith(
        error: () => 'Failed to return order: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Refresh orders (manual sync)
  Future<void> refresh() async {
    await _loadOrders();
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

  /// Clear all orders from cache
  Future<void> clearOrders() async {
    await _repository.clearCache();
    state = const OrdersState(orders: []);
  }
}

// Provider with repository injection
final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  return OrdersNotifier(repository, connectivityService);
});
