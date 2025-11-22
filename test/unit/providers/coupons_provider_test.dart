import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/coupons_provider.dart';
import 'package:shopping_app/models/coupon_model.dart';

void main() {
  group('CouponsProvider Tests', () {
    late ProviderContainer container;

    setUp(() async {
      container = ProviderContainer();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(couponsProvider);

        expect(state.availableCoupons, isNotEmpty);
        expect(state.appliedCoupon, isNull);
        expect(state.isLoading, false);
        expect(state.error, isNull);
        expect(state.hasCouponApplied, false);
      });

      test('should load mock coupons', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(couponsProvider);

        expect(state.availableCoupons.length, greaterThan(0));
      });
    });

    group('Apply Coupon', () {
      test('should apply valid coupon code', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('WELCOME10', 100.0);

        expect(result, true);
        expect(container.read(couponsProvider).appliedCoupon, isNotNull);
        expect(container.read(couponsProvider).hasCouponApplied, true);
      });

      test('should handle case-insensitive coupon codes', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('welcome10', 100.0);

        expect(result, true);
        expect(container.read(couponsProvider).appliedCoupon, isNotNull);
      });

      test('should reject invalid coupon code', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('INVALID123', 100.0);

        expect(result, false);
        expect(container.read(couponsProvider).appliedCoupon, isNull);
        expect(container.read(couponsProvider).error, isNotNull);
      });

      test('should reject coupon when cart amount is below minimum', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('WELCOME10', 10.0);

        expect(result, false);
        expect(container.read(couponsProvider).error, contains('Minimum purchase'));
      });

      test('should apply coupon when cart amount meets minimum', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('WELCOME10', 100.0);

        expect(result, true);
      });
    });

    group('Remove Coupon', () {
      test('should remove applied coupon', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('WELCOME10', 100.0);
        expect(container.read(couponsProvider).appliedCoupon, isNotNull);

        notifier.removeCoupon();

        expect(container.read(couponsProvider).appliedCoupon, isNull);
        expect(container.read(couponsProvider).hasCouponApplied, false);
        expect(container.read(couponsProvider).error, isNull);
      });

      test('should handle removing when no coupon applied', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        notifier.removeCoupon();

        expect(container.read(couponsProvider).appliedCoupon, isNull);
      });
    });

    group('Calculate Discount', () {
      test('should calculate percentage discount', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('WELCOME10', 100.0);

        final discount = notifier.calculateDiscount(100.0);

        expect(discount, 10.0);
      });

      test('should calculate fixed discount', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('SAVE20', 150.0);

        final discount = notifier.calculateDiscount(150.0);

        expect(discount, 20.0);
      });

      test('should return 0 when no coupon applied', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final discount = notifier.calculateDiscount(100.0);

        expect(discount, 0.0);
      });

      test('should respect maximum discount amount', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('WELCOME10', 500.0);

        final discount = notifier.calculateDiscount(500.0);

        // WELCOME10 has maxDiscount of 20.0
        expect(discount, lessThanOrEqualTo(20.0));
      });
    });

    group('Get Valid Coupons', () {
      test('should get valid coupons for cart amount', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final validCoupons = notifier.getValidCoupons(100.0);

        expect(validCoupons, isNotEmpty);
        expect(
          validCoupons.every((c) =>
              c.isValid &&
              (c.minPurchaseAmount == null ||
                  100.0 >= c.minPurchaseAmount!)),
          true,
        );
      });

      test('should filter out coupons below minimum purchase', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final validCoupons = notifier.getValidCoupons(30.0);

        expect(
          validCoupons.every((c) =>
              c.minPurchaseAmount == null || 30.0 >= c.minPurchaseAmount!),
          true,
        );
      });

      test('should return only currently valid coupons', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final validCoupons = notifier.getValidCoupons(200.0);

        expect(validCoupons.every((c) => c.isValid), true);
      });
    });

    group('Get Upcoming Coupons', () {
      test('should get upcoming coupons', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final upcomingCoupons = notifier.getUpcomingCoupons();

        // May or may not have upcoming coupons depending on mock data
        expect(upcomingCoupons, isA<List<Coupon>>());
      });
    });

    group('Clear Error', () {
      test('should clear error', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('INVALID', 100.0);
        expect(container.read(couponsProvider).error, isNotNull);

        notifier.clearError();

        expect(container.read(couponsProvider).error, isNull);
      });
    });

    group('CouponsState copyWith', () {
      test('should copy with new available coupons', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        const original = CouponsState();
        final testCoupon = Coupon(
          id: '1',
          code: 'TEST',
          title: 'Test Coupon',
          description: 'Test',
          type: CouponType.percentage,
          value: 10.0,
          validFrom: DateTime.now(),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final copied = original.copyWith(availableCoupons: [testCoupon]);

        expect(copied.availableCoupons.length, 1);
      });

      test('should copy with applied coupon', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        const original = CouponsState();
        final testCoupon = Coupon(
          id: '1',
          code: 'TEST',
          title: 'Test Coupon',
          description: 'Test',
          type: CouponType.fixed,
          value: 20.0,
          validFrom: DateTime.now(),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final copied = original.copyWith(appliedCoupon: testCoupon);

        expect(copied.appliedCoupon, isNotNull);
        expect(copied.hasCouponApplied, true);
      });

      test('should clear applied coupon', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final testCoupon = Coupon(
          id: '1',
          code: 'TEST',
          title: 'Test Coupon',
          description: 'Test',
          type: CouponType.fixed,
          value: 20.0,
          validFrom: DateTime.now(),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final original = CouponsState(appliedCoupon: testCoupon);
        final copied = original.copyWith(clearAppliedCoupon: true);

        expect(copied.appliedCoupon, isNull);
      });
    });

    group('Coupon Model', () {
      test('should validate coupon correctly', () {
        final validCoupon = Coupon(
          id: '1',
          code: 'VALID',
          title: 'Valid Coupon',
          description: 'Test',
          type: CouponType.percentage,
          value: 10.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
          usageLimit: 10,
          usedCount: 5,
        );

        expect(validCoupon.isValid, true);
        expect(validCoupon.isExpired, false);
      });

      test('should detect expired coupon', () {
        final expiredCoupon = Coupon(
          id: '1',
          code: 'EXPIRED',
          title: 'Expired Coupon',
          description: 'Test',
          type: CouponType.percentage,
          value: 10.0,
          validFrom: DateTime.now().subtract(const Duration(days: 60)),
          validUntil: DateTime.now().subtract(const Duration(days: 1)),
        );

        expect(expiredCoupon.isValid, false);
        expect(expiredCoupon.isExpired, true);
      });

      test('should detect usage limit reached', () {
        final limitReachedCoupon = Coupon(
          id: '1',
          code: 'LIMIT',
          title: 'Limit Reached',
          description: 'Test',
          type: CouponType.percentage,
          value: 10.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
          usageLimit: 5,
          usedCount: 5,
        );

        expect(limitReachedCoupon.isValid, false);
      });

      test('should calculate percentage discount correctly', () {
        final coupon = Coupon(
          id: '1',
          code: 'PERCENT',
          title: 'Percentage Discount',
          description: 'Test',
          type: CouponType.percentage,
          value: 15.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final discount = coupon.calculateDiscount(100.0);

        expect(discount, 15.0);
      });

      test('should calculate fixed discount correctly', () {
        final coupon = Coupon(
          id: '1',
          code: 'FIXED',
          title: 'Fixed Discount',
          description: 'Test',
          type: CouponType.fixed,
          value: 25.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final discount = coupon.calculateDiscount(100.0);

        expect(discount, 25.0);
      });

      test('should enforce minimum purchase amount', () {
        final coupon = Coupon(
          id: '1',
          code: 'MIN',
          title: 'Minimum Purchase',
          description: 'Test',
          type: CouponType.percentage,
          value: 10.0,
          minPurchaseAmount: 50.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final discountBelow = coupon.calculateDiscount(40.0);
        final discountAbove = coupon.calculateDiscount(60.0);

        expect(discountBelow, 0.0);
        expect(discountAbove, 6.0);
      });

      test('should enforce maximum discount amount', () {
        final coupon = Coupon(
          id: '1',
          code: 'MAX',
          title: 'Max Discount',
          description: 'Test',
          type: CouponType.percentage,
          value: 50.0,
          maxDiscountAmount: 20.0,
          validFrom: DateTime.now().subtract(const Duration(days: 1)),
          validUntil: DateTime.now().add(const Duration(days: 30)),
        );

        final discount = coupon.calculateDiscount(100.0);

        expect(discount, 20.0);
      });
    });

    group('Edge Cases', () {
      test('should handle applying multiple coupons in sequence', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('WELCOME10', 100.0);
        expect(container.read(couponsProvider).appliedCoupon?.code, 'WELCOME10');

        await notifier.applyCoupon('SAVE20', 150.0);
        expect(container.read(couponsProvider).appliedCoupon?.code, 'SAVE20');
      });

      test('should handle whitespace in coupon code', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon(' WELCOME10 ', 100.0);

        expect(result, true);
      });

      test('should handle very large cart amounts', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        await notifier.applyCoupon('SUMMER25', 1000000.0);

        final discount = notifier.calculateDiscount(1000000.0);

        expect(discount, greaterThan(0));
      });

      test('should handle zero cart amount', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final notifier = container.read(couponsProvider.notifier);

        final result = await notifier.applyCoupon('WELCOME10', 0.0);

        expect(result, false);
      });
    });
  });
}
