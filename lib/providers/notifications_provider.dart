import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

// Notifications State
class NotificationsState {
  final List<AppNotification> notifications;
  final bool isLoading;
  final String? error;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  int get unreadCount {
    return notifications.where((notification) => !notification.isRead).length;
  }

  List<AppNotification> get unreadNotifications {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  List<AppNotification> get readNotifications {
    return notifications.where((notification) => notification.isRead).toList();
  }

  NotificationsState copyWith({
    List<AppNotification>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifications Notifier
class NotificationsNotifier extends StateNotifier<NotificationsState> {
  static const String _notificationsKey = 'user_notifications';

  NotificationsNotifier() : super(const NotificationsState()) {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsData = prefs.getString(_notificationsKey);
      if (notificationsData != null) {
        final List<dynamic> decodedData = json.decode(notificationsData);
        final notifications =
            decodedData.map((notification) => AppNotification.fromJson(notification)).toList();
        // Sort by timestamp, newest first
        notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        state = NotificationsState(notifications: notifications, isLoading: false);
      } else {
        // Load mock notifications for demo
        _loadMockNotifications();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _loadMockNotifications() {
    final now = DateTime.now();
    final mockNotifications = [
      AppNotification(
        id: '1',
        title: 'Order Confirmed',
        message: 'Your order #12345 has been confirmed and is being processed',
        type: NotificationType.order,
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      AppNotification(
        id: '2',
        title: 'Price Drop Alert',
        message: 'Wireless Headphones price dropped by 20%!',
        type: NotificationType.priceAlert,
        timestamp: now.subtract(const Duration(days: 1)),
      ),
      AppNotification(
        id: '3',
        title: 'Back in Stock',
        message: 'Smart Watch Pro is back in stock. Order now!',
        type: NotificationType.backInStock,
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
    ];
    state = NotificationsState(notifications: mockNotifications, isLoading: false);
    _saveNotifications();
  }

  Future<void> _saveNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsData =
          json.encode(state.notifications.map((notification) => notification.toJson()).toList());
      await prefs.setString(_notificationsKey, notificationsData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addNotification(AppNotification notification) async {
    final notifications = [notification, ...state.notifications];
    state = state.copyWith(notifications: notifications);
    await _saveNotifications();
  }

  Future<void> markAsRead(String notificationId) async {
    final notifications = state.notifications.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();

    state = state.copyWith(notifications: notifications);
    await _saveNotifications();
  }

  Future<void> markAllAsRead() async {
    final notifications = state.notifications
        .map((notification) => notification.copyWith(isRead: true))
        .toList();

    state = state.copyWith(notifications: notifications);
    await _saveNotifications();
  }

  Future<void> deleteNotification(String notificationId) async {
    final notifications =
        state.notifications.where((notification) => notification.id != notificationId).toList();
    state = state.copyWith(notifications: notifications);
    await _saveNotifications();
  }

  Future<void> clearAllNotifications() async {
    state = const NotificationsState(notifications: []);
    await _saveNotifications();
  }

  List<AppNotification> getNotificationsByType(NotificationType type) {
    return state.notifications.where((notification) => notification.type == type).toList();
  }

  Future<void> sendOrderNotification(String orderId, String status) async {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Order Update',
      message: 'Your order #$orderId is now $status',
      type: NotificationType.order,
      timestamp: DateTime.now(),
      data: {'orderId': orderId, 'status': status},
    );
    await addNotification(notification);
  }

  Future<void> sendPriceAlertNotification(String productName, double discount) async {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Price Drop Alert',
      message: '$productName price dropped by ${discount.toStringAsFixed(0)}%!',
      type: NotificationType.priceAlert,
      timestamp: DateTime.now(),
    );
    await addNotification(notification);
  }

  Future<void> sendBackInStockNotification(String productName) async {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Back in Stock',
      message: '$productName is back in stock. Order now!',
      type: NotificationType.backInStock,
      timestamp: DateTime.now(),
    );
    await addNotification(notification);
  }

  Future<void> sendPromotionNotification(String title, String message) async {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      type: NotificationType.promotion,
      timestamp: DateTime.now(),
    );
    await addNotification(notification);
  }
}

// Provider
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});
