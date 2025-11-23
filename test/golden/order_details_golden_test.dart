import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('Order Details Golden Tests', () {
    testGoldens('Order Status - Pending', (tester) async {
      await loadAppFonts();

      final statusWidget = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.hourglass_empty, color: Colors.orange[700]),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Pending',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Your order is being processed',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await tester.pumpWidgetBuilder(
        statusWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'order_status_pending');
    });

    testGoldens('Order Status - Confirmed', (tester) async {
      await loadAppFonts();

      final statusWidget = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle, color: Colors.blue[700]),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Confirmed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Your order has been confirmed',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await tester.pumpWidgetBuilder(
        statusWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'order_status_confirmed');
    });

    testGoldens('Order Status - Shipped', (tester) async {
      await loadAppFonts();

      final statusWidget = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.local_shipping, color: Colors.purple[700]),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Shipped',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Tracking: TRACK123456',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await tester.pumpWidgetBuilder(
        statusWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'order_status_shipped');
    });

    testGoldens('Order Status - Delivered', (tester) async {
      await loadAppFonts();

      final statusWidget = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.done_all, color: Colors.green[700]),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Delivered',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Delivered on Jan 15, 2024',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await tester.pumpWidgetBuilder(
        statusWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'order_status_delivered');
    });

    testGoldens('Order Status - Cancelled', (tester) async {
      await loadAppFonts();

      final statusWidget = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cancel, color: Colors.red[700]),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Cancelled',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Order has been cancelled',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      await tester.pumpWidgetBuilder(
        statusWidget,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 80),
      );

      await screenMatchesGolden(tester, 'order_status_cancelled');
    });

    testGoldens('Order Timeline', (tester) async {
      await loadAppFonts();

      final timeline = Column(
        children: [
          const ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Order Placed'),
            subtitle: Text('Jan 10, 2024 - 10:30 AM'),
            trailing: Icon(Icons.more_vert),
          ),
          const Divider(indent: 72),
          const ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Order Confirmed'),
            subtitle: Text('Jan 10, 2024 - 11:00 AM'),
          ),
          const Divider(indent: 72),
          const ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Order Shipped'),
            subtitle: Text('Jan 11, 2024 - 9:00 AM'),
          ),
          const Divider(indent: 72),
          ListTile(
            leading: Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
            title: const Text('Out for Delivery'),
            subtitle: Text('Pending', style: TextStyle(color: Colors.grey[400])),
          ),
          const Divider(indent: 72),
          ListTile(
            leading: Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
            title: const Text('Delivered'),
            subtitle: Text('Pending', style: TextStyle(color: Colors.grey[400])),
          ),
        ],
      );

      await tester.pumpWidgetBuilder(
        timeline,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 400),
      );

      await screenMatchesGolden(tester, 'order_timeline');
    });

    testGoldens('Order Summary Card', (tester) async {
      await loadAppFonts();

      final summaryCard = Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order #12345',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Placed on Jan 10, 2024',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Divider(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal'),
                  Text('\$249.97'),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping'),
                  Text('\$5.99'),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax'),
                  Text('\$20.00'),
                ],
              ),
              const Divider(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$275.96',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidgetBuilder(
        summaryCard,
        wrapper: materialAppWrapper(theme: ThemeData.light()),
        surfaceSize: const Size(375, 280),
      );

      await screenMatchesGolden(tester, 'order_summary_card');
    });

    testGoldens('Order All Statuses', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 4,
      )
        ..addScenario(
          'Pending',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Pending',
              style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold),
            ),
          ),
        )
        ..addScenario(
          'Confirmed',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Confirmed',
              style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
            ),
          ),
        )
        ..addScenario(
          'Shipped',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Shipped',
              style: TextStyle(color: Colors.purple[900], fontWeight: FontWeight.bold),
            ),
          ),
        )
        ..addScenario(
          'Delivered',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Delivered',
              style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold),
            ),
          ),
        )
        ..addScenario(
          'Cancelled',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Cancelled',
              style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
            ),
          ),
        )
        ..addScenario(
          'Returned',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Returned',
              style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
            ),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'order_status_badges');
    });
  });
}
