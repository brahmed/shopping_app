import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/coupon_model.dart';

// Coupons State
class CouponsState {
  final List<Coupon> availableCoupons;
  final Coupon? appliedCoupon;
  final bool isLoading;
  final String? error;

  const CouponsState({
    this.availableCoupons = const [],
    this.appliedCoupon,
    this.isLoading = false,
    this.error,
  });

  bool get hasCouponApplied => appliedCoupon != null;

  CouponsState copyWith({
    List<Coupon>? availableCoupons,
    Coupon? appliedCoupon,
    bool clearAppliedCoupon = false,
    bool? isLoading,
    String? error,
  }) {
    return CouponsState(
      availableCoupons: availableCoupons ?? this.availableCoupons,
      appliedCoupon: clearAppliedCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Coupons Notifier
class CouponsNotifier extends StateNotifier<CouponsState> {
  CouponsNotifier() : super(const CouponsState()) {
    _loadCoupons();
  }

  Future<void> _loadCoupons() async {
    state = state.copyWith(isLoading: true);
    try {
      // Mock coupons - in real app, fetch from API
      final coupons = _getMockCoupons();
      state = CouponsState(availableCoupons: coupons, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  List<Coupon> _getMockCoupons() {
    final now = DateTime.now();
    return [
      Coupon(
        id: '1',
        code: 'WELCOME10',
        title: 'Welcome Discount',
        description: 'Get 10% off on your first order',
        type: CouponType.percentage,
        value: 10.0,
        minPurchaseAmount: 50.0,
        maxDiscountAmount: 20.0,
        validFrom: now.subtract(const Duration(days: 30)),
        validUntil: now.add(const Duration(days: 60)),
        usageLimit: 1,
      ),
      Coupon(
        id: '2',
        code: 'SAVE20',
        title: '\$20 Off',
        description: 'Save \$20 on orders over \$100',
        type: CouponType.fixed,
        value: 20.0,
        minPurchaseAmount: 100.0,
        validFrom: now.subtract(const Duration(days: 10)),
        validUntil: now.add(const Duration(days: 20)),
        usageLimit: 5,
      ),
      Coupon(
        id: '3',
        code: 'SUMMER25',
        title: 'Summer Sale',
        description: '25% off on all items',
        type: CouponType.percentage,
        value: 25.0,
        minPurchaseAmount: 75.0,
        maxDiscountAmount: 50.0,
        validFrom: now.subtract(const Duration(days: 5)),
        validUntil: now.add(const Duration(days: 30)),
        usageLimit: 10,
      ),
      Coupon(
        id: '4',
        code: 'FREESHIP',
        title: 'Free Shipping',
        description: 'Free shipping on orders over \$50',
        type: CouponType.fixed,
        value: 10.0,
        minPurchaseAmount: 50.0,
        validFrom: now.subtract(const Duration(days: 15)),
        validUntil: now.add(const Duration(days: 45)),
        usageLimit: 20,
      ),
      Coupon(
        id: '5',
        code: 'FLASH30',
        title: 'Flash Sale',
        description: '30% off - Limited time!',
        type: CouponType.percentage,
        value: 30.0,
        minPurchaseAmount: 150.0,
        maxDiscountAmount: 75.0,
        validFrom: now,
        validUntil: now.add(const Duration(days: 7)),
        usageLimit: 50,
      ),
    ];
  }

  Future<bool> applyCoupon(String code, double cartAmount) async {
    try {
      final coupon = state.availableCoupons.firstWhere(
        (c) => c.code.toUpperCase() == code.toUpperCase(),
      );

      if (!coupon.isValid) {
        state = state.copyWith(error: 'This coupon has expired or is no longer valid');
        return false;
      }

      if (coupon.minPurchaseAmount != null && cartAmount < coupon.minPurchaseAmount!) {
        state = state.copyWith(
          error:
              'Minimum purchase amount of \$${coupon.minPurchaseAmount!.toStringAsFixed(2)} required',
        );
        return false;
      }

      state = state.copyWith(appliedCoupon: coupon, error: null);
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Invalid coupon code');
      return false;
    }
  }

  void removeCoupon() {
    state = state.copyWith(clearAppliedCoupon: true, error: null);
  }

  double calculateDiscount(double amount) {
    if (state.appliedCoupon == null) return 0.0;
    return state.appliedCoupon!.calculateDiscount(amount);
  }

  List<Coupon> getValidCoupons(double cartAmount) {
    return state.availableCoupons.where((coupon) {
      return coupon.isValid &&
          (coupon.minPurchaseAmount == null || cartAmount >= coupon.minPurchaseAmount!);
    }).toList();
  }

  List<Coupon> getUpcomingCoupons() {
    final now = DateTime.now();
    return state.availableCoupons.where((coupon) {
      return coupon.validFrom.isAfter(now);
    }).toList();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final couponsProvider = StateNotifierProvider<CouponsNotifier, CouponsState>((ref) {
  return CouponsNotifier();
});
