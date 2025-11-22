import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/profile/help_page.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('HelpPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HelpPage(),
          ),
        ),
      );

      expect(find.byType(HelpPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HelpPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
    });

    testWidgets('should display help title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HelpPage(),
          ),
        ),
      );

      expect(find.text('Help'), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HelpPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as StatelessWidget', (tester) async {
      const helpPage = HelpPage();
      expect(helpPage, isA<StatelessWidget>());
    });
  });
}
