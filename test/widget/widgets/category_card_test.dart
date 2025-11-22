import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/category_model.dart';
import 'package:shopping_app/widgets/cards/category_card.dart';

void main() {
  group('CategoryCard Tests', () {
    final testCategory = Category(
      id: '1',
      name: 'Electronics',
      iconName: 'phone_iphone',
      imageUrl: 'https://example.com/image.jpg',
    );

    testWidgets('should render correctly with category', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      expect(find.byType(CategoryCard), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              category: testCategory,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CategoryCard));
      expect(tapped, isTrue);
    });

    testWidgets('should display category name', (tester) async {
      final category = Category(
        id: '2',
        name: 'Fashion',
        iconName: 'checkroom',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.text('Fashion'), findsOneWidget);
    });

    testWidgets('should display correct icon for phone_iphone',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      expect(find.byIcon(Icons.phone_iphone), findsOneWidget);
    });

    testWidgets('should display correct icon for checkroom', (tester) async {
      final category = Category(
        id: '2',
        name: 'Fashion',
        iconName: 'checkroom',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.checkroom), findsOneWidget);
    });

    testWidgets('should display correct icon for shopping_bag',
        (tester) async {
      final category = Category(
        id: '3',
        name: 'Accessories',
        iconName: 'shopping_bag',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_bag), findsOneWidget);
    });

    testWidgets('should display correct icon for watch', (tester) async {
      final category = Category(
        id: '4',
        name: 'Watches',
        iconName: 'watch',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.watch), findsOneWidget);
    });

    testWidgets('should display correct icon for sports_basketball',
        (tester) async {
      final category = Category(
        id: '5',
        name: 'Sports',
        iconName: 'sports_basketball',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.sports_basketball), findsOneWidget);
    });

    testWidgets('should display correct icon for home', (tester) async {
      final category = Category(
        id: '6',
        name: 'Home',
        iconName: 'home',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('should display default icon for unknown iconName',
        (tester) async {
      final category = Category(
        id: '7',
        name: 'Other',
        iconName: 'unknown_icon',
        imageUrl: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category),
          ),
        ),
      );

      expect(find.byIcon(Icons.category), findsOneWidget);
    });

    testWidgets('should have correct container width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CategoryCard),
          matching: find.byType(Container).first,
        ),
      );

      expect(container.constraints?.maxWidth, equals(100));
    });

    testWidgets('should apply theme primary color to icon and background',
        (tester) async {
      const primaryColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: primaryColor),
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.phone_iphone));
      expect(icon.color, equals(primaryColor));
    });

    testWidgets('should have rounded border radius', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final iconContainer = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(CategoryCard),
          matching: find.byType(Container),
        ),
      ).elementAt(1);

      final decoration = iconContainer.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(16));
    });

    testWidgets('should center align text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Electronics'));
      expect(textWidget.textAlign, equals(TextAlign.center));
    });

    testWidgets('should limit text to 2 lines with ellipsis', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Electronics'));
      expect(textWidget.maxLines, equals(2));
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
    });

    testWidgets('should have proper spacing between icon and text',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(Column),
          matching: find.byType(SizedBox),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should have margin on right side', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CategoryCard),
          matching: find.byType(Container).first,
        ),
      );

      expect(container.margin, equals(const EdgeInsets.only(right: 12)));
    });

    testWidgets('should wrap in GestureDetector for tap handling',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: testCategory),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('should handle null onTap gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              category: testCategory,
              onTap: null,
            ),
          ),
        ),
      );

      expect(find.byType(CategoryCard), findsOneWidget);
      // Should not throw error when tapped
      await tester.tap(find.byType(CategoryCard));
      await tester.pump();
    });
  });
}
