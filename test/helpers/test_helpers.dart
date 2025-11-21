import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Test helper utilities for widget testing
class TestHelpers {
  /// Create a testable widget with all necessary providers
  static Widget createTestableWidget({
    required Widget child,
    List<Override> overrides = const [],
    GoRouter? router,
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  /// Create a testable widget with navigation support
  static Widget createTestableWidgetWithRouter({
    required Widget child,
    required GoRouter router,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  /// Pump and settle with custom duration
  static Future<void> pumpAndSettleWithDuration(
    WidgetTester tester, {
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    await tester.pump(duration);
    await tester.pumpAndSettle();
  }

  /// Find widget by key
  static Finder findByKey(String key) {
    return find.byKey(Key(key));
  }

  /// Find widget by text
  static Finder findByText(String text) {
    return find.text(text);
  }

  /// Find widget by type
  static Finder findByType<T>() {
    return find.byType(T);
  }

  /// Verify widget exists
  static void verifyWidgetExists(Finder finder) {
    expect(finder, findsOneWidget);
  }

  /// Verify widget does not exist
  static void verifyWidgetDoesNotExist(Finder finder) {
    expect(finder, findsNothing);
  }

  /// Verify text exists
  static void verifyTextExists(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Tap on widget
  static Future<void> tapWidget(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Enter text in field
  static Future<void> enterText(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Scroll until visible
  static Future<void> scrollUntilVisible(
    WidgetTester tester,
    Finder finder,
    Finder scrollable, {
    double delta = 100,
  }) async {
    await tester.scrollUntilVisible(
      finder,
      delta,
      scrollable: scrollable,
    );
    await tester.pumpAndSettle();
  }

  /// Wait for condition
  static Future<void> waitForCondition(
    WidgetTester tester,
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
    Duration checkInterval = const Duration(milliseconds: 100),
  }) async {
    final endTime = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(endTime)) {
      if (condition()) return;
      await tester.pump(checkInterval);
    }
    throw TimeoutException('Condition not met within $timeout');
  }

  /// Verify loading indicator
  static void verifyLoadingIndicator() {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  /// Verify no loading indicator
  static void verifyNoLoadingIndicator() {
    expect(find.byType(CircularProgressIndicator), findsNothing);
  }

  /// Verify error message
  static void verifyErrorMessage(String message) {
    expect(find.text(message), findsOneWidget);
  }

  /// Verify snackbar
  static void verifySnackbar(String message) {
    expect(find.text(message), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }
}

/// Custom timeout exception
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}
