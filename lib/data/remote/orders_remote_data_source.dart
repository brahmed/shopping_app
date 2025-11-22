import '../../models/order_model_enhanced.dart';
import 'api_client.dart';

/// Remote data source for orders
class OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSource(this._apiClient);

  /// Fetch all orders for user from API
  Future<List<OrderEnhanced>> getOrders(String userId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/users/$userId/orders',
    );

    final data = response.data;
    if (data == null || !data.containsKey('orders')) {
      return [];
    }

    final ordersList = data['orders'] as List;
    return ordersList.map((json) => OrderEnhanced.fromJson(json)).toList();
  }

  /// Fetch order by ID from API
  Future<OrderEnhanced> getOrderById(String userId, String orderId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/users/$userId/orders/$orderId',
    );

    final data = response.data;
    if (data == null) {
      throw Exception('Order not found');
    }

    return OrderEnhanced.fromJson(data);
  }

  /// Create new order on server
  Future<OrderEnhanced> createOrder(OrderEnhanced order) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/users/${order.userId}/orders',
      data: order.toJson(),
    );

    final data = response.data;
    if (data == null) {
      throw Exception('Failed to create order');
    }

    return OrderEnhanced.fromJson(data);
  }

  /// Update order status on server
  Future<OrderEnhanced> updateOrderStatus(
    String userId,
    String orderId,
    OrderStatus status,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/users/$userId/orders/$orderId',
      data: {'status': status.name},
    );

    final data = response.data;
    if (data == null) {
      throw Exception('Failed to update order');
    }

    return OrderEnhanced.fromJson(data);
  }

  /// Cancel order on server
  Future<OrderEnhanced> cancelOrder(String userId, String orderId) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/users/$userId/orders/$orderId/cancel',
    );

    final data = response.data;
    if (data == null) {
      throw Exception('Failed to cancel order');
    }

    return OrderEnhanced.fromJson(data);
  }

  /// Request return for order
  Future<OrderEnhanced> returnOrder(
    String userId,
    String orderId,
    String reason,
  ) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/users/$userId/orders/$orderId/return',
      data: {'reason': reason},
    );

    final data = response.data;
    if (data == null) {
      throw Exception('Failed to request return');
    }

    return OrderEnhanced.fromJson(data);
  }
}
