import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Trigger when a new user is created
 * Creates user document in Firestore
 */
export const onUserCreated = functions.auth.user().onCreate(async (user) => {
  const db = admin.firestore();

  try {
    // Create user document
    await db.collection("users").doc(user.uid).set({
      uid: user.uid,
      email: user.email,
      profile: {
        fullName: user.displayName || "",
        avatarUrl: user.photoURL || "",
      },
      loyaltyPoints: 0,
      memberSince: admin.firestore.FieldValue.serverTimestamp(),
      preferences: {
        emailNotifications: true,
        pushNotifications: true,
        smsNotifications: false,
        priceAlerts: true,
        promotionalEmails: true,
        orderUpdates: true,
      },
      stats: {
        totalOrders: 0,
        totalSpent: 0,
        productsReviewed: 0,
        wishlistItems: 0,
        averageOrderValue: 0,
      },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Send welcome notification
    await db
      .collection("notifications")
      .doc(user.uid)
      .collection("messages")
      .add({
        id: db.collection("notifications").doc().id,
        userId: user.uid,
        title: "Welcome to Shopping App!",
        message: "Thank you for joining us. Start exploring amazing products!",
        type: "general",
        isRead: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    functions.logger.info("User created:", user.uid);
  } catch (error) {
    functions.logger.error("Error creating user:", error);
    throw error;
  }
});

/**
 * Trigger when a user is deleted
 * Cleans up user data
 */
export const onUserDeleted = functions.auth.user().onDelete(async (user) => {
  const db = admin.firestore();
  const batch = db.batch();

  try {
    // Delete user document
    batch.delete(db.collection("users").doc(user.uid));

    // Delete cart
    batch.delete(db.collection("cart").doc(user.uid));

    // Note: Subcollections (addresses, wishlists) need separate deletion
    // This would be better handled by a callable function that deletes everything

    await batch.commit();
    functions.logger.info("User deleted:", user.uid);
  } catch (error) {
    functions.logger.error("Error deleting user data:", error);
    throw error;
  }
});
