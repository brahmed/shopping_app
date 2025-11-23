import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';
import 'package:shopping_app/widgets/arrow_icon.dart';

void main() {
  group('PageAppBar Tests', () {
    testWidgets('should render correctly with title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Settings'),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should implement PreferredSizeWidget', (tester) async {
      const appBar = PageAppBar(title: 'Test');
      expect(appBar, isA<PreferredSizeWidget>());
    });

    testWidgets('should have correct preferred size', (tester) async {
      const appBar = PageAppBar(title: 'Test');
      expect(appBar.preferredSize, equals(const Size.fromHeight(kToolbarHeight)));
    });

    testWidgets('should have zero elevation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Test'),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.elevation, equals(0));
    });

    testWidgets('should center align title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Centered'),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });

    testWidgets('should use theme headlineLarge for title style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          home: const Scaffold(
            appBar: PageAppBar(title: 'Styled Title'),
          ),
        ),
      );

      final titleWidget = tester.widget<Text>(find.text('Styled Title'));
      expect(titleWidget.style?.fontSize, equals(24));
      expect(titleWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should have back arrow icon as leading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Test'),
          ),
        ),
      );

      expect(find.byType(ArrowIcon), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_rounded), findsOneWidget);
    });

    testWidgets('should navigate back when leading icon is tapped',
        (tester) async {
      bool popped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: const PageAppBar(title: 'Second Page'),
                          body: Container(),
                        ),
                      ),
                    ).then((_) => popped = true);
                  },
                  child: const Text('Go to Second Page'),
                ),
              ),
            ),
          ),
        ),
      );

      // Navigate to second page
      await tester.tap(find.text('Go to Second Page'));
      await tester.pumpAndSettle();

      expect(find.text('Second Page'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byType(ArrowIcon));
      await tester.pumpAndSettle();

      expect(popped, isTrue);
    });

    testWidgets('should have proper margin on leading icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Test'),
          ),
        ),
      );

      final arrowIcon = tester.widget<ArrowIcon>(find.byType(ArrowIcon));
      expect(arrowIcon.margin, equals(12));
    });

    testWidgets('should wrap leading in GestureDetector', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Test'),
          ),
        ),
      );

      // Find GestureDetector that wraps ArrowIcon
      final gestureDetector = find.ancestor(
        of: find.byType(ArrowIcon),
        matching: find.byType(GestureDetector),
      );

      expect(gestureDetector, findsOneWidget);
    });

    testWidgets('should be usable as AppBar in Scaffold', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const PageAppBar(title: 'My Page'),
            body: const Text('Body Content'),
          ),
        ),
      );

      expect(find.text('My Page'), findsOneWidget);
      expect(find.text('Body Content'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display different titles correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Profile Settings'),
          ),
        ),
      );

      expect(find.text('Profile Settings'), findsOneWidget);
    });

    testWidgets('should have AppBar as child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PageAppBar(title: 'Test'),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
