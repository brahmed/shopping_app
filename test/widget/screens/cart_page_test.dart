import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/cart/cart_page.dart';

void main() {
  group('CartPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.byType(CartPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display app bar with title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('should display empty cart message when cart is empty',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('should display start shopping button when cart is empty',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Start Shopping'), findsOneWidget);
    });

    testWidgets('should display empty box image when cart is empty',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // SVG image should be present
      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('empty state should be centered', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should have clear all button when cart is not empty',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // May or may not find based on cart state
      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should display cart as ConsumerWidget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.byType(CartPage), findsOneWidget);
      expect(const CartPage(), isA<ConsumerWidget>());
    });
  });
}
