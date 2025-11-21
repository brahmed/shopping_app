import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Send FCM notification when a new notification document is created
 */
export const sendPushNotification = functions.firestore
  .document("notifications/{userId}/messages/{notificationId}")
  .onCreate(async (snap, context) => {
    const notification = snap.data();
    const {userId} = context.params;

    try {
      // Get user's FCM token (stored in user document)
      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .get();

      const fcmToken = userDoc.data()?.fcmToken;

      if (!fcmToken) {
        functions.logger.warn("No FCM token for user:", userId);
        return null;
      }

      // Send FCM notification
      const message = {
        notification: {
          title: notification.title,
          body: notification.message,
        },
        data: {
          type: notification.type,
          ...notification.data,
        },
        token: fcmToken,
      };

      await admin.messaging().send(message);
      functions.logger.info("Push notification sent:", userId);

      return null;
    } catch (error) {
      functions.logger.error("Error sending push notification:", error);
      throw error;
    }
  });
