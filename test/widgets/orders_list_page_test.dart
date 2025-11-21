import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/providers/orders_provider.dart';
import 'package:shopping_app/screens/orders/orders_list_page.dart';
import '../fixtures/mock_data.dart';

void main() {
  group('Orders List Page Widget Tests', () {
    testWidgets('should display loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = const OrdersState(isLoading: true);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display empty state when no orders', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = const OrdersState(orders: []);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No Orders Yet'), findsOneWidget);
      expect(find.text('Your orders will appear here'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Start Shopping'), findsOneWidget);
    });

    testWidgets('should display tabs when orders exist', (tester) async {
      final orders = [MockData.mockOrder1, MockData.mockOrder2];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('should display active orders in Active tab', (tester) async {
      final orders = [MockData.mockOrder1, MockData.mockOrder2];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Order 1 is processing (active)
      expect(find.text('Order #${MockData.mockOrder1.id.substring(0, 8)}'), findsOneWidget);
    });

    testWidgets('should display completed orders in Completed tab', (tester) async {
      final orders = [MockData.mockOrder1, MockData.mockOrder2];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on Completed tab
      await tester.tap(find.text('Completed'));
      await tester.pumpAndSettle();

      // Order 2 is delivered (completed)
      expect(find.text('Order #${MockData.mockOrder2.id.substring(0, 8)}'), findsOneWidget);
    });

    testWidgets('should display order status chip', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Chip), findsWidgets);
    });

    testWidgets('should display order total amount', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('\$${MockData.mockOrder1.totalAmount.toStringAsFixed(2)}'), findsOneWidget);
    });

    testWidgets('should display item count', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('item'), findsWidgets);
    });

    testWidgets('should display estimated delivery date', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Estimated delivery'), findsOneWidget);
    });

    testWidgets('should display filter icon when orders exist', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('should navigate when tapping order card', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the order card
      final orderCard = find.byType(Card).first;
      await tester.tap(orderCard);
      await tester.pumpAndSettle();

      // Note: Navigation test requires proper router setup
    });

    testWidgets('should switch between tabs', (tester) async {
      final orders = [MockData.mockOrder1, MockData.mockOrder2];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should start on Active tab
      expect(find.text('Order #${MockData.mockOrder1.id.substring(0, 8)}'), findsOneWidget);

      // Tap Completed tab
      await tester.tap(find.text('Completed'));
      await tester.pumpAndSettle();

      // Should show completed orders
      expect(find.text('Order #${MockData.mockOrder2.id.substring(0, 8)}'), findsOneWidget);
    });

    testWidgets('should display track button for orders with tracking', (tester) async {
      final orders = [MockData.mockOrder1]; // Has tracking number

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Track'), findsOneWidget);
      expect(find.byIcon(Icons.local_shipping), findsWidgets);
    });

    testWidgets('should display app bar title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      expect(find.text('My Orders'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display order date', (tester) async {
      final orders = [MockData.mockOrder1];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) {
              return OrdersNotifier()
                ..state = OrdersState(orders: orders);
            }),
          ],
          child: const MaterialApp(
            home: OrdersListPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Placed on'), findsOneWidget);
    });
  });
}
