import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/app/app_logo.dart';

void main() {
  group('AppLogo Tests', () {
    testWidgets('should render correctly with default parameters',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLogo(),
          ),
        ),
      );

      expect(find.byType(AppLogo), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should render with custom height', (tester) async {
      const customHeight = 150.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLogo(height: customHeight),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.height, equals(customHeight));
    });

    testWidgets('should render with custom scale', (tester) async {
      const customScale = 2.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLogo(scale: customScale),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.scale, equals(customScale));
    });

    testWidgets('should use theme icon color', (tester) async {
      const testIconColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            iconTheme: const IconThemeData(color: testIconColor),
          ),
          home: const Scaffold(
            body: AppLogo(),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.color, equals(testIconColor));
    });

    testWidgets('should apply multiple custom properties', (tester) async {
      const customHeight = 250.0;
      const customScale = 1.5;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLogo(
              height: customHeight,
              scale: customScale,
            ),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.height, equals(customHeight));
      expect(image.scale, equals(customScale));
    });
  });
}
