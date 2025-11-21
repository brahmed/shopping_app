import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/coupon_model.dart';

void main() {
  group('Coupon Model Tests', () {
    late Coupon testCoupon;
    late DateTime now;

    setUp(() {
      now = DateTime.now();
      testCoupon = Coupon(
        id: 'coupon_1',
        code: 'SAVE10',
        title: '10% Off',
        description: 'Save 10% on your purchase',
        type: CouponType.percentage,
        value: 10.0,
        minPurchaseAmount: 50.0,
        maxDiscountAmount: 20.0,
        validFrom: now.subtract(const Duration(days: 7)),
        validUntil: now.add(const Duration(days: 30)),
        isActive: true,
        usageLimit: 100,
        usedCount: 25,
      );
    });

    test('should create a Coupon instance', () {
      expect(testCoupon, isA<Coupon>());
      expect(testCoupon.id, equals('coupon_1'));
      expect(testCoupon.code, equals('SAVE10'));
      expect(testCoupon.title, equals('10% Off'));
      expect(testCoupon.description, equals('Save 10% on your purchase'));
      expect(testCoupon.type, equals(CouponType.percentage));
      expect(testCoupon.value, equals(10.0));
      expect(testCoupon.minPurchaseAmount, equals(50.0));
      expect(testCoupon.maxDiscountAmount, equals(20.0));
      expect(testCoupon.isActive, isTrue);
      expect(testCoupon.usageLimit, equals(100));
      expect(testCoupon.usedCount, equals(25));
    });

    group('isValid Tests', () {
      test('should be valid when all conditions are met', () {
        expect(testCoupon.isValid, isTrue);
      });

      test('should be invalid when isActive is false', () {
        final inactiveCoupon = testCoupon.copyWith(isActive: false);
        expect(inactiveCoupon.isValid, isFalse);
      });

      test('should be invalid when before validFrom date', () {
        final futureCoupon = Coupon(
          id: 'coupon_2',
          code: 'FUTURE',
          title: 'Future Coupon',
          description: 'Not valid yet',
          type: CouponType.percentage,
          value: 15.0,
          validFrom: now.add(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );
        expect(futureCoupon.isValid, isFalse);
      });

      test('should be invalid when after validUntil date', () {
        final expiredCoupon = Coupon(
          id: 'coupon_3',
          code: 'EXPIRED',
          title: 'Expired Coupon',
          description: 'Already expired',
          type: CouponType.percentage,
          value: 20.0,
          validFrom: now.subtract(const Duration(days: 60)),
          validUntil: now.subtract(const Duration(days: 1)),
        );
        expect(expiredCoupon.isValid, isFalse);
      });

      test('should be invalid when usage limit reached', () {
        final maxedOutCoupon = testCoupon.copyWith(
          usageLimit: 10,
          usedCount: 10,
        );
        expect(maxedOutCoupon.isValid, isFalse);
      });

      test('should be valid on the last available use', () {
        final lastUseCoupon = testCoupon.copyWith(
          usageLimit: 100,
          usedCount: 99,
        );
        expect(lastUseCoupon.isValid, isTrue);
      });
    });

    group('isExpired Tests', () {
      test('should not be expired when within validity period', () {
        expect(testCoupon.isExpired, isFalse);
      });

      test('should be expired when after validUntil date', () {
        final expiredCoupon = Coupon(
          id: 'coupon_4',
          code: 'OLD',
          title: 'Old Coupon',
          description: 'This is old',
          type: CouponType.fixed,
          value: 5.0,
          validFrom: now.subtract(const Duration(days: 60)),
          validUntil: now.subtract(const Duration(days: 1)),
        );
        expect(expiredCoupon.isExpired, isTrue);
      });

      test('should not be expired on the last valid day', () {
        final lastDayCoupon = Coupon(
          id: 'coupon_5',
          code: 'LASTDAY',
          title: 'Last Day Coupon',
          description: 'Valid today',
          type: CouponType.percentage,
          value: 25.0,
          validFrom: now.subtract(const Duration(days: 7)),
          validUntil: now.add(const Duration(hours: 1)),
        );
        expect(lastDayCoupon.isExpired, isFalse);
      });
    });

    group('calculateDiscount Tests', () {
      test('should calculate percentage discount correctly', () {
        final percentageCoupon = Coupon(
          id: 'coupon_6',
          code: 'PERCENT10',
          title: '10% Off',
          description: '10 percent off',
          type: CouponType.percentage,
          value: 10.0,
          validFrom: now.subtract(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );

        expect(percentageCoupon.calculateDiscount(100.0), equals(10.0));
        expect(percentageCoupon.calculateDiscount(250.0), equals(25.0));
        expect(percentageCoupon.calculateDiscount(50.0), equals(5.0));
      });

      test('should calculate fixed discount correctly', () {
        final fixedCoupon = Coupon(
          id: 'coupon_7',
          code: 'FIXED20',
          title: '\$20 Off',
          description: 'Twenty dollars off',
          type: CouponType.fixed,
          value: 20.0,
          validFrom: now.subtract(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );

        expect(fixedCoupon.calculateDiscount(100.0), equals(20.0));
        expect(fixedCoupon.calculateDiscount(50.0), equals(20.0));
        expect(fixedCoupon.calculateDiscount(200.0), equals(20.0));
      });

      test('should apply maxDiscountAmount cap', () {
        final cappedCoupon = Coupon(
          id: 'coupon_8',
          code: 'CAPPED',
          title: '50% Off (Max \$25)',
          description: 'Big discount but capped',
          type: CouponType.percentage,
          value: 50.0,
          maxDiscountAmount: 25.0,
          validFrom: now.subtract(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );

        // 50% of 40 = 20 (under cap)
        expect(cappedCoupon.calculateDiscount(40.0), equals(20.0));

        // 50% of 100 = 50, but capped at 25
        expect(cappedCoupon.calculateDiscount(100.0), equals(25.0));

        // 50% of 200 = 100, but capped at 25
        expect(cappedCoupon.calculateDiscount(200.0), equals(25.0));
      });

      test('should return 0 when below minPurchaseAmount', () {
        final minPurchaseCoupon = Coupon(
          id: 'coupon_9',
          code: 'MIN50',
          title: '10% Off (Min \$50)',
          description: 'Requires minimum purchase',
          type: CouponType.percentage,
          value: 10.0,
          minPurchaseAmount: 50.0,
          validFrom: now.subtract(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );

        expect(minPurchaseCoupon.calculateDiscount(30.0), equals(0.0));
        expect(minPurchaseCoupon.calculateDiscount(49.99), equals(0.0));
        expect(minPurchaseCoupon.calculateDiscount(50.0), equals(5.0));
        expect(minPurchaseCoupon.calculateDiscount(100.0), equals(10.0));
      });

      test('should return 0 when coupon is not valid', () {
        final invalidCoupon = testCoupon.copyWith(isActive: false);
        expect(invalidCoupon.calculateDiscount(100.0), equals(0.0));
      });

      test('should handle edge case with 0 amount', () {
        expect(testCoupon.calculateDiscount(0.0), equals(0.0));
      });

      test('should handle 100% discount', () {
        final fullDiscountCoupon = Coupon(
          id: 'coupon_10',
          code: 'FREE100',
          title: '100% Off',
          description: 'Everything free',
          type: CouponType.percentage,
          value: 100.0,
          validFrom: now.subtract(const Duration(days: 1)),
          validUntil: now.add(const Duration(days: 30)),
        );

        expect(fullDiscountCoupon.calculateDiscount(100.0), equals(100.0));
      });
    });

    test('should serialize to JSON correctly', () {
      final json = testCoupon.toJson();

      expect(json['id'], equals('coupon_1'));
      expect(json['code'], equals('SAVE10'));
      expect(json['title'], equals('10% Off'));
      expect(json['description'], equals('Save 10% on your purchase'));
      expect(json['type'], equals('percentage'));
      expect(json['value'], equals(10.0));
      expect(json['minPurchaseAmount'], equals(50.0));
      expect(json['maxDiscountAmount'], equals(20.0));
      expect(json['isActive'], isTrue);
      expect(json['usageLimit'], equals(100));
      expect(json['usedCount'], equals(25));
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'coupon_11',
        'code': 'TEST20',
        'title': '\$20 Off',
        'description': 'Get twenty bucks off',
        'type': 'fixed',
        'value': 20.0,
        'minPurchaseAmount': 75.0,
        'maxDiscountAmount': null,
        'validFrom': now.subtract(const Duration(days: 5)).toIso8601String(),
        'validUntil': now.add(const Duration(days: 25)).toIso8601String(),
        'isActive': true,
        'usageLimit': 50,
        'usedCount': 10,
        'applicableCategories': ['Electronics', 'Sports'],
        'applicableProducts': null,
      };

      final coupon = Coupon.fromJson(json);

      expect(coupon.id, equals('coupon_11'));
      expect(coupon.code, equals('TEST20'));
      expect(coupon.title, equals('\$20 Off'));
      expect(coupon.type, equals(CouponType.fixed));
      expect(coupon.value, equals(20.0));
      expect(coupon.minPurchaseAmount, equals(75.0));
      expect(coupon.maxDiscountAmount, isNull);
      expect(coupon.applicableCategories, equals(['Electronics', 'Sports']));
      expect(coupon.applicableProducts, isNull);
    });

    test('should handle default values when fromJson', () {
      final json = {
        'id': 'coupon_12',
        'code': 'MINIMAL',
        'title': 'Minimal Coupon',
        'description': 'Bare bones',
        'type': 'percentage',
        'value': 5.0,
        'validFrom': now.toIso8601String(),
        'validUntil': now.add(const Duration(days: 7)).toIso8601String(),
      };

      final coupon = Coupon.fromJson(json);

      expect(coupon.isActive, isTrue);
      expect(coupon.usageLimit, equals(1));
      expect(coupon.usedCount, equals(0));
      expect(coupon.minPurchaseAmount, isNull);
      expect(coupon.maxDiscountAmount, isNull);
      expect(coupon.applicableCategories, isNull);
      expect(coupon.applicableProducts, isNull);
    });

    test('should correctly round-trip JSON serialization', () {
      final json = testCoupon.toJson();
      final deserialized = Coupon.fromJson(json);

      expect(deserialized.id, equals(testCoupon.id));
      expect(deserialized.code, equals(testCoupon.code));
      expect(deserialized.title, equals(testCoupon.title));
      expect(deserialized.description, equals(testCoupon.description));
      expect(deserialized.type, equals(testCoupon.type));
      expect(deserialized.value, equals(testCoupon.value));
      expect(deserialized.minPurchaseAmount, equals(testCoupon.minPurchaseAmount));
      expect(deserialized.maxDiscountAmount, equals(testCoupon.maxDiscountAmount));
      expect(deserialized.isActive, equals(testCoupon.isActive));
      expect(deserialized.usageLimit, equals(testCoupon.usageLimit));
      expect(deserialized.usedCount, equals(testCoupon.usedCount));
    });

    test('should handle both CouponType values', () {
      final percentageCoupon = testCoupon.copyWith(type: CouponType.percentage);
      expect(percentageCoupon.type, equals(CouponType.percentage));

      final fixedCoupon = testCoupon.copyWith(type: CouponType.fixed);
      expect(fixedCoupon.type, equals(CouponType.fixed));
    });

    test('should create copy with updated values', () {
      final updated = testCoupon.copyWith(
        code: 'NEWSAVE15',
        value: 15.0,
        usedCount: 30,
      );

      expect(updated.code, equals('NEWSAVE15'));
      expect(updated.value, equals(15.0));
      expect(updated.usedCount, equals(30));
      expect(updated.id, equals(testCoupon.id));
      expect(updated.title, equals(testCoupon.title));
    });
  });
}
