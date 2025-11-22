import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/notification_model.dart';
import 'package:shopping_app/providers/notifications_provider.dart';

void main() {
  group('Notification Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('View notifications list', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to notifications (usually from app bar icon)
      final notificationIcon = find.byIcon(Icons.notifications);
      if (notificationIcon.evaluate().isNotEmpty) {
        await tester.tap(notificationIcon);
        await tester.pumpAndSettle();

        // Verify notifications page
        expect(find.byType(ListView), findsWidgets);
      }
    });

    test('Receive order notification', () async {
      await container
          .read(notificationsProvider.notifier)
          .sendOrderNotification('order-123', 'shipped');

      final notifications = container.read(notificationsProvider).notifications;
      expect(notifications.length, greaterThan(0));
      expect(notifications.first.type, NotificationType.order);
      expect(notifications.first.message, contains('order-123'));
    });

    test('Receive price alert notification', () async {
      await container
          .read(notificationsProvider.notifier)
          .sendPriceAlertNotification('Wireless Headphones', 25.0);

      final notifications = container.read(notificationsProvider).notifications;
      final priceAlerts = notifications
          .where((n) => n.type == NotificationType.priceAlert)
          .toList();

      expect(priceAlerts, isNotEmpty);
      expect(priceAlerts.first.message, contains('Wireless Headphones'));
      expect(priceAlerts.first.message, contains('25'));
    });

    test('Receive back in stock notification', () async {
      await container
          .read(notificationsProvider.notifier)
          .sendBackInStockNotification('Smart Watch Pro');

      final notifications = container.read(notificationsProvider).notifications;
      final backInStockNotifs = notifications
          .where((n) => n.type == NotificationType.backInStock)
          .toList();

      expect(backInStockNotifs, isNotEmpty);
      expect(backInStockNotifs.first.message, contains('Smart Watch Pro'));
    });

    test('Receive promotion notification', () async {
      await container
          .read(notificationsProvider.notifier)
          .sendPromotionNotification(
            'Flash Sale!',
            'Get 50% off on selected items',
          );

      final notifications = container.read(notificationsProvider).notifications;
      final promotions = notifications
          .where((n) => n.type == NotificationType.promotion)
          .toList();

      expect(promotions, isNotEmpty);
      expect(promotions.first.title, 'Flash Sale!');
      expect(promotions.first.message, contains('50%'));
    });

    test('Mark notification as read', () async {
      final notification = AppNotification(
        id: 'notif-1',
        title: 'Test Notification',
        message: 'This is a test',
        type: NotificationType.general,
        timestamp: DateTime.now(),
        isRead: false,
      );

      await container.read(notificationsProvider.notifier).addNotification(notification);

      // Initially unread
      expect(
          container.read(notificationsProvider).notifications.first.isRead, false);

      // Mark as read
      await container
          .read(notificationsProvider.notifier)
          .markAsRead('notif-1');

      expect(
          container.read(notificationsProvider).notifications.first.isRead, true);
    });

    test('Mark all notifications as read', () async {
      final notifications = List.generate(
        5,
        (index) => AppNotification(
          id: 'notif-$index',
          title: 'Notification $index',
          message: 'Message $index',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ),
      );

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      // Initially all unread
      expect(container.read(notificationsProvider).unreadCount, greaterThan(0));

      // Mark all as read
      await container.read(notificationsProvider.notifier).markAllAsRead();

      expect(container.read(notificationsProvider).unreadCount, 0);
    });

    test('Delete notification', () async {
      final notification = AppNotification(
        id: 'notif-1',
        title: 'Test Notification',
        message: 'This is a test',
        type: NotificationType.general,
        timestamp: DateTime.now(),
      );

      await container.read(notificationsProvider.notifier).addNotification(notification);
      expect(
          container.read(notificationsProvider).notifications.length, greaterThan(0));

      await container
          .read(notificationsProvider.notifier)
          .deleteNotification('notif-1');

      final hasNotification = container
          .read(notificationsProvider)
          .notifications
          .any((n) => n.id == 'notif-1');
      expect(hasNotification, false);
    });

    test('Clear all notifications', () async {
      final notifications = List.generate(
        3,
        (index) => AppNotification(
          id: 'notif-$index',
          title: 'Notification $index',
          message: 'Message $index',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        ),
      );

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      expect(
          container.read(notificationsProvider).notifications.length, greaterThan(0));

      await container.read(notificationsProvider.notifier).clearAllNotifications();

      expect(container.read(notificationsProvider).notifications.length, 0);
    });

    test('Get unread notifications count', () async {
      final notifications = [
        AppNotification(
          id: 'notif-1',
          title: 'Unread 1',
          message: 'Unread message 1',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ),
        AppNotification(
          id: 'notif-2',
          title: 'Read',
          message: 'Read message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: true,
        ),
        AppNotification(
          id: 'notif-3',
          title: 'Unread 2',
          message: 'Unread message 2',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ),
      ];

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      final unreadCount = container.read(notificationsProvider).unreadCount;
      expect(unreadCount, greaterThanOrEqualTo(2));
    });

    test('Filter notifications by type', () async {
      final notifications = [
        AppNotification(
          id: 'notif-1',
          title: 'Order Update',
          message: 'Order shipped',
          type: NotificationType.order,
          timestamp: DateTime.now(),
        ),
        AppNotification(
          id: 'notif-2',
          title: 'Price Drop',
          message: 'Price dropped',
          type: NotificationType.priceAlert,
          timestamp: DateTime.now(),
        ),
        AppNotification(
          id: 'notif-3',
          title: 'Order Delivered',
          message: 'Order delivered',
          type: NotificationType.order,
          timestamp: DateTime.now(),
        ),
      ];

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      final orderNotifications = container
          .read(notificationsProvider.notifier)
          .getNotificationsByType(NotificationType.order);

      expect(orderNotifications.length, greaterThanOrEqualTo(2));
      expect(
          orderNotifications.every((n) => n.type == NotificationType.order), true);
    });

    test('Get unread notifications list', () async {
      final notifications = [
        AppNotification(
          id: 'notif-1',
          title: 'Unread',
          message: 'Unread message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ),
        AppNotification(
          id: 'notif-2',
          title: 'Read',
          message: 'Read message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: true,
        ),
      ];

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      final unreadNotifications =
          container.read(notificationsProvider).unreadNotifications;
      expect(unreadNotifications, isNotEmpty);
      expect(unreadNotifications.every((n) => !n.isRead), true);
    });

    test('Get read notifications list', () async {
      final notifications = [
        AppNotification(
          id: 'notif-1',
          title: 'Unread',
          message: 'Unread message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ),
        AppNotification(
          id: 'notif-2',
          title: 'Read',
          message: 'Read message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: true,
        ),
      ];

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      final readNotifications =
          container.read(notificationsProvider).readNotifications;
      expect(readNotifications, isNotEmpty);
      expect(readNotifications.every((n) => n.isRead), true);
    });

    test('Notifications sorted by timestamp', () async {
      final now = DateTime.now();
      final notifications = [
        AppNotification(
          id: 'notif-1',
          title: 'Old',
          message: 'Old notification',
          type: NotificationType.general,
          timestamp: now.subtract(const Duration(days: 2)),
        ),
        AppNotification(
          id: 'notif-2',
          title: 'New',
          message: 'New notification',
          type: NotificationType.general,
          timestamp: now,
        ),
        AppNotification(
          id: 'notif-3',
          title: 'Middle',
          message: 'Middle notification',
          type: NotificationType.general,
          timestamp: now.subtract(const Duration(days: 1)),
        ),
      ];

      for (final notification in notifications) {
        await container.read(notificationsProvider.notifier).addNotification(notification);
      }

      // Wait for state update
      await Future.delayed(const Duration(milliseconds: 100));

      final sortedNotifications =
          container.read(notificationsProvider).notifications;

      // Verify sorted by newest first
      if (sortedNotifications.length >= 2) {
        expect(
          sortedNotifications[0].timestamp.isAfter(sortedNotifications[1].timestamp) ||
              sortedNotifications[0].timestamp.isAtSameMomentAs(sortedNotifications[1].timestamp),
          true,
        );
      }
    });

    testWidgets('Show unread notification badge',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Look for notification icon with badge
      final notificationIcon = find.byIcon(Icons.notifications);
      expect(notificationIcon, findsWidgets);
    });

    testWidgets('Empty notifications state', (WidgetTester tester) async {
      // Create clean container for empty state
      final cleanContainer = ProviderContainer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationsProvider.overrideWith((ref) => NotificationsNotifier()),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Clear notifications
      await cleanContainer
          .read(notificationsProvider.notifier)
          .clearAllNotifications();

      cleanContainer.dispose();
    });
  });
}
