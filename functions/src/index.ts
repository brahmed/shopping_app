import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export all function modules
export * from "./triggers/auth";
export * from "./triggers/orders";
export * from "./triggers/products";
export * from "./triggers/notifications";
export * from "./callable/coupons";
export * from "./callable/admin";
export * from "./scheduled/analytics";

// Simple health check function
export const healthCheck = functions.https.onRequest((req, res) => {
  res.json({
    status: "ok",
    timestamp: new Date().toISOString(),
    environment: process.env.FUNCTIONS_EMULATOR ? "emulator" : "production",
  });
});
