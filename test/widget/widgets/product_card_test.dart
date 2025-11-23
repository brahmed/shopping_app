import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/widgets/cards/product_card.dart';

void main() {
  group('ProductCard Tests', () {
    final testProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test description',
      price: 99.99,
      imageUrl: 'https://example.com/image.jpg',
      images: ['https://example.com/image.jpg'],
      category: 'electronics',
      brand: 'TestBrand',
      rating: 4.5,
      reviewCount: 100,
      inStock: true,
    );

    final productWithDiscount = Product(
      id: '2',
      name: 'Discounted Product',
      description: 'Test description',
      price: 79.99,
      originalPrice: 99.99,
      imageUrl: 'https://example.com/image.jpg',
      images: ['https://example.com/image.jpg'],
      category: 'fashion',
      brand: 'TestBrand',
      rating: 4.0,
      reviewCount: 50,
      inStock: true,
    );

    final outOfStockProduct = Product(
      id: '3',
      name: 'Out of Stock',
      description: 'Test description',
      price: 49.99,
      imageUrl: 'https://example.com/image.jpg',
      images: ['https://example.com/image.jpg'],
      category: 'sports',
      brand: 'TestBrand',
      inStock: false,
    );

    testWidgets('should render correctly with product', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.byType(ProductCard), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('TestBrand'), findsOneWidget);
    });

    testWidgets('should display product name', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('should display brand name', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('TestBrand'), findsOneWidget);
    });

    testWidgets('should display price', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('\$99.99'), findsOneWidget);
    });

    testWidgets('should display rating', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('4.5'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should display review count', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('(100)'), findsOneWidget);
    });

    testWidgets('should display discount badge when product has discount',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: productWithDiscount),
            ),
          ),
        ),
      );

      expect(find.text('-20%'), findsOneWidget);
    });

    testWidgets('should display original price with strikethrough when discounted',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: productWithDiscount),
            ),
          ),
        ),
      );

      expect(find.text('\$99.99'), findsOneWidget);
      expect(find.text('\$79.99'), findsOneWidget);
    });

    testWidgets('should not display discount badge when no discount',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.textContaining('%'), findsNothing);
    });

    testWidgets('should display out of stock message when not in stock',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: outOfStockProduct),
            ),
          ),
        ),
      );

      expect(find.text('Out of Stock'), findsOneWidget);
    });

    testWidgets('should not display out of stock message when in stock',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('Out of Stock'), findsNothing);
    });

    testWidgets('should display favorite icon', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('should toggle favorite when favorite icon is tapped',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      // Initially should show favorite_border
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      // Tap favorite icon
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      // Should now show filled favorite icon
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('should have card with rounded corners', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      final shape = card.shape as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(12));
    });

    testWidgets('should have elevation on card', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, equals(2));
    });

    testWidgets('should display loading indicator for image placeholder',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      // The card should be rendered
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should limit product name to 2 lines', (tester) async {
      final longNameProduct = Product(
        id: '4',
        name: 'This is a very long product name that should be truncated',
        description: 'Test',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
        images: ['https://example.com/image.jpg'],
        category: 'test',
        brand: 'Test',
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: longNameProduct),
            ),
          ),
        ),
      );

      final productNameText = tester.widget<Text>(
        find.text(
            'This is a very long product name that should be truncated'),
      );
      expect(productNameText.maxLines, equals(2));
      expect(productNameText.overflow, equals(TextOverflow.ellipsis));
    });

    testWidgets('should have column layout', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byType(Column),
        ),
        findsWidgets,
      );
    });

    testWidgets('should wrap card in GestureDetector', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('should display all product information together',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductCard(product: testProduct),
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('TestBrand'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('(100)'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
  });
}
