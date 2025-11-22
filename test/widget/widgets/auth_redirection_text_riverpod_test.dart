import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/widgets/form/auth_redirection_text_riverpod.dart';

void main() {
  group('AuthRedirectionTextRiverpod Tests', () {
    testWidgets('should render static and clickable text', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: "Don't have an account?",
                clickableText: 'Sign Up',
                redirectionRoute: '/signup',
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
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should navigate when clickable text is tapped',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Already have an account?',
                clickableText: 'Login',
                redirectionRoute: '/login',
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
      expect(find.text('Login'), findsOneWidget);

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });

    testWidgets('should display texts in a row', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Need help?',
                clickableText: 'Contact Us',
                redirectionRoute: '/contact',
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
              body: AuthRedirectionTextRiverpod(
                staticText: 'Test',
                clickableText: 'Click',
                redirectionRoute: '/test',
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

    testWidgets('should have spacing between texts', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Prefix',
                clickableText: 'Link',
                redirectionRoute: '/route',
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

      expect(
        find.descendant(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ),
        findsOneWidget,
      );
    });

    testWidgets('clickable text should use theme primary color',
        (tester) async {
      const primaryColor = Colors.blue;

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Static',
                clickableText: 'Click',
                redirectionRoute: '/test',
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(primaryColor: primaryColor),
        ),
      );

      final clickableText = tester.widget<Text>(find.text('Click'));
      expect(clickableText.style?.color, equals(primaryColor));
    });

    testWidgets('clickable text should be bold', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Test',
                clickableText: 'Bold',
                redirectionRoute: '/test',
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

      final clickableText = tester.widget<Text>(find.text('Bold'));
      expect(clickableText.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('clickable text should be underlined', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Test',
                clickableText: 'Underlined',
                redirectionRoute: '/test',
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

      final clickableText = tester.widget<Text>(find.text('Underlined'));
      expect(clickableText.style?.decoration, equals(TextDecoration.underline));
    });

    testWidgets('should wrap clickable text in GestureDetector',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: AuthRedirectionTextRiverpod(
                staticText: 'Test',
                clickableText: 'Tap',
                redirectionRoute: '/test',
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

      expect(find.byType(GestureDetector), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.text('Tap'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display multiple different text combinations',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: Column(
                children: [
                  AuthRedirectionTextRiverpod(
                    staticText: 'First',
                    clickableText: 'One',
                    redirectionRoute: '/one',
                  ),
                  AuthRedirectionTextRiverpod(
                    staticText: 'Second',
                    clickableText: 'Two',
                    redirectionRoute: '/two',
                  ),
                ],
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

      expect(find.text('First'), findsOneWidget);
      expect(find.text('One'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    });
  });
}
