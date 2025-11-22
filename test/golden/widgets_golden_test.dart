import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('Widgets Golden Tests', () {
    testGoldens('Common Buttons - Light Theme', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 3,
      )
        ..addScenario(
          'Elevated Button',
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Cart'),
          ),
        )
        ..addScenario(
          'Outlined Button',
          OutlinedButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
        )
        ..addScenario(
          'Text Button',
          TextButton(
            onPressed: () {},
            child: const Text('Learn More'),
          ),
        )
        ..addScenario(
          'Icon Button',
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'buttons_light');
    });

    testGoldens('Common Buttons - Dark Theme', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 3,
      )
        ..addScenario(
          'Elevated Button',
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Cart'),
          ),
        )
        ..addScenario(
          'Outlined Button',
          OutlinedButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
        )
        ..addScenario(
          'Text Button',
          TextButton(
            onPressed: () {},
            child: const Text('Learn More'),
          ),
        )
        ..addScenario(
          'Icon Button',
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.dark()),
      );

      await screenMatchesGolden(tester, 'buttons_dark');
    });

    testGoldens('Form Widgets', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 1,
        widthToHeightRatio: 4,
      )
        ..addScenario(
          'Text Field - Empty',
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
        )
        ..addScenario(
          'Text Field - With Value',
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
        )
        ..addScenario(
          'Text Field - Error',
          const TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: 'Password is required',
              border: OutlineInputBorder(),
            ),
          ),
        )
        ..addScenario(
          'Checkbox',
          CheckboxListTile(
            value: true,
            onChanged: (value) {},
            title: const Text('Remember me'),
          ),
        )
        ..addScenario(
          'Switch',
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text('Enable notifications'),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'form_widgets');
    });

    testGoldens('Loading States', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 2,
      )
        ..addScenario(
          'Circular Progress',
          const Center(
            child: CircularProgressIndicator(),
          ),
        )
        ..addScenario(
          'Linear Progress',
          const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
        )
        ..addScenario(
          'Loading with Text',
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading products...'),
            ],
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'loading_states');
    });

    testGoldens('Empty States', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 1,
        widthToHeightRatio: 1.5,
      )
        ..addScenario(
          'Empty Cart',
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Add items to get started'),
            ],
          ),
        )
        ..addScenario(
          'No Favorites',
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No favorites yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Save your favorite items'),
            ],
          ),
        )
        ..addScenario(
          'No Results',
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No results found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Try different keywords'),
            ],
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'empty_states');
    });

    testGoldens('Error States', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 1,
        widthToHeightRatio: 1.5,
      )
        ..addScenario(
          'Network Error',
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Please check your connection'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Retry'),
              ),
            ],
          ),
        )
        ..addScenario(
          'Generic Error',
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('We could not complete your request'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Try Again'),
              ),
            ],
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'error_states');
    });

    testGoldens('Badge Widgets', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 3,
        widthToHeightRatio: 2,
      )
        ..addScenario(
          'Cart Badge',
          Badge(
            label: const Text('3'),
            child: const Icon(Icons.shopping_cart),
          ),
        )
        ..addScenario(
          'Notification Badge',
          Badge(
            label: const Text('10'),
            child: const Icon(Icons.notifications),
          ),
        )
        ..addScenario(
          'New Badge',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        )
        ..addScenario(
          'Sale Badge',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'SALE',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        )
        ..addScenario(
          'Discount Badge',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '-20%',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'badge_widgets');
    });

    testGoldens('Rating Widgets', (tester) async {
      await loadAppFonts();

      final builder = GoldenBuilder.grid(
        columns: 1,
        widthToHeightRatio: 4,
      )
        ..addScenario(
          '5 Stars',
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, color: Colors.amber),
            ),
          ),
        )
        ..addScenario(
          '3.5 Stars',
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (index) => const Icon(Icons.star, color: Colors.amber)),
              const Icon(Icons.star_half, color: Colors.amber),
              const Icon(Icons.star_border, color: Colors.amber),
            ],
          ),
        )
        ..addScenario(
          'Rating with Text',
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              const Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text('(128 reviews)', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'rating_widgets');
    });
  });
}
