import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface ValidateCouponData {
  code: string;
  cartTotal: number;
  userId: string;
}

/**
 * Validate a coupon code
 */
export const validateCoupon = functions.https.onCall(
  async (data: ValidateCouponData, context) => {
    // Verify authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Must be authenticated to validate coupons"
      );
    }

    const db = admin.firestore();
    const {code, cartTotal, userId} = data;

    try {
      // Get coupon by code
      const couponSnapshot = await db
        .collection("coupons")
        .where("code", "==", code.toUpperCase())
        .limit(1)
        .get();

      if (couponSnapshot.empty) {
        return {valid: false, error: "Invalid coupon code"};
      }

      const coupon = couponSnapshot.docs[0].data();
      const now = admin.firestore.Timestamp.now();

      // Check if active
      if (!coupon.isActive) {
        return {valid: false, error: "This coupon is no longer active"};
      }

      // Check validity period
      if (coupon.validFrom > now || coupon.validUntil < now) {
        return {valid: false, error: "This coupon has expired"};
      }

      // Check usage limit
      if (coupon.usedCount >= coupon.usageLimit) {
        return {valid: false, error: "This coupon has reached its usage limit"};
      }

      // Check min purchase amount
      if (coupon.minPurchaseAmount && cartTotal < coupon.minPurchaseAmount) {
        return {
          valid: false,
          error: `Minimum purchase of $${coupon.minPurchaseAmount} required`,
        };
      }

      // Calculate discount
      let discount = 0;
      if (coupon.type === "percentage") {
        discount = cartTotal * (coupon.value / 100);
      } else {
        discount = coupon.value;
      }

      // Apply max discount cap
      if (coupon.maxDiscountAmount && discount > coupon.maxDiscountAmount) {
        discount = coupon.maxDiscountAmount;
      }

      return {
        valid: true,
        discount,
        couponId: couponSnapshot.docs[0].id,
        code: coupon.code,
      };
    } catch (error) {
      functions.logger.error("Error validating coupon:", error);
      throw new functions.https.HttpsError("internal", "Error validating coupon");
    }
  }
);
