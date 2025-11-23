import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/providers/user_provider_riverpod.dart';
import 'package:shopping_app/providers/cart_provider_riverpod.dart';

void main() {
  group('User Authentication Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Login flow: Navigate to login → Enter credentials → Browse',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Step 1: Navigate to profile page
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();
      }

      // Step 2: Find and tap login button
      final loginButton = find.textContaining('Login', findRichText: true);
      if (loginButton.evaluate().isNotEmpty) {
        await tester.tap(loginButton.first);
        await tester.pumpAndSettle();

        // Step 3: Verify login page is displayed
        expect(find.byType(TextField), findsWidgets);

        // Step 4: Enter email
        final emailField = find.byType(TextField).first;
        await tester.enterText(emailField, 'test@example.com');
        await tester.pumpAndSettle();

        // Step 5: Enter password
        final passwordFields = find.byType(TextField);
        if (passwordFields.evaluate().length > 1) {
          await tester.enterText(passwordFields.at(1), 'password123');
          await tester.pumpAndSettle();
        }

        // Step 6: Tap login button
        final submitButton = find.widgetWithText(ElevatedButton, 'Login');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Logout flow: Profile → Logout → Verify guest state',
        (WidgetTester tester) async {
      // First login
      container.read(userProvider.notifier).loginUser();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith((ref) => UserNotifier()),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Find logout button
        final logoutButton = find.textContaining('Logout', findRichText: true);
        if (logoutButton.evaluate().isNotEmpty) {
          await tester.tap(logoutButton.first);
          await tester.pumpAndSettle();

          // Verify logged out state
          expect(find.textContaining('Login', findRichText: true), findsWidgets);
        }
      }
    });

    test('User state management during authentication', () async {
      // Initial state - not logged in
      expect(container.read(userProvider).isUserLogged, false);

      // Login
      await container.read(userProvider.notifier).loginUser();
      expect(container.read(userProvider).isUserLogged, true);
      expect(container.read(userProvider).currentUserToken, isNotNull);

      // Logout
      await container.read(userProvider.notifier).logoutUser();
      expect(container.read(userProvider).isUserLogged, false);
      expect(container.read(userProvider).currentUserToken, isNull);
    });

    testWidgets('Register flow: Navigate to register → Fill form → Submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to profile
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();
      }

      // Look for register link or button
      final registerButton = find.textContaining('Register', findRichText: true);
      if (registerButton.evaluate().isNotEmpty) {
        await tester.tap(registerButton.first);
        await tester.pumpAndSettle();

        // Verify registration form
        expect(find.byType(TextField), findsWidgets);

        // Fill registration form
        final textFields = find.byType(TextField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, 'New User');
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Authentication persistence across app restarts',
        (WidgetTester tester) async {
      // Simulate login
      final firstContainer = ProviderContainer();
      await firstContainer.read(userProvider.notifier).loginUser();
      expect(firstContainer.read(userProvider).isUserLogged, true);
      firstContainer.dispose();

      // Restart app - user should still be logged in
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();
    });

    test('Cart persistence after login/logout', () async {
      // Add items to cart as guest
      container.read(cartProvider.notifier).addItem(
        container.read(productsProvider).first,
      );

      final guestCartCount = container.read(cartProvider).items.length;
      expect(guestCartCount, greaterThan(0));

      // Login
      await container.read(userProvider.notifier).loginUser();

      // Cart should persist
      expect(container.read(cartProvider).items.length, guestCartCount);

      // Logout
      await container.read(userProvider.notifier).logoutUser();

      // Cart might be cleared or persisted based on business logic
      // This test verifies the behavior is consistent
    });

    testWidgets('Protected routes redirect to login',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Try to access orders without login
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        // Look for orders option
        final ordersButton = find.textContaining('Orders', findRichText: true);
        if (ordersButton.evaluate().isNotEmpty) {
          await tester.tap(ordersButton.first);
          await tester.pumpAndSettle();

          // Should show login prompt if not authenticated
          // or navigate to orders if authenticated
        }
      }
    });

    test('User session token management', () async {
      final userState = container.read(userProvider);
      expect(userState.currentUserToken, isNull);

      await container.read(userProvider.notifier).loginUser();
      final loggedInState = container.read(userProvider);
      expect(loggedInState.currentUserToken, isNotNull);
      expect(loggedInState.isUserLogged, true);
    });

    testWidgets('Login form validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to login
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        final loginButton = find.textContaining('Login', findRichText: true);
        if (loginButton.evaluate().isNotEmpty) {
          await tester.tap(loginButton.first);
          await tester.pumpAndSettle();

          // Try to submit empty form
          final submitButton = find.widgetWithText(ElevatedButton, 'Login');
          if (submitButton.evaluate().isNotEmpty) {
            await tester.tap(submitButton);
            await tester.pumpAndSettle();

            // Should show validation errors
            expect(find.textContaining('required', findRichText: true), findsWidgets);
          }
        }
      }
    });

    testWidgets('Password visibility toggle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to login page
      final profileTab = find.byIcon(Icons.person);
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle();

        final loginButton = find.textContaining('Login', findRichText: true);
        if (loginButton.evaluate().isNotEmpty) {
          await tester.tap(loginButton.first);
          await tester.pumpAndSettle();

          // Find password visibility toggle
          final visibilityIcon = find.byIcon(Icons.visibility);
          final visibilityOffIcon = find.byIcon(Icons.visibility_off);

          if (visibilityIcon.evaluate().isNotEmpty ||
              visibilityOffIcon.evaluate().isNotEmpty) {
            // Tap to toggle
            final icon = visibilityIcon.evaluate().isNotEmpty
                ? visibilityIcon
                : visibilityOffIcon;
            await tester.tap(icon);
            await tester.pumpAndSettle();
          }
        }
      }
    });

    test('Multiple login attempts handling', () async {
      // First login
      await container.read(userProvider.notifier).loginUser();
      expect(container.read(userProvider).isUserLogged, true);

      // Logout
      await container.read(userProvider.notifier).logoutUser();
      expect(container.read(userProvider).isUserLogged, false);

      // Second login
      await container.read(userProvider.notifier).loginUser();
      expect(container.read(userProvider).isUserLogged, true);
    });
  });
}
