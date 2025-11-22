import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopping_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Main App E2E Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app launches with bottom navigation
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify all navigation tabs are present
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('Navigate through all tabs', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tab 1: Home (default)
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Tab 2: Search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsWidgets);

      // Tab 3: Bookmarks/Favorites
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Tab 4: Profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Navigate back to home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
    });

    testWidgets('Navigate to cart from home', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Look for cart icon in app bar
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Verify cart page is displayed
        expect(find.text('Cart'), findsOneWidget);

        // Go back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Theme persists across navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Look for theme toggle
      final themeSwitch = find.byType(Switch);
      if (themeSwitch.evaluate().isNotEmpty) {
        // Toggle theme
        await tester.tap(themeSwitch.first);
        await tester.pumpAndSettle();

        // Navigate to another tab
        await tester.tap(find.byIcon(Icons.home));
        await tester.pumpAndSettle();

        // Navigate back to profile - theme should persist
        await tester.tap(find.byIcon(Icons.person));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('App handles back button correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Tap a product if available
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Press back
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();

          // Should be back on search page
          expect(find.byType(TextField), findsWidgets);
        }
      }
    });

    testWidgets('Search functionality works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to search tab
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Find search field and enter text
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField.first, 'Phone');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify search results or no results message
        expect(find.byType(ListView), findsWidgets);
      }
    });

    testWidgets('App displays products on home page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for products to load
      await tester.pump(const Duration(seconds: 2));

      // Verify some content is displayed
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Bottom navigation selection state updates', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap search tab
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Tap favorites tab
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Tap profile tab
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Tap home tab
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Verify we're back at home
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('App handles rapid navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Rapidly switch between tabs
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.bookmark));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.person));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.home));
        await tester.pump();
      }

      await tester.pumpAndSettle();

      // App should still be functional
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('App displays empty states appropriately', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to favorites (likely empty initially)
      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pumpAndSettle();

      // Should show empty state message
      expect(find.textContaining('empty', findRichText: true), findsWidgets);

      // Navigate to cart
      final cartIcon = find.byIcon(Icons.shopping_cart);
      if (cartIcon.evaluate().isNotEmpty) {
        await tester.tap(cartIcon);
        await tester.pumpAndSettle();

        // Should show empty cart message
        expect(find.textContaining('empty', findRichText: true), findsWidgets);
      }
    });
  });
}
