import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/cards/app_page_container.dart';

void main() {
  group('AppPageContainer Tests', () {
    testWidgets('should render correctly with child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Page Content'),
            ),
          ),
        ),
      );

      expect(find.byType(AppPageContainer), findsOneWidget);
      expect(find.text('Page Content'), findsOneWidget);
    });

    testWidgets('should use default margin top', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.only(top: 20.0)));
    });

    testWidgets('should apply custom margin top', (tester) async {
      const customMarginTop = 40.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              marginTop: customMarginTop,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.only(top: customMarginTop)));
    });

    testWidgets('should use screen height when height not provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(find.byType(AppPageContainer));
      final screenHeight = MediaQuery.of(context).size.height;

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, equals(screenHeight));
    });

    testWidgets('should apply custom height when provided', (tester) async {
      const customHeight = 500.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              height: customHeight,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, equals(customHeight));
    });

    testWidgets('should apply default border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(30.0));
      expect(borderRadius.topRight.x, equals(30.0));
      expect(borderRadius.bottomLeft.x, equals(0));
      expect(borderRadius.bottomRight.x, equals(0));
    });

    testWidgets('should apply custom border radius', (tester) async {
      const customBorderRadius = 20.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              borderRadius: customBorderRadius,
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(customBorderRadius));
      expect(borderRadius.topRight.x, equals(customBorderRadius));
    });

    testWidgets('should use theme background color', (tester) async {
      const testBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            backgroundColor: testBackgroundColor,
          ),
          home: const Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(testBackgroundColor));
    });

    testWidgets('should have box shadow', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow?.length, equals(1));
      expect(decoration.boxShadow?.first.spreadRadius, equals(2));
      expect(decoration.boxShadow?.first.blurRadius, equals(2));
    });

    testWidgets('should have only top border radius (vertical)',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Should be BorderRadius.vertical which only affects top
      expect(decoration.borderRadius, isA<BorderRadius>());
    });

    testWidgets('should render complex child widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              child: Column(
                children: const [
                  Text('Title'),
                  SizedBox(height: 16),
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
      const customHeight = 600.0;
      const customMarginTop = 30.0;
      const customBorderRadius = 25.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageContainer(
              height: customHeight,
              marginTop: customMarginTop,
              borderRadius: customBorderRadius,
              child: Text('All Custom'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, equals(customHeight));
      expect(container.margin, equals(const EdgeInsets.only(top: customMarginTop)));

      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(customBorderRadius));
    });
  });
}
