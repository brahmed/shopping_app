import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shopping_app/screens/cart/cart_page.dart';

void main() {
  group('Cart Page Golden Tests', () {
    testGoldens('Cart Page - Empty State', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const ProviderScope(
          child: CartPage(),
        ),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'cart_page_empty_light');
    });

    testGoldens('Cart Page - Empty State Dark', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const ProviderScope(
          child: CartPage(),
        ),
        wrapper: materialAppWrapper(theme: ThemeData.dark()),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'cart_page_empty_dark');
    });

    testGoldens('Cart Item Widget', (tester) async {
      await loadAppFonts();

      final cartItem = Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Wireless Headphones',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Black, Medium',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '\$99.99',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(
        cartItem,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 120),
      );

      await screenMatchesGolden(tester, 'cart_item_widget');
    });

    testGoldens('Cart Summary Widget', (tester) async {
      await loadAppFonts();

      final cartSummary = Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal (3 items)', style: TextStyle(color: Colors.grey[600])),
                  const Text('\$249.97', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping', style: TextStyle(color: Colors.grey[600])),
                  const Text('\$5.99', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax', style: TextStyle(color: Colors.grey[600])),
                  const Text('\$20.00', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              const Divider(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$275.96',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Proceed to Checkout'),
                ),
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(
        cartSummary,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 300),
      );

      await screenMatchesGolden(tester, 'cart_summary_widget');
    });

    testGoldens('Cart With Coupon Applied', (tester) async {
      await loadAppFonts();

      final couponSection = Card(
        margin: const EdgeInsets.all(16),
        color: Colors.green[50],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.local_offer, color: Colors.green[700]),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coupon Applied',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'SAVE20 - 20% off',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(
        couponSection,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'cart_coupon_applied');
    });

    testGoldens('Cart Loading State', (tester) async {
      await loadAppFonts();

      final loadingWidget = Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading cart...'),
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(
        loadingWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'cart_loading_state');
    });

    testGoldens('Cart - Light vs Dark Theme', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 0.55,
      )
        ..addScenario(
          'Light Theme',
          const ProviderScope(
            child: CartPage(),
          ),
        )
        ..addScenario(
          'Dark Theme',
          Theme(
            data: ThemeData.dark(),
            child: const ProviderScope(
              child: CartPage(),
            ),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'cart_page_themes');
    });
  });
}
