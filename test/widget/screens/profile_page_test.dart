import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/tab_pages/profile_page.dart';

void main() {
  group('ProfilePage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProfilePage(),
          ),
        ),
      );

      expect(find.byType(ProfilePage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should be wrapped in ProviderScope', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProfilePage(),
          ),
        ),
      );

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ProfilePage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as ConsumerStatefulWidget', (tester) async {
      const profilePage = ProfilePage();
      expect(profilePage, isA<ConsumerStatefulWidget>());
    });
  });
}
