import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/local/orders_local_data_source.dart';
import '../data/remote/api_client.dart';
import '../data/remote/orders_remote_data_source.dart';
import '../models/order_model_enhanced.dart';
import '../services/connectivity_service.dart';
import '../services/offline_queue_service.dart';

/// Orders repository with online-first strategy (with fallback)
class OrdersRepository {
  final OrdersLocalDataSource _localDataSource;
  final OrdersRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;
  final OfflineQueueService _offlineQueueService;

  OrdersRepository(
    this._localDataSource,
    this._remoteDataSource,
    this._connectivityService,
    this._offlineQueueService,
  );

  /// Get all orders with online-first strategy
  /// Strategy: Try remote first, fallback to cache if offline or error
  Future<List<OrderEnhanced>> getOrders(String userId) async {
    // 1. Try to fetch from remote if online
    if (_connectivityService.isOnline) {
      try {
        final remoteOrders = await _remoteDataSource.getOrders(userId);

        // 2. Update cache with fresh data
        await _localDataSource.cacheOrders(remoteOrders);

        return remoteOrders;
      } catch (e) {
        // 3. If remote fails, fallback to cache
        final cachedOrders = await _localDataSource.getAllOrders();
        if (cachedOrders.isNotEmpty) {
          return cachedOrders;
        }
        rethrow;
      }
    }

    // 4. Offline - return cached data
    final cachedOrders = await _localDataSource.getAllOrders();
    if (cachedOrders.isNotEmpty) {
      return cachedOrders;
    }

    throw OfflineException('No internet connection and no cached orders');
  }

  /// Get order by ID with online-first strategy
  Future<OrderEnhanced?> getOrderById(String userId, String orderId) async {
    // 1. Try remote first if online
    if (_connectivityService.isOnline) {
      try {
        final remoteOrder =
            await _remoteDataSource.getOrderById(userId, orderId);

        // 2. Update cache
        await _localDataSource.cacheOrder(remoteOrder);

        return remoteOrder;
      } catch (e) {
        // 3. Fallback to cache
        return await _localDataSource.getOrderById(orderId);
      }
    }

    // 4. Offline - return cached data
    return await _localDataSource.getOrderById(orderId);
  }

  /// Create order (with offline queue support)
  Future<OrderEnhanced> createOrder(OrderEnhanced order) async {
    // 1. If online, try to create on server immediately
    if (_connectivityService.isOnline) {
      try {
        final createdOrder = await _remoteDataSource.createOrder(order);

        // 2. Cache the created order
        await _localDataSource.cacheOrder(createdOrder);

        return createdOrder;
      } catch (e) {
        // 3. If fails, queue for later sync
        return await _createOrderOffline(order);
      }
    }

    // 4. Offline - queue the operation
    return await _createOrderOffline(order);
  }

  /// Create order offline (queue for sync)
  Future<OrderEnhanced> _createOrderOffline(OrderEnhanced order) async {
    // Generate a temporary ID if not present
    final orderWithId = order.id.isEmpty
        ? order.copyWith(id: 'temp_${const Uuid().v4()}')
        : order;

    // 1. Save to local database as unsynced
    await _localDataSource.saveUnsyncedOrder(orderWithId);

    // 2. Queue the operation for sync
    await _offlineQueueService.addOperation(
      operationType: 'CREATE',
      entityType: 'order',
      entityId: orderWithId.id,
      endpoint: '/users/${orderWithId.userId}/orders',
      method: 'POST',
      payload: orderWithId.toJson(),
    );

    return orderWithId;
  }

  /// Update order status (with offline queue support)
  Future<OrderEnhanced> updateOrderStatus(
    String userId,
    String orderId,
    OrderStatus status,
  ) async {
    // 1. If online, try to update on server
    if (_connectivityService.isOnline) {
      try {
        final updatedOrder =
            await _remoteDataSource.updateOrderStatus(userId, orderId, status);

        // 2. Update cache
        await _localDataSource.cacheOrder(updatedOrder);

        return updatedOrder;
      } catch (e) {
        // 3. Queue for sync
        return await _updateOrderStatusOffline(userId, orderId, status);
      }
    }

    // 4. Offline - queue the operation
    return await _updateOrderStatusOffline(userId, orderId, status);
  }

  /// Update order status offline (queue for sync)
  Future<OrderEnhanced> _updateOrderStatusOffline(
    String userId,
    String orderId,
    OrderStatus status,
  ) async {
    // 1. Get order from cache
    final order = await _localDataSource.getOrderById(orderId);
    if (order == null) {
      throw Exception('Order not found in cache');
    }

    // 2. Update locally
    final updatedOrder = order.copyWith(status: status);
    await _localDataSource.saveUnsyncedOrder(updatedOrder);

    // 3. Queue the operation
    await _offlineQueueService.addOperation(
      operationType: 'UPDATE',
      entityType: 'order',
      entityId: orderId,
      endpoint: '/users/$userId/orders/$orderId',
      method: 'PATCH',
      payload: {'status': status.name},
    );

    return updatedOrder;
  }

  /// Cancel order (with offline queue support)
  Future<OrderEnhanced> cancelOrder(String userId, String orderId) async {
    // 1. If online, try to cancel on server
    if (_connectivityService.isOnline) {
      try {
        final cancelledOrder =
            await _remoteDataSource.cancelOrder(userId, orderId);

        // 2. Update cache
        await _localDataSource.cacheOrder(cancelledOrder);

        return cancelledOrder;
      } catch (e) {
        // 3. Queue for sync
        return await _cancelOrderOffline(userId, orderId);
      }
    }

    // 4. Offline - queue the operation
    return await _cancelOrderOffline(userId, orderId);
  }

  /// Cancel order offline (queue for sync)
  Future<OrderEnhanced> _cancelOrderOffline(
    String userId,
    String orderId,
  ) async {
    // 1. Get order from cache
    final order = await _localDataSource.getOrderById(orderId);
    if (order == null) {
      throw Exception('Order not found in cache');
    }

    // 2. Update locally
    final cancelledOrder = order.copyWith(status: OrderStatus.cancelled);
    await _localDataSource.saveUnsyncedOrder(cancelledOrder);

    // 3. Queue the operation
    await _offlineQueueService.addOperation(
      operationType: 'UPDATE',
      entityType: 'order',
      entityId: orderId,
      endpoint: '/users/$userId/orders/$orderId/cancel',
      method: 'PATCH',
      payload: {},
    );

    return cancelledOrder;
  }

  /// Request return (with offline queue support)
  Future<OrderEnhanced> returnOrder(
    String userId,
    String orderId,
    String reason,
  ) async {
    // 1. If online, try to request return on server
    if (_connectivityService.isOnline) {
      try {
        final returnedOrder =
            await _remoteDataSource.returnOrder(userId, orderId, reason);

        // 2. Update cache
        await _localDataSource.cacheOrder(returnedOrder);

        return returnedOrder;
      } catch (e) {
        // 3. Queue for sync
        return await _returnOrderOffline(userId, orderId, reason);
      }
    }

    // 4. Offline - queue the operation
    return await _returnOrderOffline(userId, orderId, reason);
  }

  /// Return order offline (queue for sync)
  Future<OrderEnhanced> _returnOrderOffline(
    String userId,
    String orderId,
    String reason,
  ) async {
    // 1. Get order from cache
    final order = await _localDataSource.getOrderById(orderId);
    if (order == null) {
      throw Exception('Order not found in cache');
    }

    // 2. Update locally
    final returnedOrder = order.copyWith(status: OrderStatus.returned);
    await _localDataSource.saveUnsyncedOrder(returnedOrder);

    // 3. Queue the operation
    await _offlineQueueService.addOperation(
      operationType: 'UPDATE',
      entityType: 'order',
      entityId: orderId,
      endpoint: '/users/$userId/orders/$orderId/return',
      method: 'POST',
      payload: {'reason': reason},
    );

    return returnedOrder;
  }

  /// Sync unsynced orders
  Future<void> syncUnsyncedOrders() async {
    if (!_connectivityService.isOnline) return;

    final unsyncedOrders = await _localDataSource.getUnsyncedOrders();

    for (final order in unsyncedOrders) {
      try {
        // Try to create/update on server
        if (order.id.startsWith('temp_')) {
          // This is a new order created offline
          final createdOrder = await _remoteDataSource.createOrder(order);

          // Delete temp order and cache the real one
          await _localDataSource.deleteOrder(order.id);
          await _localDataSource.cacheOrder(createdOrder);
        } else {
          // This is an updated order
          await _localDataSource.markOrderAsSynced(order.id);
        }
      } catch (e) {
        // Skip and try again later
        continue;
      }
    }
  }

  /// Clear cache
  Future<void> clearCache() async {
    await _localDataSource.clearAllOrders();
  }

  /// Check if data is cached
  Future<bool> hasCache() async {
    return _localDataSource.hasCache();
  }
}

/// Provider for OrdersRepository
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final apiClient = ref.watch(apiClientProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  final offlineQueueService = ref.watch(offlineQueueServiceProvider);

  final localDataSource = OrdersLocalDataSource(db);
  final remoteDataSource = OrdersRemoteDataSource(apiClient);

  return OrdersRepository(
    localDataSource,
    remoteDataSource,
    connectivityService,
    offlineQueueService,
  );
});
