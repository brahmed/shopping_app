import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screens/profile/authentication/login_page.dart';
import 'package:shopping_app/widgets/app/app_logo.dart';
import 'package:shopping_app/widgets/buttons/app_filled_button.dart';
import 'package:shopping_app/widgets/buttons/app_outlined_button.dart';
import 'package:shopping_app/widgets/form/app_text_field.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

void main() {
  group('LoginPage Tests', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page app bar with title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(PageAppBar), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should display app logo', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(AppLogo), findsOneWidget);
    });

    testWidgets('should display email field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Email'), findsWidgets);
    });

    testWidgets('should display password field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Password'), findsWidgets);
    });

    testWidgets('should have two AppTextField widgets', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(AppTextField), findsNWidgets(2));
    });

    testWidgets('should display forgot password link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Forgot your password ?'), findsOneWidget);
    });

    testWidgets('should display login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Login'), findsWidgets);
      expect(find.byType(AppButtonFilled), findsOneWidget);
    });

    testWidgets('should display create account redirection text',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('New on this App?'), findsOneWidget);
      expect(find.text('Create an account'), findsOneWidget);
    });

    testWidgets('should display social login divider', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('or'), findsOneWidget);
      expect(find.byType(Divider), findsWidgets);
    });

    testWidgets('should display facebook login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Continue with Facebook'), findsOneWidget);
    });

    testWidgets('should display google login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('should have two AppButtonOutlined widgets', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(AppButtonOutlined), findsNWidgets(2));
    });

    testWidgets('should have form widget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('should be scrollable', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should handle email input', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'test@example.com');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('should handle password input', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(1), 'password123');
      await tester.pump();

      // Password should be obscured but input should work
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('password field should obscure text', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      final passwordFields = find.byType(AppTextField).evaluate()
          .map((e) => e.widget as AppTextField)
          .where((w) => w.obscureText == true);

      expect(passwordFields.length, equals(1));
    });

    testWidgets('should be wrapped in safe area', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });
  });
}
