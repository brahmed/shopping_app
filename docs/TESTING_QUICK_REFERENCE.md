# Testing Quick Reference Guide

Quick reference for common testing scenarios in the Shopping App.

## Table of Contents
- [Running Tests](#running-tests)
- [Common Test Patterns](#common-test-patterns)
- [Test Data Helpers](#test-data-helpers)
- [Assertions Cheat Sheet](#assertions-cheat-sheet)
- [Finders Cheat Sheet](#finders-cheat-sheet)
- [Common Issues](#common-issues)

---

## Running Tests

### Quick Commands
```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific file
flutter test test/unit/models/product_model_test.dart

# Specific directory
flutter test test/unit/models/

# By name pattern
flutter test --name "should calculate"

# Watch mode (requires test_runner)
test_runner watch

# Parallel execution
flutter test --concurrency=4
```

### By Category
```bash
# Unit tests
flutter test test/unit/

# Widget tests
flutter test test/widget/

# Integration tests
flutter test test/integration/

# Golden tests (compare)
flutter test test/golden/

# Golden tests (update)
flutter test --update-goldens test/golden/

# E2E tests
flutter test integration_test/
```

---

## Common Test Patterns

### 1. Model Test Pattern

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/your_model.dart';

void main() {
  group('YourModel', () {
    late YourModel testModel;

    setUp(() {
      testModel = YourModel(
        id: '1',
        name: 'Test',
        // ... other fields
      );
    });

    test('should create instance with all fields', () {
      expect(testModel.id, '1');
      expect(testModel.name, 'Test');
    });

    test('should serialize to JSON', () {
      final json = testModel.toJson();
      expect(json['id'], '1');
      expect(json['name'], 'Test');
    });

    test('should deserialize from JSON', () {
      final json = {'id': '1', 'name': 'Test'};
      final model = YourModel.fromJson(json);
      expect(model.id, '1');
    });

    test('should preserve data through round-trip', () {
      final json = testModel.toJson();
      final recreated = YourModel.fromJson(json);
      expect(recreated.id, testModel.id);
      expect(recreated.name, testModel.name);
    });
  });
}
```

### 2. Provider Test Pattern

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/providers/your_provider.dart';

void main() {
  group('YourProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have correct initial state', () {
      final state = container.read(yourProvider);
      expect(state.items, isEmpty);
    });

    test('should update state', () {
      final notifier = container.read(yourProvider.notifier);
      notifier.addItem(testItem);

      final state = container.read(yourProvider);
      expect(state.items.length, 1);
    });

    test('should handle async operations', () async {
      final notifier = container.read(yourProvider.notifier);
      await notifier.loadData();

      final state = container.read(yourProvider);
      expect(state.isLoading, false);
      expect(state.data, isNotEmpty);
    });
  });
}
```

### 3. Widget Test Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/widgets/your_widget.dart';

void main() {
  group('YourWidget', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YourWidget(
              title: 'Test Title',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('should handle tap events', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YourWidget(
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(YourWidget));
      expect(tapped, true);
    });

    testWidgets('should update on state change', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YourWidget(),
          ),
        ),
      );

      // Trigger state change
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump(); // Rebuild

      expect(find.text('Updated'), findsOneWidget);
    });
  });
}
```

### 4. Screen Test Pattern (with Riverpod)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/screens/your_screen.dart';

void main() {
  group('YourScreen', () {
    testWidgets('should render with provider', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: YourScreen(),
          ),
        ),
      );

      expect(find.byType(YourScreen), findsOneWidget);
    });

    testWidgets('should navigate to next screen', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: YourScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Next Screen'), findsOneWidget);
    });

    testWidgets('should display loading state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: YourScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
```

### 5. Integration Test Pattern

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';

void main() {
  group('Feature Flow Integration', () {
    testWidgets('should complete full flow', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      // Step 1
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      expect(find.text('Step 1'), findsOneWidget);

      // Step 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Step 2'), findsOneWidget);

      // Final step
      await tester.tap(find.text('Complete'));
      await tester.pumpAndSettle();
      expect(find.text('Success'), findsOneWidget);
    });
  });
}
```

### 6. Golden Test Pattern

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shopping_app/widgets/your_widget.dart';

void main() {
  group('YourWidget Golden Tests', () {
    testGoldens('renders correctly in light mode', (tester) async {
      await tester.pumpWidgetBuilder(
        YourWidget(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
      );

      await screenMatchesGolden(tester, 'your_widget_light');
    });

    testGoldens('renders correctly in dark mode', (tester) async {
      await tester.pumpWidgetBuilder(
        YourWidget(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
      );

      await screenMatchesGolden(tester, 'your_widget_dark');
    });
  });
}
```

---

## Test Data Helpers

### Create Test Helpers File

`test/helpers/test_data.dart`:

```dart
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/cart_item_model.dart';

class TestData {
  // Products
  static Product createProduct({
    String id = '1',
    String name = 'Test Product',
    double price = 99.99,
    String category = 'electronics',
  }) {
    return Product(
      id: id,
      name: name,
      description: 'Test description for $name',
      price: price,
      imageUrl: 'https://example.com/$id.jpg',
      images: ['https://example.com/$id.jpg'],
      category: category,
      brand: 'TestBrand',
    );
  }

  static Product createDiscountedProduct() {
    return createProduct(
      id: '2',
      name: 'Discounted Product',
      price: 79.99,
    )..originalPrice = 99.99;
  }

  // Cart Items
  static CartItem createCartItem({
    Product? product,
    int quantity = 1,
  }) {
    return CartItem(
      product: product ?? createProduct(),
      quantity: quantity,
    );
  }

  // Lists
  static List<Product> createProductList({int count = 5}) {
    return List.generate(
      count,
      (index) => createProduct(
        id: '$index',
        name: 'Product $index',
      ),
    );
  }
}
```

### Use in Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import '../helpers/test_data.dart';

void main() {
  test('should use test helper', () {
    final product = TestData.createProduct();
    expect(product.name, 'Test Product');

    final discounted = TestData.createDiscountedProduct();
    expect(discounted.hasDiscount, true);

    final products = TestData.createProductList(count: 10);
    expect(products.length, 10);
  });
}
```

---

## Assertions Cheat Sheet

### Basic Assertions
```dart
expect(actual, expected);                    // Equality
expect(actual, isNot(expected));            // Inequality
expect(value, isNull);                       // Null check
expect(value, isNotNull);                    // Not null
expect(value, isTrue);                       // Boolean true
expect(value, isFalse);                      // Boolean false
```

### Numeric Assertions
```dart
expect(value, greaterThan(10));             // > 10
expect(value, greaterThanOrEqualTo(10));    // >= 10
expect(value, lessThan(10));                // < 10
expect(value, lessThanOrEqualTo(10));       // <= 10
expect(value, closeTo(10.0, 0.1));          // ~10.0 ± 0.1
expect(value, inInclusiveRange(1, 10));     // 1 <= value <= 10
```

### String Assertions
```dart
expect(str, contains('substring'));          // Contains
expect(str, startsWith('prefix'));           // Starts with
expect(str, endsWith('suffix'));             // Ends with
expect(str, matches(r'^\d+$'));             // Regex match
expect(str, isEmpty);                        // Empty string
expect(str, isNotEmpty);                     // Not empty
```

### Collection Assertions
```dart
expect(list, isEmpty);                       // Empty list
expect(list, isNotEmpty);                    // Not empty
expect(list, hasLength(5));                  // Length equals 5
expect(list, contains(item));                // Contains item
expect(list, containsAll([1, 2, 3]));       // Contains all
expect(list, everyElement(isPositive));      // All match
expect(list, unorderedEquals([1, 2, 3]));   // Same items, any order
```

### Type Assertions
```dart
expect(value, isA<String>());               // Type check
expect(value, isA<Product>());              // Custom type
expect(value, isInstanceOf<List<int>>());   // Generic type
```

### Exception Assertions
```dart
expect(() => throwError(), throwsException);
expect(() => throwError(), throwsA(isA<CustomException>()));
expect(() => throwError(), throwsArgumentError);
expect(() => success(), returnsNormally);
```

### Async Assertions
```dart
await expectLater(future, completes);
await expectLater(future, completion(equals(42)));
await expectLater(stream, emits(value));
await expectLater(stream, emitsInOrder([1, 2, 3]));
await expectLater(stream, emitsDone);
await expectLater(stream, emitsError(anything));
```

---

## Finders Cheat Sheet

### Basic Finders
```dart
find.text('Hello')                          // Find by text
find.byType(MyWidget)                       // Find by widget type
find.byKey(Key('my-key'))                  // Find by key
find.byIcon(Icons.home)                    // Find by icon
find.byTooltip('Tooltip text')             // Find by tooltip
```

### Advanced Finders
```dart
find.byWidgetPredicate(
  (widget) => widget is Text && widget.data == 'Hello'
)

find.descendant(
  of: find.byType(Container),
  matching: find.text('Child'),
)

find.ancestor(
  of: find.text('Child'),
  matching: find.byType(Container),
)
```

### Semantic Finders
```dart
find.bySemanticsLabel('Login Button')
find.bySemantics(
  label: 'Login',
  hint: 'Tap to login',
)
```

### Multiple Matches
```dart
find.text('Item')                           // Returns Finder
find.text('Item').first                     // First match
find.text('Item').last                      // Last match
find.text('Item').at(2)                     // Third match (0-indexed)
```

### Finder Matchers
```dart
expect(find.text('Hello'), findsOneWidget);     // Exactly 1
expect(find.text('Hello'), findsNothing);       // 0 widgets
expect(find.text('Hello'), findsWidgets);       // 1 or more
expect(find.text('Hello'), findsNWidgets(3));   // Exactly 3
expect(find.text('Hello'), findsAtLeastNWidgets(2)); // 2 or more
```

---

## Common Issues

### Issue 1: "No ProviderScope found"

**Error:**
```
Error: Could not find the correct Provider
```

**Solution:**
```dart
// Wrap in ProviderScope
await tester.pumpWidget(
  ProviderScope(
    child: MaterialApp(home: YourScreen()),
  ),
);
```

### Issue 2: "pumpAndSettle timed out"

**Error:**
```
pumpAndSettle timed out after 100 pumps
```

**Solution:**
```dart
// Option 1: Increase timeout
await tester.pumpAndSettle(const Duration(seconds: 10));

// Option 2: Use pump with duration
await tester.pump(const Duration(milliseconds: 500));

// Option 3: Pump specific number of times
await tester.pump();
await tester.pump(const Duration(milliseconds: 100));
```

### Issue 3: "SharedPreferences not initialized"

**Error:**
```
MissingPluginException
```

**Solution:**
```dart
setUp(() async {
  SharedPreferences.setMockInitialValues({});
});
```

### Issue 4: "Golden test failed"

**Error:**
```
Golden file does not match
```

**Solution:**
```bash
# Regenerate golden files
flutter test --update-goldens test/golden/
```

### Issue 5: "Widget not found"

**Error:**
```
Expected: exactly one matching node
Actual: _WidgetTypeFinder:<zero widgets with type "MyWidget">
```

**Solution:**
```dart
// 1. Ensure widget is built
await tester.pumpAndSettle();

// 2. Use correct finder
find.byType(MyWidget)  // Not find.text() if it's not a Text widget

// 3. Check widget tree
debugPrint(tester.allWidgets.toString());
```

### Issue 6: "Async operation not completing"

**Solution:**
```dart
test('async test', () async {
  // Always await async operations
  await repository.getData();

  // For streams
  await expectLater(
    stream,
    emitsInOrder([1, 2, 3]),
  );

  // For futures
  final result = await future;
  expect(result, expectedValue);
});
```

### Issue 7: "Provider state persists between tests"

**Solution:**
```dart
late ProviderContainer container;

setUp(() {
  container = ProviderContainer();
});

tearDown(() {
  container.dispose(); // Critical!
});
```

### Issue 8: "Can't find element in E2E test"

**Solution:**
```dart
// Use keys for reliable finding
const loginButtonKey = Key('login_button');

// In widget
ElevatedButton(
  key: loginButtonKey,
  // ...
)

// In test
await tester.tap(find.byKey(loginButtonKey));
```

---

## Useful Commands

### Coverage
```bash
# Generate coverage
flutter test --coverage

# View coverage HTML
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Coverage summary
lcov --summary coverage/lcov.info
```

### Test Selection
```bash
# Run tests matching pattern
flutter test --name "should calculate"

# Run tests with tag
flutter test --tags=integration

# Exclude tests with tag
flutter test --exclude-tags=slow

# Plain name match
flutter test --plain-name "exact test name"
```

### Debugging
```bash
# Verbose output
flutter test -v

# Reporter options
flutter test -r compact    # Compact output
flutter test -r expanded   # Detailed output
flutter test -r json       # JSON format
```

---

## Quick Reference Card

Print this section for quick reference:

```
┌─────────────────────────────────────────────┐
│         FLUTTER TESTING QUICK REF            │
├─────────────────────────────────────────────┤
│ RUN TESTS                                    │
│  flutter test                  # All tests   │
│  flutter test --coverage       # + coverage  │
│  flutter test test/unit/       # Unit only   │
│                                              │
│ ASSERTIONS                                   │
│  expect(actual, expected)                    │
│  expect(value, isNull)                       │
│  expect(list, isEmpty)                       │
│  expect(str, contains('text'))               │
│                                              │
│ FINDERS                                      │
│  find.text('Hello')                          │
│  find.byType(Widget)                         │
│  find.byKey(Key('key'))                      │
│  find.byIcon(Icons.home)                     │
│                                              │
│ WIDGET TESTING                               │
│  await tester.pumpWidget(widget)             │
│  await tester.pump()            # Rebuild    │
│  await tester.pumpAndSettle()   # + Settle   │
│  await tester.tap(finder)                    │
│  await tester.enterText(finder, 'text')      │
│                                              │
│ PROVIDER TESTING                             │
│  container = ProviderContainer()             │
│  container.read(provider)                    │
│  container.read(provider.notifier)           │
│  container.dispose()                         │
└─────────────────────────────────────────────┘
```

---

**Version:** 1.0.0
**Last Updated:** 2024
