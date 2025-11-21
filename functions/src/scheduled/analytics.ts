import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Aggregate daily analytics
 * Runs every day at midnight
 */
export const aggregateDailyStats = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    const db = admin.firestore();
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    yesterday.setHours(0, 0, 0, 0);

    const tomorrow = new Date(yesterday);
    tomorrow.setDate(tomorrow.getDate() + 1);

    try {
      // Get orders from yesterday
      const ordersSnapshot = await db
        .collection("orders")
        .where(
          "orderDate",
          ">=",
          admin.firestore.Timestamp.fromDate(yesterday)
        )
        .where("orderDate", "<", admin.firestore.Timestamp.fromDate(tomorrow))
        .get();

      // Calculate stats
      const stats = {
        date: yesterday.toISOString().split("T")[0],
        orders: {
          total: ordersSnapshot.size,
          completed: 0,
          cancelled: 0,
          revenue: 0,
        },
        users: {
          newUsers: 0,
          activeUsers: new Set(),
        },
        products: {
          totalSold: 0,
          topProducts: {} as Record<string, number>,
        },
      };

      // Process orders
      ordersSnapshot.docs.forEach((doc) => {
        const order = doc.data();
        stats.users.activeUsers.add(order.userId);

        if (order.status === 5) {
          // Delivered
          stats.orders.completed++;
          stats.orders.revenue += order.pricing.total;
        }

        if (order.status === 6) {
          // Cancelled
          stats.orders.cancelled++;
        }

        // Count products
        order.items.forEach((item: any) => {
          stats.products.totalSold += item.quantity;
          stats.products.topProducts[item.productId] =
            (stats.products.topProducts[item.productId] || 0) + item.quantity;
        });
      });

      // Get new users from yesterday
      const usersSnapshot = await db
        .collection("users")
        .where(
          "createdAt",
          ">=",
          admin.firestore.Timestamp.fromDate(yesterday)
        )
        .where("createdAt", "<", admin.firestore.Timestamp.fromDate(tomorrow))
        .get();

      stats.users.newUsers = usersSnapshot.size;

      // Save analytics
      await db
        .collection("admin")
        .doc("analytics")
        .collection("daily")
        .doc(stats.date)
        .set({
          ...stats,
          users: {
            ...stats.users,
            activeUsers: stats.users.activeUsers.size,
          },
          generatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      functions.logger.info("Daily analytics generated:", stats.date);
    } catch (error) {
      functions.logger.error("Error generating analytics:", error);
      throw error;
    }
  });

/**
 * Send weekly report to admins
 * Runs every Monday at 9 AM
 */
export const sendWeeklyReport = functions.pubsub
  .schedule("0 9 * * 1")
  .timeZone("America/New_York")
  .onRun(async (context) => {
    // TODO: Implement weekly email report to admins
    // - Get last 7 days of analytics
    // - Format into email
    // - Send using SendGrid or similar service

    functions.logger.info("Weekly report scheduled");
    return null;
  });
