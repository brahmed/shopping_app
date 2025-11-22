import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/tab_pages/bookmarks_page.dart';

void main() {
  group('BookmarksPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookmarksPage(),
          ),
        ),
      );

      expect(find.byType(BookmarksPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookmarksPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerWidget', (tester) async {
      const bookmarksPage = BookmarksPage();
      expect(bookmarksPage, isA<ConsumerWidget>());
    });
  });
}
