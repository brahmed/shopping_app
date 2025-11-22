import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/form/app_text_field.dart';

void main() {
  group('AppTextField Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(),
          ),
        ),
      );

      expect(find.byType(AppTextField), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should display hint text', (tester) async {
      const hintText = 'Enter your name';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(hintText: hintText),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('should display label widget', (tester) async {
      const labelText = 'Username';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: Text(labelText),
            ),
          ),
        ),
      );

      expect(find.text(labelText), findsOneWidget);
    });

    testWidgets('should handle text input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(controller: controller),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Test Input');
      expect(controller.text, equals('Test Input'));
    });

    testWidgets('should apply keyboard type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.keyboardType, equals(TextInputType.emailAddress));
    });

    testWidgets('should obscure text when obscureText is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(obscureText: true),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('should not obscure text when obscureText is false',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(obscureText: false),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.obscureText, isFalse);
    });

    testWidgets('should support multiline with maxLines', (tester) async {
      const maxLines = 3;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(maxLines: maxLines),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.minLines, equals(maxLines));
    });

    testWidgets('should handle focus node', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(focusNode: focusNode),
          ),
        ),
      );

      expect(focusNode.hasFocus, isFalse);

      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('should apply all properties together', (tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      const hintText = 'Enter password';
      const labelText = 'Password';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              focusNode: focusNode,
              label: const Text(labelText),
              hintText: hintText,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              maxLines: 1,
            ),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
      expect(find.text(labelText), findsOneWidget);

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.controller, equals(controller));
      expect(textField.focusNode, equals(focusNode));
      expect(textField.keyboardType, equals(TextInputType.visiblePassword));
      expect(textField.obscureText, isTrue);
      expect(textField.minLines, equals(1));
    });

    testWidgets('should use default keyboard type when not specified',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.keyboardType, equals(TextInputType.text));
    });

    testWidgets('should have default maxLines of 1', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.minLines, equals(1));
    });
  });
}
