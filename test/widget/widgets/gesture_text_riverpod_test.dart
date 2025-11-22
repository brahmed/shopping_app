import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/form/gesture_text_riverpod.dart';

void main() {
  group('GestureTextRiverpod Tests', () {
    testWidgets('should render correctly with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureTextRiverpod(
              text: 'Click Here',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GestureTextRiverpod), findsOneWidget);
      expect(find.text('Click Here'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureTextRiverpod(
              text: 'Tap Me',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('should use theme primary color', (tester) async {
      const testPrimaryColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: testPrimaryColor),
          home: Scaffold(
            body: GestureTextRiverpod(
              text: 'Themed Text',
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Themed Text'));
      expect(textWidget.style?.color, equals(testPrimaryColor));
    });

    testWidgets('should be underlined', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureTextRiverpod(
              text: 'Underlined',
              onTap: () {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Underlined'));
      expect(textWidget.style?.decoration, equals(TextDecoration.underline));
    });

    testWidgets('should be wrapped in GestureDetector', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureTextRiverpod(
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
            body: GestureTextRiverpod(
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

    testWidgets('should display different text content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GestureTextRiverpod(text: 'First', onTap: () {}),
                GestureTextRiverpod(text: 'Second', onTap: () {}),
                GestureTextRiverpod(text: 'Third', onTap: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
    });

    testWidgets('should trigger different callbacks', (tester) async {
      bool firstTapped = false;
      bool secondTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GestureTextRiverpod(
                  text: 'First',
                  onTap: () => firstTapped = true,
                ),
                GestureTextRiverpod(
                  text: 'Second',
                  onTap: () => secondTapped = true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('First'));
      expect(firstTapped, isTrue);
      expect(secondTapped, isFalse);

      await tester.tap(find.text('Second'));
      expect(secondTapped, isTrue);
    });

    testWidgets('should apply theme primary color to multiple instances',
        (tester) async {
      const testColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: testColor),
          home: Scaffold(
            body: Column(
              children: [
                GestureTextRiverpod(text: 'One', onTap: () {}),
                GestureTextRiverpod(text: 'Two', onTap: () {}),
              ],
            ),
          ),
        ),
      );

      final firstText = tester.widget<Text>(find.text('One'));
      final secondText = tester.widget<Text>(find.text('Two'));

      expect(firstText.style?.color, equals(testColor));
      expect(secondText.style?.color, equals(testColor));
    });

    testWidgets('should render as a Text widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureTextRiverpod(
              text: 'Text Widget',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
