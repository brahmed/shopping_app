import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/buttons/app_outlined_button.dart';

void main() {
  group('AppButtonOutlined Tests', () {
    testWidgets('should render correctly with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Click Me',
              onClick: () {},
            ),
          ),
        ),
      );

      expect(find.byType(AppButtonOutlined), findsOneWidget);
      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Click Me',
              onClick: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButtonOutlined));
      expect(tapped, isTrue);
    });

    testWidgets('should render with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Submit',
              icon: const Icon(Icons.check),
              onClick: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('should apply custom height and width', (tester) async {
      const customHeight = 60.0;
      const customWidth = 200.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Button',
              height: customHeight,
              width: customWidth,
              onClick: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ),
      );

      expect(container.constraints?.maxHeight, equals(customHeight));
      expect(container.constraints?.maxWidth, equals(customWidth));
    });

    testWidgets('should apply custom outline color', (tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Button',
              outlineColor: customColor,
              onClick: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, equals(customColor));
    });

    testWidgets('should apply custom border width', (tester) async {
      const customBorderWidth = 3.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Button',
              borderWidth: customBorderWidth,
              onClick: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.width, equals(customBorderWidth));
    });

    testWidgets('should apply custom border radius', (tester) async {
      const customRadius = 16.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Button',
              radius: customRadius,
              onClick: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;
      expect(borderRadius.topLeft.x, equals(customRadius));
    });

    testWidgets('should center content when centerContent is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Centered',
              centerContent: true,
              onClick: () {},
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(
        find.descendant(
          of: find.byType(Container),
          matching: find.byType(Row),
        ),
      );

      expect(row.mainAxisAlignment, equals(MainAxisAlignment.center));
    });

    testWidgets('should align content to start when centerContent is false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Start Aligned',
              centerContent: false,
              onClick: () {},
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(
        find.descendant(
          of: find.byType(Container),
          matching: find.byType(Row),
        ),
      );

      expect(row.mainAxisAlignment, equals(MainAxisAlignment.start));
    });

    testWidgets('should apply custom text style', (tester) async {
      const customTextStyle = TextStyle(
        fontSize: 20,
        color: Colors.green,
        fontWeight: FontWeight.w300,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Custom Style',
              textStyle: customTextStyle,
              onClick: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom Style'));
      expect(textWidget.style?.fontSize, equals(customTextStyle.fontSize));
      expect(textWidget.style?.color, equals(customTextStyle.color));
      expect(
          textWidget.style?.fontWeight, equals(customTextStyle.fontWeight));
    });

    testWidgets('should apply padding and margin', (tester) async {
      const customPadding = 20.0;
      const customMargin = 10.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Button',
              padding: customPadding,
              margin: customMargin,
              onClick: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, equals(const EdgeInsets.symmetric(horizontal: customPadding)));
      expect(container.margin, equals(const EdgeInsets.symmetric(horizontal: customMargin)));
    });

    testWidgets('should show icon and text with spacing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'With Icon',
              icon: const Icon(Icons.add),
              onClick: () {},
            ),
          ),
        ),
      );

      // Check that both icon and text are present
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);

      // Check that SizedBox spacing exists
      expect(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should use theme icon color for text when no style provided',
        (tester) async {
      const testIconColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            iconTheme: const IconThemeData(color: testIconColor),
          ),
          home: Scaffold(
            body: AppButtonOutlined(
              text: 'Themed',
              onClick: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Themed'));
      expect(textWidget.style?.color, equals(testIconColor));
    });
  });
}
