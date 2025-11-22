import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/notifications_provider.dart';
import 'package:shopping_app/models/notification_model.dart';

void main() {
  group('NotificationsProvider Tests', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () async {
        await Future.delayed(const Duration(milliseconds: 100));
        final state = container.read(notificationsProvider);

        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Add Notification', () {
      test('should add notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final notification = AppNotification(
          id: 'notif1',
          title: 'Test Notification',
          message: 'This is a test',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        );

        await notifier.addNotification(notification);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.any((n) => n.id == 'notif1'), true);
      });

      test('should add notification at the beginning', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final notif1 = AppNotification(
          id: 'notif1',
          title: 'First',
          message: 'First notification',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        );

        final notif2 = AppNotification(
          id: 'notif2',
          title: 'Second',
          message: 'Second notification',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        );

        await notifier.addNotification(notif1);
        await Future.delayed(const Duration(milliseconds: 50));
        await notifier.addNotification(notif2);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.first.id, 'notif2');
      });
    });

    group('Mark As Read', () {
      test('should mark notification as read', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final notification = AppNotification(
          id: 'notif1',
          title: 'Test',
          message: 'Test message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        );

        await notifier.addNotification(notification);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.markAsRead('notif1');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        final notif = state.notifications.firstWhere((n) => n.id == 'notif1');
        expect(notif.isRead, true);
      });

      test('should not affect other notifications', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final notif1 = AppNotification(
          id: 'notif1',
          title: 'Test 1',
          message: 'Test message 1',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        );

        final notif2 = AppNotification(
          id: 'notif2',
          title: 'Test 2',
          message: 'Test message 2',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        );

        await notifier.addNotification(notif1);
        await notifier.addNotification(notif2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.markAsRead('notif1');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        final notif2State = state.notifications.firstWhere((n) => n.id == 'notif2');
        expect(notif2State.isRead, false);
      });
    });

    group('Mark All As Read', () {
      test('should mark all notifications as read', () async {
        final notifier = container.read(notificationsProvider.notifier);

        for (int i = 0; i < 5; i++) {
          await notifier.addNotification(AppNotification(
            id: 'notif$i',
            title: 'Test $i',
            message: 'Message $i',
            type: NotificationType.general,
            timestamp: DateTime.now(),
          ));
        }
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.markAllAsRead();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.every((n) => n.isRead), true);
      });
    });

    group('Delete Notification', () {
      test('should delete notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final notification = AppNotification(
          id: 'notif1',
          title: 'Test',
          message: 'Test message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        );

        await notifier.addNotification(notification);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.deleteNotification('notif1');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.any((n) => n.id == 'notif1'), false);
      });
    });

    group('Clear All Notifications', () {
      test('should clear all notifications', () async {
        final notifier = container.read(notificationsProvider.notifier);

        for (int i = 0; i < 5; i++) {
          await notifier.addNotification(AppNotification(
            id: 'notif$i',
            title: 'Test $i',
            message: 'Message $i',
            type: NotificationType.general,
            timestamp: DateTime.now(),
          ));
        }
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.clearAllNotifications();
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications, isEmpty);
      });
    });

    group('Get Notifications By Type', () {
      test('should filter notifications by type', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'order1',
          title: 'Order Update',
          message: 'Order delivered',
          type: NotificationType.order,
          timestamp: DateTime.now(),
        ));

        await notifier.addNotification(AppNotification(
          id: 'promo1',
          title: 'Promotion',
          message: 'Big sale!',
          type: NotificationType.promotion,
          timestamp: DateTime.now(),
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        final orderNotifs = notifier.getNotificationsByType(NotificationType.order);

        expect(orderNotifs.length, greaterThanOrEqualTo(1));
        expect(orderNotifs.every((n) => n.type == NotificationType.order), true);
      });
    });

    group('State Getters', () {
      test('should count unread notifications', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Test 1',
          message: 'Message 1',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ));

        await notifier.addNotification(AppNotification(
          id: 'notif2',
          title: 'Test 2',
          message: 'Message 2',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: true,
        ));

        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(notificationsProvider);
        expect(state.unreadCount, greaterThanOrEqualTo(1));
      });

      test('should get unread notifications', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Unread',
          message: 'Unread message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: false,
        ));

        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.unreadNotifications, isNotEmpty);
        expect(state.unreadNotifications.every((n) => !n.isRead), true);
      });

      test('should get read notifications', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Read',
          message: 'Read message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          isRead: true,
        ));

        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.readNotifications.every((n) => n.isRead), true);
      });
    });

    group('Send Specific Notifications', () {
      test('should send order notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.sendOrderNotification('order123', 'delivered');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(
          state.notifications.any((n) => n.type == NotificationType.order),
          true,
        );
      });

      test('should send price alert notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.sendPriceAlertNotification('Product Name', 20.0);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(
          state.notifications.any((n) => n.type == NotificationType.priceAlert),
          true,
        );
      });

      test('should send back in stock notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.sendBackInStockNotification('Product Name');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(
          state.notifications.any((n) => n.type == NotificationType.backInStock),
          true,
        );
      });

      test('should send promotion notification', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.sendPromotionNotification('Big Sale', 'Save 50%!');
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(
          state.notifications.any((n) => n.type == NotificationType.promotion),
          true,
        );
      });
    });

    group('Persistence', () {
      test('should save notifications to SharedPreferences', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Test',
          message: 'Test message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        ));
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('user_notifications'), isNotNull);
      });

      test('should load notifications from SharedPreferences', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Test',
          message: 'Test message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
        ));
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(notificationsProvider);
        expect(state.notifications, isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle notification with data', () async {
        final notifier = container.read(notificationsProvider.notifier);

        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Test',
          message: 'Test message',
          type: NotificationType.general,
          timestamp: DateTime.now(),
          data: {'key1': 'value1', 'key2': 123},
        ));
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.first.data, isNotNull);
        expect(state.notifications.first.data?['key1'], 'value1');
      });

      test('should handle very long notification message', () async {
        final notifier = container.read(notificationsProvider.notifier);

        final longMessage = 'A' * 10000;
        await notifier.addNotification(AppNotification(
          id: 'notif1',
          title: 'Long Message',
          message: longMessage,
          type: NotificationType.general,
          timestamp: DateTime.now(),
        ));
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(notificationsProvider);
        expect(state.notifications.first.message.length, 10000);
      });
    });
  });
}
