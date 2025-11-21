import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Trigger when a review is created
 * Updates product rating
 */
export const onReviewCreated = functions.firestore
  .document("products/{productId}/reviews/{reviewId}")
  .onCreate(async (snap, context) => {
    const db = admin.firestore();
    const {productId} = context.params;
    const review = snap.data();

    try {
      // Get all reviews for this product
      const reviewsSnapshot = await db
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .get();

      // Calculate new average rating
      let totalRating = 0;
      reviewsSnapshot.docs.forEach((doc) => {
        totalRating += doc.data().rating;
      });
      const avgRating = totalRating / reviewsSnapshot.size;

      // Update product
      await db
        .collection("products")
        .doc(productId)
        .update({
          rating: avgRating,
          reviewCount: reviewsSnapshot.size,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      // Award loyalty points for review
      await db
        .collection("users")
        .doc(review.userId)
        .update({
          loyaltyPoints: admin.firestore.FieldValue.increment(10),
          "stats.productsReviewed": admin.firestore.FieldValue.increment(1),
        });

      functions.logger.info("Review processed:", context.params.reviewId);
    } catch (error) {
      functions.logger.error("Error processing review:", error);
      throw error;
    }
  });

/**
 * Trigger when a review is deleted
 * Updates product rating
 */
export const onReviewDeleted = functions.firestore
  .document("products/{productId}/reviews/{reviewId}")
  .onDelete(async (snap, context) => {
    const db = admin.firestore();
    const {productId} = context.params;

    try {
      // Get all remaining reviews
      const reviewsSnapshot = await db
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .get();

      if (reviewsSnapshot.empty) {
        // No reviews left
        await db.collection("products").doc(productId).update({
          rating: 0,
          reviewCount: 0,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      } else {
        // Recalculate average
        let totalRating = 0;
        reviewsSnapshot.docs.forEach((doc) => {
          totalRating += doc.data().rating;
        });
        const avgRating = totalRating / reviewsSnapshot.size;

        await db.collection("products").doc(productId).update({
          rating: avgRating,
          reviewCount: reviewsSnapshot.size,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      functions.logger.info("Review deletion processed");
    } catch (error) {
      functions.logger.error("Error processing review deletion:", error);
      throw error;
    }
  });
