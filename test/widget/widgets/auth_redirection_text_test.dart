import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/widgets/form/auth_redirection_text.dart';

void main() {
  group('AuthRedirectionText Tests', () {
    testWidgets('should render static and clickable text', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: "Don't have an account?",
                clickableText: 'Sign Up',
                redirectionRouteName: '/signup',
              ),
            ),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) => const Scaffold(
              body: Text('Sign Up Page'),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.text(' Sign Up'), findsOneWidget);
    });

    testWidgets('should navigate when clickable text is tapped',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Already have an account?',
                clickableText: 'Login',
                redirectionRouteName: '/login',
              ),
            ),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const Scaffold(
              body: Text('Login Page'),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.text(' Login'), findsOneWidget);

      await tester.tap(find.text(' Login'));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });

    testWidgets('should display texts in a row', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Need help?',
                clickableText: 'Contact Us',
                redirectionRouteName: '/contact',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.byType(Row), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(Row),
          matching: find.text('Need help?'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should center align the row content', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Test',
                clickableText: 'Click',
                redirectionRouteName: '/test',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, equals(MainAxisAlignment.center));
    });

    testWidgets('should add space before clickable text', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Prefix',
                clickableText: 'Link',
                redirectionRouteName: '/route',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      // The clickable text should have a leading space
      expect(find.text(' Link'), findsOneWidget);
    });

    testWidgets('should use theme body medium style for static text',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Static',
                clickableText: 'Click',
                redirectionRouteName: '/test',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ),
      );

      final staticText = tester.widget<Text>(find.text('Static'));
      expect(staticText.style?.fontSize, equals(14));
      expect(staticText.style?.color, equals(Colors.grey));
    });

    testWidgets('static text should not soft wrap', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'No wrap text',
                clickableText: 'Link',
                redirectionRouteName: '/test',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final staticText = tester.widget<Text>(find.text('No wrap text'));
      expect(staticText.softWrap, isFalse);
    });

    testWidgets('static text should be right aligned', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionText(
                staticText: 'Aligned text',
                clickableText: 'Link',
                redirectionRouteName: '/test',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final staticText = tester.widget<Text>(find.text('Aligned text'));
      expect(staticText.textAlign, equals(TextAlign.right));
    });
  });
}
