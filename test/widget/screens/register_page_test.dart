import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/profile/authentication/register_page.dart';
import 'package:shopping_app/widgets/app/app_logo.dart';
import 'package:shopping_app/widgets/buttons/app_filled_button.dart';
import 'package:shopping_app/widgets/form/app_text_field.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('RegisterPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(RegisterPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar with title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('should display app logo', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(AppLogo), findsOneWidget);
    });

    testWidgets('should display name field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Full Name'), findsWidgets);
    });

    testWidgets('should display email field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Email'), findsWidgets);
    });

    testWidgets('should display password field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Password'), findsWidgets);
    });

    testWidgets('should display confirm password field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Confirm Password'), findsWidgets);
    });

    testWidgets('should have four AppTextField widgets', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(AppTextField), findsNWidgets(4));
    });

    testWidgets('should display register button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Register'), findsWidgets);
      expect(find.byType(AppButtonFilled), findsOneWidget);
    });

    testWidgets('should display login redirection text', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.text('Login'), findsWidgets);
    });

    testWidgets('should have form widget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('should be scrollable', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('password fields should obscure text', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      final passwordFields = find.byType(AppTextField).evaluate()
          .map((e) => e.widget as AppTextField)
          .where((w) => w.obscureText == true);

      expect(passwordFields.length, equals(2));
    });
  });
}
