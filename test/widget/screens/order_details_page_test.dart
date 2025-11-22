import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/screens/orders/order_details_page.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('OrderDetailsPage Tests', () {
    final testOrder = Order(
      id: '1',
      userId: 'user1',
      items: [],
      totalAmount: 99.99,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: OrderDetailsPage(order: testOrder),
          ),
        ),
      );

      expect(find.byType(OrderDetailsPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: OrderDetailsPage(order: testOrder),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
    });

    testWidgets('should display order details title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: OrderDetailsPage(order: testOrder),
          ),
        ),
      );

      expect(find.text('Order Details'), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: OrderDetailsPage(order: testOrder),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerWidget', (tester) async {
      final page = OrderDetailsPage(order: testOrder);
      expect(page, isA<ConsumerWidget>());
    });
  });
}
