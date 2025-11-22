import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/profile/contact_us_page.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('ContactUsPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ContactUsPage(),
          ),
        ),
      );

      expect(find.byType(ContactUsPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ContactUsPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
    });

    testWidgets('should display contact us title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ContactUsPage(),
          ),
        ),
      );

      expect(find.text('Contact Us'), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ContactUsPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('should render as StatelessWidget', (tester) async {
      const contactUsPage = ContactUsPage();
      expect(contactUsPage, isA<StatelessWidget>());
    });
  });
}
