import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shopping_app/screens/cart/cart_page.dart';
import 'package:shopping_app/screens/tab_pages/home_page.dart';
import 'package:shopping_app/screens/tab_pages/search_page.dart';
import 'package:shopping_app/screens/tab_pages/profile_page.dart';
import 'package:shopping_app/screens/tab_pages/bookmarks_page.dart';

void main() {
  group('Screens Golden Tests', () {
    testGoldens('Home Page - Light Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const HomePage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(375, 667), // iPhone SE size
      );

      await screenMatchesGolden(tester, 'home_page_light');
    });

    testGoldens('Home Page - Dark Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const HomePage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'home_page_dark');
    });

    testGoldens('Search Page - Light Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const SearchPage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'search_page_light');
    });

    testGoldens('Search Page - Dark Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const SearchPage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'search_page_dark');
    });

    testGoldens('Bookmarks Page - Light Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const BookmarksPage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'bookmarks_page_light');
    });

    testGoldens('Bookmarks Page - Dark Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const BookmarksPage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'bookmarks_page_dark');
    });

    testGoldens('Profile Page - Light Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const ProfilePage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'profile_page_light');
    });

    testGoldens('Profile Page - Dark Theme', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const ProfilePage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'profile_page_dark');
    });

    testGoldens('Cart Page - Empty State', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const ProviderScope(
          child: CartPage(),
        ),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(375, 667),
      );

      await screenMatchesGolden(tester, 'cart_page_empty');
    });

    testGoldens('Home Page - Tablet Size', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        const HomePage(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(768, 1024), // iPad size
      );

      await screenMatchesGolden(tester, 'home_page_tablet');
    });

    testGoldens('Search Page - Different Locales', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 1,
      )
        ..addScenario(
          'English',
          const MaterialApp(
            locale: Locale('en', 'US'),
            home: SearchPage(),
          ),
        )
        ..addScenario(
          'French',
          const MaterialApp(
            locale: Locale('fr', 'FR'),
            home: SearchPage(),
          ),
        )
        ..addScenario(
          'Arabic',
          const MaterialApp(
            locale: Locale('ar', 'TN'),
            home: SearchPage(),
          ),
        );

      await tester.pumpWidgetBuilder(builder.build());
      await screenMatchesGolden(tester, 'search_page_locales');
    });

    testGoldens('Profile Page - Different Screen Sizes', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 3,
        widthToHeightRatio: 0.5,
      )
        ..addScenario(
          'Small Phone',
          const SizedBox(
            width: 320,
            height: 568,
            child: ProfilePage(),
          ),
        )
        ..addScenario(
          'Medium Phone',
          const SizedBox(
            width: 375,
            height: 667,
            child: ProfilePage(),
          ),
        )
        ..addScenario(
          'Large Phone',
          const SizedBox(
            width: 414,
            height: 896,
            child: ProfilePage(),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'profile_page_sizes');
    });
  });
}
