import 'dart:convert';
import 'package:drift/drift.dart';
import '../../models/address_model.dart';
import '../../models/cart_item_model.dart' as models;
import '../../models/order_model_enhanced.dart';
import 'database/app_database.dart';

/// Local data source for orders
class OrdersLocalDataSource {
  final AppDatabase _db;

  OrdersLocalDataSource(this._db);

  /// Get all cached orders
  Future<List<OrderEnhanced>> getAllOrders() async {
    final results = await (_db.select(_db.orders)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.orderDate)]))
        .get();
    return results.map(_orderFromDb).toList();
  }

  /// Get order by ID
  Future<OrderEnhanced?> getOrderById(String id) async {
    final result = await (_db.select(_db.orders)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (result == null) return null;
    return _orderFromDb(result);
  }

  /// Get orders by status
  Future<List<OrderEnhanced>> getOrdersByStatus(OrderStatus status) async {
    final results = await (_db.select(_db.orders)
          ..where((tbl) => tbl.status.equals(status.name))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.orderDate)]))
        .get();
    return results.map(_orderFromDb).toList();
  }

  /// Get orders by user ID
  Future<List<OrderEnhanced>> getOrdersByUserId(String userId) async {
    final results = await (_db.select(_db.orders)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.orderDate)]))
        .get();
    return results.map(_orderFromDb).toList();
  }

  /// Cache single order
  Future<void> cacheOrder(OrderEnhanced order) async {
    await _db.into(_db.orders).insertOnConflictUpdate(
          OrdersCompanion.insert(
            id: order.id,
            userId: order.userId,
            items: jsonEncode(order.items.map((item) => item.toJson()).toList()),
            subtotal: order.subtotal,
            discount: order.discount,
            shippingCost: order.shippingCost,
            tax: order.tax,
            totalAmount: order.totalAmount,
            status: order.status.name,
            paymentStatus: order.paymentStatus.name,
            paymentMethod: order.paymentMethod.name,
            orderDate: order.orderDate,
            deliveryDate: Value(order.deliveryDate),
            estimatedDelivery: Value(order.estimatedDelivery),
            shippingAddress: jsonEncode(order.shippingAddress.toJson()),
            billingAddress: Value(order.billingAddress?.toJson() != null
                ? jsonEncode(order.billingAddress!.toJson())
                : null),
            trackingNumber: Value(order.trackingNumber),
            couponCode: Value(order.couponCode),
            orderNotes: Value(order.orderNotes),
            isGift: order.isGift,
            giftMessage: Value(order.giftMessage),
            statusUpdates: jsonEncode(
                order.statusUpdates.map((s) => s.toJson()).toList()),
            isSynced: const Value(true),
            cachedAt: DateTime.now(),
          ),
        );
  }

  /// Cache multiple orders
  Future<void> cacheOrders(List<OrderEnhanced> orders) async {
    await _db.batch((batch) {
      for (final order in orders) {
        batch.insert(
          _db.orders,
          OrdersCompanion.insert(
            id: order.id,
            userId: order.userId,
            items: jsonEncode(order.items.map((item) => item.toJson()).toList()),
            subtotal: order.subtotal,
            discount: order.discount,
            shippingCost: order.shippingCost,
            tax: order.tax,
            totalAmount: order.totalAmount,
            status: order.status.name,
            paymentStatus: order.paymentStatus.name,
            paymentMethod: order.paymentMethod.name,
            orderDate: order.orderDate,
            deliveryDate: Value(order.deliveryDate),
            estimatedDelivery: Value(order.estimatedDelivery),
            shippingAddress: jsonEncode(order.shippingAddress.toJson()),
            billingAddress: Value(order.billingAddress?.toJson() != null
                ? jsonEncode(order.billingAddress!.toJson())
                : null),
            trackingNumber: Value(order.trackingNumber),
            couponCode: Value(order.couponCode),
            orderNotes: Value(order.orderNotes),
            isGift: order.isGift,
            giftMessage: Value(order.giftMessage),
            statusUpdates: jsonEncode(
                order.statusUpdates.map((s) => s.toJson()).toList()),
            isSynced: const Value(true),
            cachedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Save order as unsynced (created offline)
  Future<void> saveUnsyncedOrder(OrderEnhanced order) async {
    await _db.into(_db.orders).insert(
          OrdersCompanion.insert(
            id: order.id,
            userId: order.userId,
            items: jsonEncode(order.items.map((item) => item.toJson()).toList()),
            subtotal: order.subtotal,
            discount: order.discount,
            shippingCost: order.shippingCost,
            tax: order.tax,
            totalAmount: order.totalAmount,
            status: order.status.name,
            paymentStatus: order.paymentStatus.name,
            paymentMethod: order.paymentMethod.name,
            orderDate: order.orderDate,
            deliveryDate: Value(order.deliveryDate),
            estimatedDelivery: Value(order.estimatedDelivery),
            shippingAddress: jsonEncode(order.shippingAddress.toJson()),
            billingAddress: Value(order.billingAddress?.toJson() != null
                ? jsonEncode(order.billingAddress!.toJson())
                : null),
            trackingNumber: Value(order.trackingNumber),
            couponCode: Value(order.couponCode),
            orderNotes: Value(order.orderNotes),
            isGift: order.isGift,
            giftMessage: Value(order.giftMessage),
            statusUpdates: jsonEncode(
                order.statusUpdates.map((s) => s.toJson()).toList()),
            isSynced: const Value(false),
            cachedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Mark order as synced
  Future<void> markOrderAsSynced(String orderId) async {
    await (_db.update(_db.orders)..where((tbl) => tbl.id.equals(orderId)))
        .write(const OrdersCompanion(isSynced: Value(true)));
  }

  /// Get unsynced orders
  Future<List<OrderEnhanced>> getUnsyncedOrders() async {
    final results = await (_db.select(_db.orders)
          ..where((tbl) => tbl.isSynced.equals(false)))
        .get();
    return results.map(_orderFromDb).toList();
  }

  /// Delete order from cache
  Future<void> deleteOrder(String id) async {
    await (_db.delete(_db.orders)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Clear all cached orders
  Future<void> clearAllOrders() async {
    await _db.delete(_db.orders).go();
  }

  /// Check if orders are cached
  Future<bool> hasCache() async {
    final count = await _db.select(_db.orders).get();
    return count.isNotEmpty;
  }

  /// Convert database model to Order
  OrderEnhanced _orderFromDb(Order dbOrder) {
    return OrderEnhanced(
      id: dbOrder.id,
      userId: dbOrder.userId,
      items: (jsonDecode(dbOrder.items) as List)
          .map((json) => models.CartItem.fromJson(json))
          .toList(),
      subtotal: dbOrder.subtotal,
      discount: dbOrder.discount,
      shippingCost: dbOrder.shippingCost,
      tax: dbOrder.tax,
      totalAmount: dbOrder.totalAmount,
      status: OrderStatus.values.firstWhere((e) => e.name == dbOrder.status),
      paymentStatus: PaymentStatus.values
          .firstWhere((e) => e.name == dbOrder.paymentStatus),
      paymentMethod: PaymentMethod.values
          .firstWhere((e) => e.name == dbOrder.paymentMethod),
      orderDate: dbOrder.orderDate,
      deliveryDate: dbOrder.deliveryDate,
      estimatedDelivery: dbOrder.estimatedDelivery,
      shippingAddress: Address.fromJson(jsonDecode(dbOrder.shippingAddress)),
      billingAddress: dbOrder.billingAddress != null
          ? Address.fromJson(jsonDecode(dbOrder.billingAddress!))
          : null,
      trackingNumber: dbOrder.trackingNumber,
      couponCode: dbOrder.couponCode,
      orderNotes: dbOrder.orderNotes,
      isGift: dbOrder.isGift,
      giftMessage: dbOrder.giftMessage,
      statusUpdates: (jsonDecode(dbOrder.statusUpdates) as List)
          .map((json) => OrderStatusUpdate.fromJson(json))
          .toList(),
    );
  }
}
