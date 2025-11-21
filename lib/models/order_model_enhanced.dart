import 'address_model.dart';
import 'cart_item_model.dart';

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returned,
  refunded,
}

enum PaymentMethod {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
  cashOnDelivery,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

class OrderEnhanced {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double shippingCost;
  final double tax;
  final double totalAmount;
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final PaymentMethod paymentMethod;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final DateTime? estimatedDelivery;
  final Address shippingAddress;
  final Address? billingAddress;
  final String? trackingNumber;
  final String? couponCode;
  final String? orderNotes;
  final bool isGift;
  final String? giftMessage;
  final List<OrderStatusUpdate> statusUpdates;

  OrderEnhanced({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    this.discount = 0.0,
    this.shippingCost = 0.0,
    this.tax = 0.0,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderDate,
    this.deliveryDate,
    this.estimatedDelivery,
    required this.shippingAddress,
    this.billingAddress,
    this.trackingNumber,
    this.couponCode,
    this.orderNotes,
    this.isGift = false,
    this.giftMessage,
    this.statusUpdates = const [],
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get canCancel => status == OrderStatus.pending || status == OrderStatus.confirmed;

  bool get canReturn => status == OrderStatus.delivered &&
      deliveryDate != null &&
      DateTime.now().difference(deliveryDate!).inDays <= 30;

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
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.returned:
        return 'Returned';
      case OrderStatus.refunded:
        return 'Refunded';
    }
  }

  String get paymentMethodString {
    switch (paymentMethod) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }

  factory OrderEnhanced.fromJson(Map<String, dynamic> json) {
    return OrderEnhanced(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List).map((item) => CartItem.fromJson(item)).toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      shippingCost: (json['shippingCost'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: OrderStatus.values[json['status'] as int],
      paymentStatus: PaymentStatus.values[json['paymentStatus'] as int],
      paymentMethod: PaymentMethod.values[json['paymentMethod'] as int],
      orderDate: DateTime.parse(json['orderDate'] as String),
      deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
      estimatedDelivery: json['estimatedDelivery'] != null
          ? DateTime.parse(json['estimatedDelivery'])
          : null,
      shippingAddress: Address.fromJson(json['shippingAddress']),
      billingAddress:
          json['billingAddress'] != null ? Address.fromJson(json['billingAddress']) : null,
      trackingNumber: json['trackingNumber'] as String?,
      couponCode: json['couponCode'] as String?,
      orderNotes: json['orderNotes'] as String?,
      isGift: json['isGift'] as bool? ?? false,
      giftMessage: json['giftMessage'] as String?,
      statusUpdates: (json['statusUpdates'] as List?)
              ?.map((update) => OrderStatusUpdate.fromJson(update))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'shippingCost': shippingCost,
      'tax': tax,
      'totalAmount': totalAmount,
      'status': status.index,
      'paymentStatus': paymentStatus.index,
      'paymentMethod': paymentMethod.index,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
      'shippingAddress': shippingAddress.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'trackingNumber': trackingNumber,
      'couponCode': couponCode,
      'orderNotes': orderNotes,
      'isGift': isGift,
      'giftMessage': giftMessage,
      'statusUpdates': statusUpdates.map((update) => update.toJson()).toList(),
    };
  }

  OrderEnhanced copyWith({
    String? id,
    String? userId,
    List<CartItem>? items,
    double? subtotal,
    double? discount,
    double? shippingCost,
    double? tax,
    double? totalAmount,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    PaymentMethod? paymentMethod,
    DateTime? orderDate,
    DateTime? deliveryDate,
    DateTime? estimatedDelivery,
    Address? shippingAddress,
    Address? billingAddress,
    String? trackingNumber,
    String? couponCode,
    String? orderNotes,
    bool? isGift,
    String? giftMessage,
    List<OrderStatusUpdate>? statusUpdates,
  }) {
    return OrderEnhanced(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shippingCost: shippingCost ?? this.shippingCost,
      tax: tax ?? this.tax,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      couponCode: couponCode ?? this.couponCode,
      orderNotes: orderNotes ?? this.orderNotes,
      isGift: isGift ?? this.isGift,
      giftMessage: giftMessage ?? this.giftMessage,
      statusUpdates: statusUpdates ?? this.statusUpdates,
    );
  }
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String? notes;

  OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    this.notes,
  });

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      status: OrderStatus.values[json['status'] as int],
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }
}
