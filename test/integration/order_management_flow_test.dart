import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/providers/orders_provider.dart';
import 'package:shopping_app/providers/cart_provider_riverpod.dart';

void main() {
  group('Order Management Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Place order flow: Cart → Checkout → Order confirmation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Look for checkout button
        final checkoutButton =
            find.textContaining('Checkout', findRichText: true);
        if (checkoutButton.evaluate().isNotEmpty) {
          await tester.tap(checkoutButton.first);
          await tester.pumpAndSettle();

          // Verify checkout page
          expect(find.byType(ElevatedButton), findsWidgets);
        }
      }
    });

    test('Order creation with cart items', () async {
      final product = Product(
        id: 'prod-1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        imageUrl: 'test.jpg',
        images: ['test.jpg'],
        category: 'Electronics',
        brand: 'TestBrand',
      );

      // Add to cart
      container.read(cartProvider.notifier).addItem(product);

      // Create order from cart
      final cartItems = container.read(cartProvider).items;
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: cartItems,
        subtotal: container.read(cartProvider).totalAmount,
        totalAmount: container.read(cartProvider).totalAmount,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          addressLine2: '',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime.now(),
          ),
        ],
      );

      await container.read(ordersProvider.notifier).addOrder(order);

      // Verify order was created
      final ordersState = container.read(ordersProvider);
      expect(ordersState.orders.length, 1);
      expect(ordersState.orders.first.id, 'order-1');
      expect(ordersState.orders.first.totalAmount, 99.99);
    });

    testWidgets('View orders list', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Look for orders option
        final ordersButton = find.textContaining('Orders', findRichText: true);
        if (ordersButton.evaluate().isNotEmpty) {
          await tester.tap(ordersButton.first);
          await tester.pumpAndSettle();

          // Verify orders page is displayed
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    test('Order status updates', () async {
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: [],
        subtotal: 100.0,
        totalAmount: 100.0,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          addressLine2: '',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime.now(),
          ),
        ],
      );

      await container.read(ordersProvider.notifier).addOrder(order);

      // Update status to confirmed
      await container.read(ordersProvider.notifier).updateOrderStatus(
            'order-1',
            OrderStatus.confirmed,
          );

      final updatedOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(updatedOrder?.status, OrderStatus.confirmed);
      expect(updatedOrder?.statusUpdates.length, 2);

      // Update to shipped
      await container.read(ordersProvider.notifier).updateOrderStatus(
            'order-1',
            OrderStatus.shipped,
          );

      final shippedOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(shippedOrder?.status, OrderStatus.shipped);
      expect(shippedOrder?.statusUpdates.length, 3);

      // Update to delivered
      await container.read(ordersProvider.notifier).updateOrderStatus(
            'order-1',
            OrderStatus.delivered,
          );

      final deliveredOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(deliveredOrder?.status, OrderStatus.delivered);
      expect(deliveredOrder?.deliveryDate, isNotNull);
    });

    testWidgets('View order details', (WidgetTester tester) async {
      // Create and add an order
      final testContainer = ProviderContainer();
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: [],
        subtotal: 0.0,
        totalAmount: 150.0,
        orderDate: DateTime.now(),
        status: OrderStatus.confirmed,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime.now(),
          ),
        ],
      );

      await testContainer.read(ordersProvider.notifier).addOrder(order);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersProvider.overrideWith((ref) => OrdersNotifier()),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      testContainer.dispose();
    });

    test('Cancel order', () async {
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: [],
        subtotal: 0.0,
        totalAmount: 200.0,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime.now(),
          ),
        ],
      );

      await container.read(ordersProvider.notifier).addOrder(order);

      // Cancel the order
      await container.read(ordersProvider.notifier).cancelOrder('order-1');

      final cancelledOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(cancelledOrder?.status, OrderStatus.cancelled);
    });

    test('Return order', () async {
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: [],
        subtotal: 0.0,
        totalAmount: 250.0,
        orderDate: DateTime.now(),
        status: OrderStatus.delivered,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        deliveryDate: DateTime.now(),
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime.now(),
          ),
        ],
      );

      await container.read(ordersProvider.notifier).addOrder(order);

      // Return the order
      await container.read(ordersProvider.notifier).returnOrder('order-1');

      final returnedOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(returnedOrder?.status, OrderStatus.returned);
    });

    test('Filter orders by status', () async {
      // Create multiple orders with different statuses
      final orders = [
        OrderEnhanced(
          id: 'order-1',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 100.0,
          orderDate: DateTime.now(),
          status: OrderStatus.pending,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
        OrderEnhanced(
          id: 'order-2',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 150.0,
          orderDate: DateTime.now(),
          status: OrderStatus.delivered,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
        OrderEnhanced(
          id: 'order-3',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 200.0,
          orderDate: DateTime.now(),
          status: OrderStatus.shipped,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
      ];

      for (final order in orders) {
        await container.read(ordersProvider.notifier).addOrder(order);
      }

      // Get active orders
      final activeOrders = container.read(ordersProvider).activeOrders;
      expect(activeOrders.length, 2); // pending and shipped

      // Get completed orders
      final completedOrders = container.read(ordersProvider).completedOrders;
      expect(completedOrders.length, 1); // delivered

      // Get orders by specific status
      final pendingOrders = container
          .read(ordersProvider.notifier)
          .getOrdersByStatus(OrderStatus.pending);
      expect(pendingOrders.length, 1);
    });

    test('Order tracking number update', () async {
      final order = OrderEnhanced(
        id: 'order-1',
        userId: 'user-1',
        items: [],
        subtotal: 0.0,
        totalAmount: 100.0,
        orderDate: DateTime.now(),
        status: OrderStatus.shipped,
        paymentStatus: PaymentStatus.pending,
        shippingAddress: Address(
          id: 'addr-1',
          userId: 'user-1',
          fullName: 'Test User',
          phoneNumber: '1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          state: 'Test State',
          zipCode: '12345',
          country: 'Test Country',
          isDefault: false,
          type: AddressType.home,
        ),
        paymentMethod: PaymentMethod.creditCard,
        statusUpdates: [],
      );

      await container.read(ordersProvider.notifier).addOrder(order);

      // Update tracking number
      await container
          .read(ordersProvider.notifier)
          .updateTrackingNumber('order-1', 'TRACK123456');

      final updatedOrder =
          container.read(ordersProvider.notifier).getOrderById('order-1');
      expect(updatedOrder?.trackingNumber, 'TRACK123456');
    });

    test('Calculate total spent from delivered orders', () async {
      final orders = [
        OrderEnhanced(
          id: 'order-1',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 100.0,
          orderDate: DateTime.now(),
          status: OrderStatus.delivered,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
        OrderEnhanced(
          id: 'order-2',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 150.0,
          orderDate: DateTime.now(),
          status: OrderStatus.delivered,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
        OrderEnhanced(
          id: 'order-3',
          userId: 'user-1',
          items: [],
          subtotal: 0.0,
          totalAmount: 200.0,
          orderDate: DateTime.now(),
          status: OrderStatus.cancelled,
          paymentStatus: PaymentStatus.pending,
          shippingAddress: Address(
            id: 'addr-1',
            userId: 'user-1',
            fullName: 'Test User',
            phoneNumber: '1234567890',
            addressLine1: '123 Test St',
            city: 'Test City',
            state: 'Test State',
            zipCode: '12345',
            country: 'Test Country',
            isDefault: false,
            type: AddressType.home,
          ),
          paymentMethod: PaymentMethod.creditCard,
          statusUpdates: [],
        ),
      ];

      for (final order in orders) {
        await container.read(ordersProvider.notifier).addOrder(order);
      }

      final totalSpent = container.read(ordersProvider).totalSpent;
      expect(totalSpent, 250.0); // Only delivered orders
    });
  });
}
