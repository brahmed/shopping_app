import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/config/colors.dart';
import 'package:shopping_app/widgets/arrow_icon.dart';

void main() {
  group('ArrowIcon Tests', () {
    testWidgets('should render correctly with default parameters',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(),
          ),
        ),
      );

      expect(find.byType(ArrowIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
    });

    testWidgets('should apply custom padding', (tester) async {
      const customPadding = 8.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(padding: customPadding),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(const EdgeInsets.all(customPadding)));
    });

    testWidgets('should apply custom margin', (tester) async {
      const customMargin = 8.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(margin: customMargin),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, equals(const EdgeInsets.all(customMargin)));
    });

    testWidgets('should apply custom icon size', (tester) async {
      const customIconSize = 24.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(iconSize: customIconSize),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, equals(customIconSize));
    });

    testWidgets('should apply custom icon color', (tester) async {
      const customIconColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(iconColor: customIconColor),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, equals(customIconColor));
    });

    testWidgets('should apply custom background color', (tester) async {
      const customBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(backgroundColor: customBackgroundColor),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customBackgroundColor));
    });

    testWidgets('should use custom icon', (tester) async {
      const customIcon = Icons.arrow_back_ios_rounded;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(icon: customIcon),
          ),
        ),
      );

      expect(find.byIcon(customIcon), findsOneWidget);
    });

    testWidgets('should have circular shape', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, equals(BoxShape.circle));
    });

    testWidgets('should use default colors from ColorsSet', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, equals(ColorsSet.grayDark));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(ColorsSet.grayLighter));
    });

    testWidgets('should apply all custom properties together',
        (tester) async {
      const customPadding = 6.0;
      const customMargin = 8.0;
      const customIconSize = 20.0;
      const customIconColor = Colors.white;
      const customBackgroundColor = Colors.black;
      const customIcon = Icons.chevron_right;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ArrowIcon(
              padding: customPadding,
              margin: customMargin,
              iconSize: customIconSize,
              iconColor: customIconColor,
              backgroundColor: customBackgroundColor,
              icon: customIcon,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(const EdgeInsets.all(customPadding)));
      expect(container.margin, equals(const EdgeInsets.all(customMargin)));

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customBackgroundColor));

      final icon = tester.widget<Icon>(find.byIcon(customIcon));
      expect(icon.size, equals(customIconSize));
      expect(icon.color, equals(customIconColor));
    });
  });
}
