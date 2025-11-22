import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/subscriptions_provider.dart';
import 'package:shopping_app/models/subscription_model.dart';
import 'package:shopping_app/models/product_model.dart';

void main() {
  group('SubscriptionsProvider Tests', () {
    late ProviderContainer container;
    late Product testProduct;
    late Subscription testSubscription;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testProduct = Product(
        id: 'prod1',
        name: 'Monthly Coffee',
        description: 'Premium coffee subscription',
        price: 29.99,
        imageUrl: 'coffee.jpg',
        images: ['coffee.jpg'],
        category: 'food',
        brand: 'CoffeeCo',
      );

      testSubscription = Subscription(
        id: 'sub1',
        userId: 'user1',
        product: testProduct,
        quantity: 2,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        nextDeliveryDate: DateTime.now().add(const Duration(days: 30)),
      );

      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(subscriptionsProvider);

        expect(state.subscriptions, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Add Subscription', () {
      test('should add subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.length, 1);
        expect(state.subscriptions.first.id, testSubscription.id);
      });

      test('should add multiple subscriptions', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final sub2 = testSubscription.copyWith(id: 'sub2');

        await notifier.addSubscription(testSubscription);
        await notifier.addSubscription(sub2);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.length, 2);
      });
    });

    group('Update Subscription', () {
      test('should update subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        final updated = testSubscription.copyWith(quantity: 5);
        await notifier.updateSubscription(updated);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.quantity, 5);
      });
    });

    group('Pause Subscription', () {
      test('should pause active subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.pauseSubscription(testSubscription.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.status, SubscriptionStatus.paused);
      });
    });

    group('Resume Subscription', () {
      test('should resume paused subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final pausedSub = testSubscription.copyWith(status: SubscriptionStatus.paused);
        await notifier.addSubscription(pausedSub);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.resumeSubscription(pausedSub.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.status, SubscriptionStatus.active);
      });
    });

    group('Cancel Subscription', () {
      test('should cancel subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.cancelSubscription(testSubscription.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.status, SubscriptionStatus.cancelled);
        expect(state.subscriptions.first.endDate, isNotNull);
      });
    });

    group('Update Frequency', () {
      test('should update subscription frequency', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateFrequency(
          testSubscription.id,
          SubscriptionFrequency.weekly,
        );
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.frequency, SubscriptionFrequency.weekly);
      });
    });

    group('Update Quantity', () {
      test('should update subscription quantity', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.updateQuantity(testSubscription.id, 10);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.quantity, 10);
      });
    });

    group('Get Subscription By ID', () {
      test('should get subscription by ID', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        final subscription = notifier.getSubscriptionById(testSubscription.id);

        expect(subscription, isNotNull);
        expect(subscription?.id, testSubscription.id);
      });

      test('should return null for non-existent ID', () {
        final notifier = container.read(subscriptionsProvider.notifier);

        final subscription = notifier.getSubscriptionById('non_existent');

        expect(subscription, isNull);
      });
    });

    group('Has Active Subscription', () {
      test('should check for active subscription', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        expect(notifier.hasActiveSubscription(testProduct.id), true);
        expect(notifier.hasActiveSubscription('other_product'), false);
      });
    });

    group('Get Subscriptions By Product', () {
      test('should get subscriptions for product', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        final subscriptions = notifier.getSubscriptionsByProduct(testProduct.id);

        expect(subscriptions.length, 1);
        expect(subscriptions.first.product.id, testProduct.id);
      });
    });

    group('State Getters', () {
      test('should get active subscriptions', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final activeSub = testSubscription.copyWith(
          id: 'active',
          status: SubscriptionStatus.active,
        );
        final pausedSub = testSubscription.copyWith(
          id: 'paused',
          status: SubscriptionStatus.paused,
        );

        await notifier.addSubscription(activeSub);
        await notifier.addSubscription(pausedSub);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(subscriptionsProvider);
        expect(state.activeSubscriptions.length, 1);
        expect(state.activeSubscriptions.first.status, SubscriptionStatus.active);
      });

      test('should get paused subscriptions', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final pausedSub = testSubscription.copyWith(status: SubscriptionStatus.paused);

        await notifier.addSubscription(testSubscription);
        await notifier.addSubscription(pausedSub);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(subscriptionsProvider);
        expect(state.pausedSubscriptions, isNotEmpty);
      });

      test('should count active subscriptions', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.activeCount, 1);
      });

      test('should calculate total monthly amount', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final monthlySub = testSubscription.copyWith(
          frequency: SubscriptionFrequency.monthly,
          quantity: 2,
        );

        await notifier.addSubscription(monthlySub);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.totalMonthlyAmount, closeTo(59.98, 0.01));
      });
    });

    group('Subscription Model', () {
      test('should calculate discounted price', () {
        final sub = testSubscription.copyWith(discountPercentage: 10.0);

        expect(sub.discountedPrice, closeTo(26.99, 0.01));
      });

      test('should calculate total price', () {
        final sub = testSubscription.copyWith(
          quantity: 3,
          discountPercentage: 0.0,
        );

        expect(sub.totalPrice, closeTo(89.97, 0.01));
      });

      test('should generate frequency string', () {
        expect(testSubscription.frequencyString, 'Monthly');

        final weekly = testSubscription.copyWith(frequency: SubscriptionFrequency.weekly);
        expect(weekly.frequencyString, 'Weekly');
      });

      test('should generate status string', () {
        expect(testSubscription.statusString, 'Active');

        final paused = testSubscription.copyWith(status: SubscriptionStatus.paused);
        expect(paused.statusString, 'Paused');
      });
    });

    group('Persistence', () {
      test('should save subscriptions to SharedPreferences', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('user_subscriptions'), isNotNull);
      });

      test('should load subscriptions from SharedPreferences', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        await notifier.addSubscription(testSubscription);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions, isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle subscription with discount', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final discountedSub = testSubscription.copyWith(discountPercentage: 20.0);

        await notifier.addSubscription(discountedSub);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.discountedPrice, lessThan(testProduct.price));
      });

      test('should handle subscription with size and color', () async {
        final notifier = container.read(subscriptionsProvider.notifier);

        final customSub = testSubscription.copyWith(
          selectedSize: 'Large',
          selectedColor: 'Blue',
        );

        await notifier.addSubscription(customSub);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(subscriptionsProvider);
        expect(state.subscriptions.first.selectedSize, 'Large');
        expect(state.subscriptions.first.selectedColor, 'Blue');
      });
    });
  });
}
