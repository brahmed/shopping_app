import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/form/gesture_text.dart';

void main() {
  group('GestureText Tests', () {
    testWidgets('should render correctly with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Click Here',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GestureText), findsOneWidget);
      expect(find.text('Click Here'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Tap Me',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('should apply custom text style', (tester) async {
      const customTextStyle = TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Styled Text',
              textStyle: customTextStyle,
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Styled Text'));
      expect(textWidget.style?.fontSize, equals(customTextStyle.fontSize));
      expect(textWidget.style?.color, equals(customTextStyle.color));
      expect(
          textWidget.style?.fontWeight, equals(customTextStyle.fontWeight));
    });

    testWidgets('should use theme text style when not provided',
        (tester) async {
      const testIconColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            iconTheme: const IconThemeData(color: testIconColor),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 16),
            ),
          ),
          home: Scaffold(
            body: GestureText(
              text: 'Themed Text',
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Themed Text'));
      expect(textWidget.style?.color, equals(testIconColor));
    });

    testWidgets('should have right text alignment', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Aligned Text',
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Aligned Text'));
      expect(textWidget.textAlign, equals(TextAlign.right));
    });

    testWidgets('should not soft wrap text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'No Wrap Text',
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('No Wrap Text'));
      expect(textWidget.softWrap, isFalse);
    });

    testWidgets('should be wrapped in GestureDetector', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Gesture Text',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.text('Gesture Text'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should handle multiple taps', (tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureText(
              text: 'Tap Multiple',
              onTap: () => tapCount++,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Multiple'));
      await tester.tap(find.text('Tap Multiple'));
      await tester.tap(find.text('Tap Multiple'));

      expect(tapCount, equals(3));
    });
  });
}
