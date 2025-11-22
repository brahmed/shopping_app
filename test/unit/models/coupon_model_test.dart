import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/coupon_model.dart';

void main() {
  group('Coupon Model Tests', () {
    late Coupon testPercentageCoupon;
    late Coupon testFixedCoupon;
    late DateTime now;
    late DateTime validFrom;
    late DateTime validUntil;

    setUp(() {
      now = DateTime.now();
      validFrom = now.subtract(const Duration(days: 1));
      validUntil = now.add(const Duration(days: 30));

      testPercentageCoupon = Coupon(
        id: 'coupon1',
        code: 'SAVE20',
        title: '20% Off',
        description: 'Get 20% off on your purchase',
        type: CouponType.percentage,
        value: 20.0,
        minPurchaseAmount: 50.0,
        maxDiscountAmount: 100.0,
        validFrom: validFrom,
        validUntil: validUntil,
        isActive: true,
        usageLimit: 100,
        usedCount: 25,
        applicableCategories: ['Electronics', 'Clothing'],
        applicableProducts: ['prod1', 'prod2'],
      );

      testFixedCoupon = Coupon(
        id: 'coupon2',
        code: 'FLAT10',
        title: '$10 Off',
        description: 'Get $10 flat discount',
        type: CouponType.fixed,
        value: 10.0,
        minPurchaseAmount: 30.0,
        validFrom: validFrom,
        validUntil: validUntil,
        isActive: true,
        usageLimit: 50,
        usedCount: 10,
      );
    });

    test('should create Coupon instance with all fields', () {
      expect(testPercentageCoupon.id, 'coupon1');
      expect(testPercentageCoupon.code, 'SAVE20');
      expect(testPercentageCoupon.title, '20% Off');
      expect(testPercentageCoupon.description, contains('20%'));
      expect(testPercentageCoupon.type, CouponType.percentage);
      expect(testPercentageCoupon.value, 20.0);
      expect(testPercentageCoupon.minPurchaseAmount, 50.0);
      expect(testPercentageCoupon.maxDiscountAmount, 100.0);
      expect(testPercentageCoupon.isActive, true);
      expect(testPercentageCoupon.usageLimit, 100);
      expect(testPercentageCoupon.usedCount, 25);
      expect(testPercentageCoupon.applicableCategories, ['Electronics', 'Clothing']);
      expect(testPercentageCoupon.applicableProducts, ['prod1', 'prod2']);
    });

    test('should have default values for optional fields', () {
      final coupon = Coupon(
        id: 'coupon3',
        code: 'TEST',
        title: 'Test Coupon',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: validFrom,
        validUntil: validUntil,
      );

      expect(coupon.minPurchaseAmount, null);
      expect(coupon.maxDiscountAmount, null);
      expect(coupon.isActive, true);
      expect(coupon.usageLimit, 1);
      expect(coupon.usedCount, 0);
      expect(coupon.applicableCategories, null);
      expect(coupon.applicableProducts, null);
    });

    test('should validate active coupon correctly', () {
      expect(testPercentageCoupon.isValid, true);
    });

    test('should invalidate inactive coupon', () {
      final inactiveCoupon = Coupon(
        id: 'coupon4',
        code: 'INACTIVE',
        title: 'Inactive',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: validFrom,
        validUntil: validUntil,
        isActive: false,
      );

      expect(inactiveCoupon.isValid, false);
    });

    test('should invalidate expired coupon', () {
      final expiredCoupon = Coupon(
        id: 'coupon5',
        code: 'EXPIRED',
        title: 'Expired',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: now.subtract(const Duration(days: 60)),
        validUntil: now.subtract(const Duration(days: 1)),
      );

      expect(expiredCoupon.isValid, false);
      expect(expiredCoupon.isExpired, true);
    });

    test('should invalidate future coupon', () {
      final futureCoupon = Coupon(
        id: 'coupon6',
        code: 'FUTURE',
        title: 'Future',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: now.add(const Duration(days: 1)),
        validUntil: now.add(const Duration(days: 30)),
      );

      expect(futureCoupon.isValid, false);
    });

    test('should invalidate coupon with exhausted usage limit', () {
      final exhaustedCoupon = Coupon(
        id: 'coupon7',
        code: 'EXHAUSTED',
        title: 'Exhausted',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: validFrom,
        validUntil: validUntil,
        usageLimit: 10,
        usedCount: 10, // Equal to limit
      );

      expect(exhaustedCoupon.isValid, false);
    });

    test('should calculate percentage discount correctly', () {
      final discount = testPercentageCoupon.calculateDiscount(100.0);
      expect(discount, 20.0); // 20% of 100
    });

    test('should calculate fixed discount correctly', () {
      final discount = testFixedCoupon.calculateDiscount(50.0);
      expect(discount, 10.0); // Fixed $10
    });

    test('should respect minimum purchase amount', () {
      final discount = testPercentageCoupon.calculateDiscount(40.0); // Less than min 50
      expect(discount, 0.0);
    });

    test('should respect maximum discount amount for percentage coupon', () {
      final discount = testPercentageCoupon.calculateDiscount(1000.0);
      // 20% of 1000 = 200, but max is 100
      expect(discount, 100.0);
    });

    test('should not apply discount for invalid coupon', () {
      final expiredCoupon = Coupon(
        id: 'coupon8',
        code: 'EXPIRED',
        title: 'Expired',
        description: 'Test',
        type: CouponType.percentage,
        value: 50.0,
        validFrom: now.subtract(const Duration(days: 60)),
        validUntil: now.subtract(const Duration(days: 1)),
      );

      final discount = expiredCoupon.calculateDiscount(100.0);
      expect(discount, 0.0);
    });

    test('should handle zero amount in discount calculation', () {
      final discount = testPercentageCoupon.calculateDiscount(0.0);
      expect(discount, 0.0);
    });

    test('should serialize to JSON correctly', () {
      final json = testPercentageCoupon.toJson();

      expect(json['id'], 'coupon1');
      expect(json['code'], 'SAVE20');
      expect(json['title'], '20% Off');
      expect(json['description'], contains('20%'));
      expect(json['type'], 'percentage');
      expect(json['value'], 20.0);
      expect(json['minPurchaseAmount'], 50.0);
      expect(json['maxDiscountAmount'], 100.0);
      expect(json['validFrom'], isA<String>());
      expect(json['validUntil'], isA<String>());
      expect(json['isActive'], true);
      expect(json['usageLimit'], 100);
      expect(json['usedCount'], 25);
      expect(json['applicableCategories'], ['Electronics', 'Clothing']);
      expect(json['applicableProducts'], ['prod1', 'prod2']);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'coupon9',
        'code': 'JSON20',
        'title': 'JSON Coupon',
        'description': 'Test JSON',
        'type': 'fixed',
        'value': 15.0,
        'minPurchaseAmount': 40.0,
        'maxDiscountAmount': 50.0,
        'validFrom': validFrom.toIso8601String(),
        'validUntil': validUntil.toIso8601String(),
        'isActive': true,
        'usageLimit': 200,
        'usedCount': 50,
        'applicableCategories': ['Sports'],
        'applicableProducts': ['prod3'],
      };

      final coupon = Coupon.fromJson(json);

      expect(coupon.id, 'coupon9');
      expect(coupon.code, 'JSON20');
      expect(coupon.title, 'JSON Coupon');
      expect(coupon.type, CouponType.fixed);
      expect(coupon.value, 15.0);
      expect(coupon.minPurchaseAmount, 40.0);
      expect(coupon.maxDiscountAmount, 50.0);
      expect(coupon.isActive, true);
      expect(coupon.usageLimit, 200);
      expect(coupon.usedCount, 50);
      expect(coupon.applicableCategories, ['Sports']);
      expect(coupon.applicableProducts, ['prod3']);
    });

    test('should handle both CouponType enum values', () {
      for (final type in CouponType.values) {
        final coupon = Coupon(
          id: 'test',
          code: 'TEST',
          title: 'Test',
          description: 'Test',
          type: type,
          value: 10.0,
          validFrom: validFrom,
          validUntil: validUntil,
        );

        final json = coupon.toJson();
        final recreatedCoupon = Coupon.fromJson(json);

        expect(recreatedCoupon.type, type);
      }
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'coupon10',
        'code': 'SIMPLE',
        'title': 'Simple Coupon',
        'description': 'Simple',
        'type': 'percentage',
        'value': 10.0,
        'validFrom': validFrom.toIso8601String(),
        'validUntil': validUntil.toIso8601String(),
      };

      final coupon = Coupon.fromJson(json);

      expect(coupon.minPurchaseAmount, null);
      expect(coupon.maxDiscountAmount, null);
      expect(coupon.isActive, true);
      expect(coupon.usageLimit, 1);
      expect(coupon.usedCount, 0);
      expect(coupon.applicableCategories, null);
      expect(coupon.applicableProducts, null);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testPercentageCoupon.toJson();
      final recreatedCoupon = Coupon.fromJson(json);

      expect(recreatedCoupon.id, testPercentageCoupon.id);
      expect(recreatedCoupon.code, testPercentageCoupon.code);
      expect(recreatedCoupon.title, testPercentageCoupon.title);
      expect(recreatedCoupon.description, testPercentageCoupon.description);
      expect(recreatedCoupon.type, testPercentageCoupon.type);
      expect(recreatedCoupon.value, testPercentageCoupon.value);
      expect(recreatedCoupon.minPurchaseAmount, testPercentageCoupon.minPurchaseAmount);
      expect(recreatedCoupon.maxDiscountAmount, testPercentageCoupon.maxDiscountAmount);
      expect(recreatedCoupon.isActive, testPercentageCoupon.isActive);
      expect(recreatedCoupon.usageLimit, testPercentageCoupon.usageLimit);
      expect(recreatedCoupon.usedCount, testPercentageCoupon.usedCount);
    });

    test('should handle numeric types in JSON (int/double conversion)', () {
      final json = {
        'id': 'coupon11',
        'code': 'NUMERIC',
        'title': 'Test',
        'description': 'Test',
        'type': 'percentage',
        'value': 25, // int instead of double
        'minPurchaseAmount': 100, // int instead of double
        'maxDiscountAmount': 50, // int instead of double
        'validFrom': validFrom.toIso8601String(),
        'validUntil': validUntil.toIso8601String(),
        'usageLimit': 10,
        'usedCount': 5,
      };

      final coupon = Coupon.fromJson(json);

      expect(coupon.value, 25.0);
      expect(coupon.minPurchaseAmount, 100.0);
      expect(coupon.maxDiscountAmount, 50.0);
    });

    test('should calculate discount with no max limit', () {
      final coupon = Coupon(
        id: 'coupon12',
        code: 'NOMAX',
        title: 'No Max',
        description: 'Test',
        type: CouponType.percentage,
        value: 20.0,
        validFrom: validFrom,
        validUntil: validUntil,
        // No maxDiscountAmount
      );

      final discount = coupon.calculateDiscount(1000.0);
      expect(discount, 200.0); // 20% of 1000, no cap
    });

    test('should calculate discount with no min purchase', () {
      final coupon = Coupon(
        id: 'coupon13',
        code: 'NOMIN',
        title: 'No Min',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: validFrom,
        validUntil: validUntil,
        // No minPurchaseAmount
      );

      final discount = coupon.calculateDiscount(5.0);
      expect(discount, 0.5); // 10% of 5
    });

    test('should validate edge case: exact usage limit', () {
      final coupon = Coupon(
        id: 'coupon14',
        code: 'EDGE',
        title: 'Edge',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: validFrom,
        validUntil: validUntil,
        usageLimit: 5,
        usedCount: 4, // One use remaining
      );

      expect(coupon.isValid, true);
    });

    test('should handle exact validity period boundaries', () {
      final exactNow = DateTime.now();
      final coupon = Coupon(
        id: 'coupon15',
        code: 'EXACT',
        title: 'Exact',
        description: 'Test',
        type: CouponType.percentage,
        value: 10.0,
        validFrom: exactNow.subtract(const Duration(seconds: 1)),
        validUntil: exactNow.add(const Duration(seconds: 1)),
      );

      expect(coupon.isValid, true);
    });
  });
}
