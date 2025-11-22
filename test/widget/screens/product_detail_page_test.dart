import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/screens/products/product_detail_page.dart';

void main() {
  group('ProductDetailPage Tests', () {
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

    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.byType(ProductDetailPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display product name', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('should display product brand', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.text('TestBrand'), findsOneWidget);
    });

    testWidgets('should display product price', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.text('\$99.99'), findsWidgets);
    });

    testWidgets('should display product description', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.text('Test description'), findsOneWidget);
    });

    testWidgets('should have app bar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerStatefulWidget', (tester) async {
      final page = ProductDetailPage(product: testProduct);
      expect(page, isA<ConsumerStatefulWidget>());
    });
  });
}
