import 'cart_item_model.dart';

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String deliveryAddress;
  final String? trackingNumber;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
    required this.deliveryAddress,
    this.trackingNumber,
  });

  String get statusString {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: OrderStatus.values[json['status'] as int],
      orderDate: DateTime.parse(json['orderDate']),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      deliveryAddress: json['deliveryAddress'] as String,
      trackingNumber: json['trackingNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.index,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'trackingNumber': trackingNumber,
    };
  }
}
