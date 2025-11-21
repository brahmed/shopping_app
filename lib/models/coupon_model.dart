class Coupon {
  final String id;
  final String code;
  final String title;
  final String description;
  final CouponType type;
  final double value;
  final double? minPurchaseAmount;
  final double? maxDiscountAmount;
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isActive;
  final int usageLimit;
  final int usedCount;
  final List<String>? applicableCategories;
  final List<String>? applicableProducts;

  Coupon({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.type,
    required this.value,
    this.minPurchaseAmount,
    this.maxDiscountAmount,
    required this.validFrom,
    required this.validUntil,
    this.isActive = true,
    this.usageLimit = 1,
    this.usedCount = 0,
    this.applicableCategories,
    this.applicableProducts,
  });

  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(validFrom) &&
        now.isBefore(validUntil) &&
        usedCount < usageLimit;
  }

  bool get isExpired {
    return DateTime.now().isAfter(validUntil);
  }

  double calculateDiscount(double amount) {
    if (!isValid) return 0.0;
    if (minPurchaseAmount != null && amount < minPurchaseAmount!) return 0.0;

    double discount = 0.0;
    if (type == CouponType.percentage) {
      discount = amount * (value / 100);
    } else {
      discount = value;
    }

    if (maxDiscountAmount != null && discount > maxDiscountAmount!) {
      discount = maxDiscountAmount!;
    }

    return discount;
  }

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: CouponType.values.firstWhere(
        (e) => e.toString() == 'CouponType.${json['type']}',
      ),
      value: (json['value'] as num).toDouble(),
      minPurchaseAmount: json['minPurchaseAmount'] != null
          ? (json['minPurchaseAmount'] as num).toDouble()
          : null,
      maxDiscountAmount: json['maxDiscountAmount'] != null
          ? (json['maxDiscountAmount'] as num).toDouble()
          : null,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validUntil: DateTime.parse(json['validUntil'] as String),
      isActive: json['isActive'] as bool? ?? true,
      usageLimit: json['usageLimit'] as int? ?? 1,
      usedCount: json['usedCount'] as int? ?? 0,
      applicableCategories: json['applicableCategories'] != null
          ? List<String>.from(json['applicableCategories'])
          : null,
      applicableProducts: json['applicableProducts'] != null
          ? List<String>.from(json['applicableProducts'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'value': value,
      'minPurchaseAmount': minPurchaseAmount,
      'maxDiscountAmount': maxDiscountAmount,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'isActive': isActive,
      'usageLimit': usageLimit,
      'usedCount': usedCount,
      'applicableCategories': applicableCategories,
      'applicableProducts': applicableProducts,
    };
  }
}

enum CouponType {
  percentage,
  fixed,
}
