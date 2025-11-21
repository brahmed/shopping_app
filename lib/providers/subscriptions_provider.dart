import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subscription_model.dart';

// Subscriptions State
class SubscriptionsState {
  final List<Subscription> subscriptions;
  final bool isLoading;
  final String? error;

  const SubscriptionsState({
    this.subscriptions = const [],
    this.isLoading = false,
    this.error,
  });

  List<Subscription> get activeSubscriptions {
    return subscriptions.where((s) => s.status == SubscriptionStatus.active).toList();
  }

  List<Subscription> get pausedSubscriptions {
    return subscriptions.where((s) => s.status == SubscriptionStatus.paused).toList();
  }

  int get activeCount => activeSubscriptions.length;

  double get totalMonthlyAmount {
    return activeSubscriptions
        .where((s) => s.frequency == SubscriptionFrequency.monthly)
        .fold(0.0, (sum, sub) => sum + sub.totalPrice);
  }

  SubscriptionsState copyWith({
    List<Subscription>? subscriptions,
    bool? isLoading,
    String? error,
  }) {
    return SubscriptionsState(
      subscriptions: subscriptions ?? this.subscriptions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Subscriptions Notifier
class SubscriptionsNotifier extends StateNotifier<SubscriptionsState> {
  static const String _subscriptionsKey = 'user_subscriptions';

  SubscriptionsNotifier() : super(const SubscriptionsState()) {
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final subscriptionsData = prefs.getString(_subscriptionsKey);
      if (subscriptionsData != null) {
        final List<dynamic> decodedData = json.decode(subscriptionsData);
        final subscriptions =
            decodedData.map((subscription) => Subscription.fromJson(subscription)).toList();
        state = SubscriptionsState(subscriptions: subscriptions, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _saveSubscriptions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final subscriptionsData = json
          .encode(state.subscriptions.map((subscription) => subscription.toJson()).toList());
      await prefs.setString(_subscriptionsKey, subscriptionsData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addSubscription(Subscription subscription) async {
    final subscriptions = [...state.subscriptions, subscription];
    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> updateSubscription(Subscription subscription) async {
    final subscriptions = state.subscriptions.map((s) {
      if (s.id == subscription.id) {
        return subscription;
      }
      return s;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> pauseSubscription(String subscriptionId) async {
    final subscriptions = state.subscriptions.map((subscription) {
      if (subscription.id == subscriptionId) {
        return subscription.copyWith(status: SubscriptionStatus.paused);
      }
      return subscription;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> resumeSubscription(String subscriptionId) async {
    final subscriptions = state.subscriptions.map((subscription) {
      if (subscription.id == subscriptionId) {
        return subscription.copyWith(status: SubscriptionStatus.active);
      }
      return subscription;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    final subscriptions = state.subscriptions.map((subscription) {
      if (subscription.id == subscriptionId) {
        return subscription.copyWith(
          status: SubscriptionStatus.cancelled,
          endDate: DateTime.now(),
        );
      }
      return subscription;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> updateFrequency(
      String subscriptionId, SubscriptionFrequency newFrequency) async {
    final subscriptions = state.subscriptions.map((subscription) {
      if (subscription.id == subscriptionId) {
        return subscription.copyWith(frequency: newFrequency);
      }
      return subscription;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Future<void> updateQuantity(String subscriptionId, int newQuantity) async {
    final subscriptions = state.subscriptions.map((subscription) {
      if (subscription.id == subscriptionId) {
        return subscription.copyWith(quantity: newQuantity);
      }
      return subscription;
    }).toList();

    state = state.copyWith(subscriptions: subscriptions);
    await _saveSubscriptions();
  }

  Subscription? getSubscriptionById(String subscriptionId) {
    try {
      return state.subscriptions.firstWhere((s) => s.id == subscriptionId);
    } catch (e) {
      return null;
    }
  }

  bool hasActiveSubscription(String productId) {
    return state.activeSubscriptions.any((s) => s.product.id == productId);
  }

  List<Subscription> getSubscriptionsByProduct(String productId) {
    return state.subscriptions.where((s) => s.product.id == productId).toList();
  }
}

// Provider
final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, SubscriptionsState>((ref) {
  return SubscriptionsNotifier();
});
