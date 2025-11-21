import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Trigger when a new order is created
 */
export const onOrderCreated = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snap, context) => {
    const db = admin.firestore();
    const order = snap.data();
    const {orderId} = context.params;

    try {
      // 1. Update inventory for each product
      const batch = db.batch();
      for (const item of order.items) {
        const productRef = db.collection("products").doc(item.productId);
        batch.update(productRef, {
          "inventory.quantity": admin.firestore.FieldValue.increment(
            -item.quantity
          ),
          "metadata.purchases": admin.firestore.FieldValue.increment(1),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();

      // 2. Update user stats
      await db
        .collection("users")
        .doc(order.userId)
        .update({
          "stats.totalOrders": admin.firestore.FieldValue.increment(1),
          "stats.totalSpent": admin.firestore.FieldValue.increment(
            order.pricing.total
          ),
        });

      // 3. Add loyalty points (1 point per dollar)
      const points = Math.floor(order.pricing.total);
      await db
        .collection("users")
        .doc(order.userId)
        .update({
          loyaltyPoints: admin.firestore.FieldValue.increment(points),
        });

      // 4. Send order confirmation notification
      await db
        .collection("notifications")
        .doc(order.userId)
        .collection("messages")
        .add({
          id: db.collection("notifications").doc().id,
          userId: order.userId,
          title: "Order Confirmed!",
          message: `Your order #${orderId.substring(0, 8)} has been confirmed.`,
          type: "order",
          isRead: false,
          data: {orderId},
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      // 5. Clear user's cart
      await db.collection("cart").doc(order.userId).delete();

      functions.logger.info("Order processed:", orderId);
    } catch (error) {
      functions.logger.error("Error processing order:", error);
      throw error;
    }
  });

/**
 * Trigger when order status is updated
 */
export const onOrderStatusUpdate = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change, context) => {
    const db = admin.firestore();
    const before = change.before.data();
    const after = change.after.data();
    const {orderId} = context.params;

    try {
      // Only proceed if status changed
      if (before.status === after.status) {
        return null;
      }

      const statusMessages: Record<number, string> = {
        1: "Your order has been confirmed and is being prepared.",
        2: "Your order is being processed.",
        3: "Your order has been shipped!",
        4: "Your order is out for delivery.",
        5: "Your order has been delivered.",
      };

      const message = statusMessages[after.status] ||
        "Your order status has been updated.";

      // Send status update notification
      await db
        .collection("notifications")
        .doc(after.userId)
        .collection("messages")
        .add({
          id: db.collection("notifications").doc().id,
          userId: after.userId,
          title: "Order Update",
          message,
          type: "delivery",
          isRead: false,
          data: {orderId},
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      // If delivered, schedule review request (after 3 days)
      if (after.status === 5) {
        // TODO: Implement delayed review request
        // Could use Pub/Sub with delay or Firebase Extensions
      }

      functions.logger.info("Order status updated:", orderId);
      return null;
    } catch (error) {
      functions.logger.error("Error handling order status update:", error);
      throw error;
    }
  });
