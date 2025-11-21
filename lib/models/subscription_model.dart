import 'product_model.dart';

enum SubscriptionFrequency {
  weekly,
  biweekly,
  monthly,
  bimonthly,
  quarterly,
}

enum SubscriptionStatus {
  active,
  paused,
  cancelled,
  expired,
}

class Subscription {
  final String id;
  final String userId;
  final Product product;
  final int quantity;
  final SubscriptionFrequency frequency;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime? nextDeliveryDate;
  final DateTime? endDate;
  final double discountPercentage;
  final String? selectedSize;
  final String? selectedColor;

  Subscription({
    required this.id,
    required this.userId,
    required this.product,
    this.quantity = 1,
    required this.frequency,
    required this.status,
    required this.startDate,
    this.nextDeliveryDate,
    this.endDate,
    this.discountPercentage = 0.0,
    this.selectedSize,
    this.selectedColor,
  });

  double get discountedPrice {
    return product.price * (1 - discountPercentage / 100);
  }

  double get totalPrice {
    return discountedPrice * quantity;
  }

  String get frequencyString {
    switch (frequency) {
      case SubscriptionFrequency.weekly:
        return 'Weekly';
      case SubscriptionFrequency.biweekly:
        return 'Every 2 Weeks';
      case SubscriptionFrequency.monthly:
        return 'Monthly';
      case SubscriptionFrequency.bimonthly:
        return 'Every 2 Months';
      case SubscriptionFrequency.quarterly:
        return 'Quarterly';
    }
  }

  String get statusString {
    switch (status) {
      case SubscriptionStatus.active:
        return 'Active';
      case SubscriptionStatus.paused:
        return 'Paused';
      case SubscriptionStatus.cancelled:
        return 'Cancelled';
      case SubscriptionStatus.expired:
        return 'Expired';
    }
  }

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      userId: json['userId'] as String,
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] as int? ?? 1,
      frequency: SubscriptionFrequency.values[json['frequency'] as int],
      status: SubscriptionStatus.values[json['status'] as int],
      startDate: DateTime.parse(json['startDate'] as String),
      nextDeliveryDate: json['nextDeliveryDate'] != null
          ? DateTime.parse(json['nextDeliveryDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      selectedSize: json['selectedSize'] as String?,
      selectedColor: json['selectedColor'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'product': product.toJson(),
      'quantity': quantity,
      'frequency': frequency.index,
      'status': status.index,
      'startDate': startDate.toIso8601String(),
      'nextDeliveryDate': nextDeliveryDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'discountPercentage': discountPercentage,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  Subscription copyWith({
    String? id,
    String? userId,
    Product? product,
    int? quantity,
    SubscriptionFrequency? frequency,
    SubscriptionStatus? status,
    DateTime? startDate,
    DateTime? nextDeliveryDate,
    DateTime? endDate,
    double? discountPercentage,
    String? selectedSize,
    String? selectedColor,
  }) {
    return Subscription(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      frequency: frequency ?? this.frequency,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      nextDeliveryDate: nextDeliveryDate ?? this.nextDeliveryDate,
      endDate: endDate ?? this.endDate,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
