import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Set custom claims for a user (admin only)
 */
export const setUserClaims = functions.https.onCall(async (data, context) => {
  // Verify admin
  if (!context.auth?.token.role || context.auth.token.role !== "admin") {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can set user claims"
    );
  }

  const {userId, claims} = data;

  try {
    await admin.auth().setCustomUserClaims(userId, claims);
    functions.logger.info("Custom claims set:", userId, claims);

    return {success: true};
  } catch (error) {
    functions.logger.error("Error setting custom claims:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error setting custom claims"
    );
  }
});

/**
 * Update product inventory (admin only)
 */
export const updateInventory = functions.https.onCall(async (data, context) => {
  // Verify admin or vendor
  const role = context.auth?.token.role;
  if (!role || (role !== "admin" && role !== "vendor")) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins and vendors can update inventory"
    );
  }

  const {productId, quantity} = data;
  const db = admin.firestore();

  try {
    await db
      .collection("products")
      .doc(productId)
      .update({
        "inventory.quantity": admin.firestore.FieldValue.increment(quantity),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    functions.logger.info("Inventory updated:", productId, quantity);
    return {success: true};
  } catch (error) {
    functions.logger.error("Error updating inventory:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error updating inventory"
    );
  }
});
