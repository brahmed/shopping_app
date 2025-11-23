import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/cards/app_card.dart';

void main() {
  group('AppCard Tests', () {
    testWidgets('should render correctly with child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.byType(AppCard), findsOneWidget);
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('should apply default margin', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.all(8.0)));
    });

    testWidgets('should apply custom margin', (tester) async {
      const customMargin = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              margin: customMargin,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.all(customMargin)));
    });

    testWidgets('should apply default padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(const EdgeInsets.all(8.0)));
    });

    testWidgets('should apply custom padding', (tester) async {
      const customPadding = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              padding: customPadding,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(const EdgeInsets.all(customPadding)));
    });

    testWidgets('should apply default border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(15));
    });

    testWidgets('should apply custom border radius', (tester) async {
      const customRadius = 20.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              radius: customRadius,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(customRadius));
    });

    testWidgets('should use theme background color when color not provided',
        (tester) async {
      const testBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme(surface: testBackgroundColor),
          ),
          home: const Scaffold(
            body: AppCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(testBackgroundColor));
    });

    testWidgets('should apply custom color', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              color: customColor,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customColor));
    });

    testWidgets('should apply default box shadow', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow?.length, equals(1));
    });

    testWidgets('should apply custom box shadow', (tester) async {
      const customBoxShadow = BoxShadow(
        color: Colors.red,
        blurRadius: 10.0,
        spreadRadius: 5.0,
        offset: Offset(2.0, 2.0),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              boxShadow: customBoxShadow,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow?.first.color, equals(Colors.red));
      expect(decoration.boxShadow?.first.blurRadius, equals(10.0));
      expect(decoration.boxShadow?.first.spreadRadius, equals(5.0));
    });

    testWidgets('should render complex child widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Column(
                children: [
                  Text('Title'),
                  SizedBox(height: 8),
                  Text('Description'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should apply all custom properties together',
        (tester) async {
      const customMargin = 12.0;
      const customPadding = 16.0;
      const customRadius = 25.0;
      const customColor = Colors.green;
      const customBoxShadow = BoxShadow(
        color: Colors.black,
        blurRadius: 5.0,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              margin: customMargin,
              padding: customPadding,
              radius: customRadius,
              color: customColor,
              boxShadow: customBoxShadow,
              child: Text('All Custom'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.all(customMargin)));
      expect(container.padding, equals(const EdgeInsets.all(customPadding)));

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customColor));
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(customRadius));
      expect(decoration.boxShadow?.first.color, equals(Colors.black));
    });
  });
}
