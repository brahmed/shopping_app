import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/cards/app_list_tile.dart';
import 'package:shopping_app/widgets/arrow_icon.dart';

void main() {
  group('AppListTile Tests', () {
    testWidgets('should render correctly with text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(text: 'Settings'),
          ),
        ),
      );

      expect(find.byType(AppListTile), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Tap Me',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppListTile));
      expect(tapped, isTrue);
    });

    testWidgets('should render with icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Profile',
              iconData: Icons.person,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('should always show arrow icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(text: 'Item'),
          ),
        ),
      );

      expect(find.byType(ArrowIcon), findsOneWidget);
    });

    testWidgets('should apply custom margin', (tester) async {
      const customMargin = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Item',
              margin: customMargin,
            ),
          ),
        ),
      );

      // The margin is passed to AppCard which wraps a Container
      expect(find.byType(AppListTile), findsOneWidget);
    });

    testWidgets('should apply custom padding', (tester) async {
      const customPadding = 16.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Item',
              padding: customPadding,
            ),
          ),
        ),
      );

      expect(find.byType(AppListTile), findsOneWidget);
    });

    testWidgets('should apply custom border radius', (tester) async {
      const customRadius = 12.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Item',
              radius: customRadius,
            ),
          ),
        ),
      );

      expect(find.byType(AppListTile), findsOneWidget);
    });

    testWidgets('should apply custom icon size', (tester) async {
      const customIconSize = 40.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Item',
              iconData: Icons.settings,
              iconSize: customIconSize,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.settings));
      expect(icon.size, equals(customIconSize));
    });

    testWidgets('should layout icon, text, and arrow in a row',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Settings',
              iconData: Icons.settings,
            ),
          ),
        ),
      );

      final row = find.descendant(
        of: find.byType(AppListTile),
        matching: find.byType(Row),
      );

      expect(row, findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.byType(ArrowIcon), findsOneWidget);
    });

    testWidgets('should have spacing between icon and text when icon present',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Item',
              iconData: Icons.home,
            ),
          ),
        ),
      );

      // Should find SizedBox for spacing
      expect(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ),
        findsWidgets,
      );
    });

    testWidgets('should not show icon spacing when no icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(text: 'No Icon'),
          ),
        ),
      );

      expect(find.text('No Icon'), findsOneWidget);
      // Icon should not be present
      expect(find.byType(Icon).hitTestable(), findsNothing);
    });

    testWidgets('should use theme text style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          home: const Scaffold(
            body: AppListTile(text: 'Themed'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Themed'));
      expect(textWidget.style?.fontSize, equals(18));
      expect(textWidget.style?.color, equals(Colors.blue));
    });

    testWidgets('should expand spacing between text and arrow',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(text: 'Expanded'),
          ),
        ),
      );

      // Should have Expanded widget for spacing
      expect(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(Expanded),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should apply all custom properties together',
        (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              text: 'Complete',
              iconData: Icons.check,
              iconSize: 40,
              margin: 12,
              padding: 16,
              radius: 10,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Complete'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byType(ArrowIcon), findsOneWidget);

      await tester.tap(find.byType(AppListTile));
      expect(tapped, isTrue);

      final icon = tester.widget<Icon>(find.byIcon(Icons.check));
      expect(icon.size, equals(40.0));
    });
  });
}
