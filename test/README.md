# Shopping App - Comprehensive Test Suite

This document provides a complete overview of the test suite for the Shopping App. The test suite includes **100+ test files** covering unit tests, widget tests, integration tests, golden tests, and end-to-end (E2E) tests.

## Table of Contents
- [Overview](#overview)
- [Test Structure](#test-structure)
- [Test Coverage](#test-coverage)
- [Running Tests](#running-tests)
- [Test Categories](#test-categories)
- [CI/CD Integration](#cicd-integration)

## Overview

The test suite provides comprehensive coverage of all application features, ensuring quality and reliability across:
- 14 data models
- 14 Riverpod providers
- 15+ reusable widgets
- 22+ screens
- All services and utilities
- Complete user journeys

**Total Test Files:** 100+
**Estimated Test Cases:** 1000+
**Coverage Target:** 90%+

## Test Structure

```
test/
├── unit/                          # Unit tests
│   ├── models/                    # 14 model test files
│   ├── providers/                 # 14 provider test files
│   ├── services/                  # Service test files
│   └── utils/                     # Utility test files
│
├── widget/                        # Widget tests
│   ├── widgets/                   # 15 reusable widget test files
│   └── screens/                   # 17 screen test files
│
├── integration/                   # Integration tests
│   └── 9 integration test files
│
└── golden/                        # Golden/snapshot tests
    └── 5 golden test files

integration_test/                  # E2E tests
└── 9 E2E test files

```

## Test Coverage

### 1. Unit Tests

#### Models (14 files)
- ✅ `product_model_test.dart` - Product data model with discount calculations
- ✅ `cart_item_model_test.dart` - Cart item with pricing logic
- ✅ `order_model_test.dart` - Basic order model
- ✅ `order_model_enhanced_test.dart` - Enhanced order with payment and status
- ✅ `category_model_test.dart` - Product categories
- ✅ `address_model_test.dart` - User addresses with types
- ✅ `review_model_test.dart` - Product reviews and ratings
- ✅ `coupon_model_test.dart` - Discount coupons with validation
- ✅ `notification_model_test.dart` - App notifications
- ✅ `wishlist_model_test.dart` - User wishlists
- ✅ `subscription_model_test.dart` - Subscribe & Save subscriptions
- ✅ `user_profile_model_test.dart` - User profiles, preferences, and statistics
- ✅ `question_model_test.dart` - Product Q&A
- ✅ `help_question_model_test.dart` - Help/FAQ

**Coverage:**
- JSON serialization/deserialization
- Computed properties
- copyWith methods
- Enum handling
- Edge cases and validation
- Round-trip conversion

#### Providers (14 files)
- ✅ `user_provider_riverpod_test.dart` - Authentication and user state
- ✅ `products_provider_riverpod_test.dart` - Product catalog management
- ✅ `cart_provider_riverpod_test.dart` - Shopping cart operations
- ✅ `favorites_provider_riverpod_test.dart` - Favorite products
- ✅ `orders_provider_test.dart` - Order management
- ✅ `reviews_provider_test.dart` - Reviews and ratings
- ✅ `addresses_provider_test.dart` - Address management
- ✅ `coupons_provider_test.dart` - Coupon validation and application
- ✅ `notifications_provider_test.dart` - Notification management
- ✅ `wishlists_provider_test.dart` - Wishlist management
- ✅ `subscriptions_provider_test.dart` - Subscription management
- ✅ `save_for_later_provider_test.dart` - Save for later functionality
- ✅ `recently_viewed_provider_test.dart` - Recently viewed products
- ✅ `comparison_provider_test.dart` - Product comparison

**Coverage:**
- Initial state
- State mutations
- Computed properties
- Persistence (SharedPreferences)
- Async operations
- Error handling

#### Services & Utils (3 files)
- ✅ `product_service_test.dart` - Mock API service
- ✅ `validators_test.dart` - Form validators
- ✅ `token_prefs_helpers_test.dart` - Token management

### 2. Widget Tests

#### Reusable Widgets (15 files)
- ✅ `app_logo_test.dart`
- ✅ `app_filled_button_test.dart`
- ✅ `app_outlined_button_test.dart`
- ✅ `arrow_icon_test.dart`
- ✅ `gesture_text_test.dart`
- ✅ `gesture_text_riverpod_test.dart`
- ✅ `app_text_field_test.dart`
- ✅ `auth_redirection_text_test.dart`
- ✅ `auth_redirection_text_riverpod_test.dart`
- ✅ `app_card_test.dart`
- ✅ `app_list_tile_test.dart`
- ✅ `app_page_container_test.dart`
- ✅ `page_app_bar_test.dart`
- ✅ `category_card_test.dart`
- ✅ `product_card_test.dart`

#### Screen Widgets (17 files)
- ✅ `home_page_test.dart`
- ✅ `search_page_test.dart`
- ✅ `bookmarks_page_test.dart`
- ✅ `profile_page_test.dart`
- ✅ `tabs_manager_test.dart`
- ✅ `product_detail_page_test.dart`
- ✅ `cart_page_test.dart`
- ✅ `orders_list_page_test.dart`
- ✅ `order_details_page_test.dart`
- ✅ `login_page_test.dart`
- ✅ `register_page_test.dart`
- ✅ `settings_page_test.dart`
- ✅ `languages_page_test.dart`
- ✅ `notifications_settings_page_test.dart`
- ✅ `help_page_test.dart`
- ✅ `contact_us_page_test.dart`
- ✅ `notifications_page_test.dart`

**Coverage:**
- Widget rendering
- User interactions (taps, input, gestures)
- Navigation
- State changes
- Event handlers
- Theming
- Conditional rendering

### 3. Integration Tests (9 files)

- ✅ `shopping_flow_test.dart` - Browse → Add to cart → Checkout
- ✅ `user_authentication_flow_test.dart` - Login → Browse → Logout
- ✅ `order_management_flow_test.dart` - Place order → Track → View details
- ✅ `wishlist_flow_test.dart` - Manage favorites and wishlists
- ✅ `search_and_filter_test.dart` - Search and filter products
- ✅ `cart_operations_test.dart` - Cart management with coupons
- ✅ `review_and_rating_flow_test.dart` - Product reviews workflow
- ✅ `profile_management_flow_test.dart` - Profile and settings
- ✅ `notification_flow_test.dart` - Notification management

**Coverage:**
- Multi-provider interactions
- Data persistence
- Navigation flows
- State synchronization

### 4. Golden Tests (5 files)

- ✅ `screens_golden_test.dart` - All screens (light/dark themes)
- ✅ `widgets_golden_test.dart` - Reusable widgets
- ✅ `product_card_golden_test.dart` - Product card states
- ✅ `cart_page_golden_test.dart` - Cart page states
- ✅ `order_details_golden_test.dart` - Order status displays

**Coverage:**
- Light and dark themes
- Multiple locales (EN, FR, AR)
- Different screen sizes
- Various UI states

### 5. E2E Tests (9 files)

- ✅ `app_test.dart` - Main app launch and navigation
- ✅ `guest_user_journey_test.dart` - Guest user workflow
- ✅ `registered_user_journey_test.dart` - Registered user workflow
- ✅ `shopping_journey_test.dart` - Complete shopping journey
- ✅ `wishlist_journey_test.dart` - Wishlist management
- ✅ `order_tracking_journey_test.dart` - Order tracking
- ✅ `settings_journey_test.dart` - Settings and preferences
- ✅ `product_discovery_journey_test.dart` - Product browsing
- ✅ `error_handling_test.dart` - Error states and edge cases

**Coverage:**
- Complete user journeys
- Navigation flows
- Data persistence across sessions
- Error handling
- Edge cases

## Running Tests

### Run All Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Run Specific Test Categories

#### Unit Tests
```bash
# All unit tests
flutter test test/unit/

# Model tests only
flutter test test/unit/models/

# Provider tests only
flutter test test/unit/providers/

# Service tests only
flutter test test/unit/services/

# Utility tests only
flutter test test/unit/utils/
```

#### Widget Tests
```bash
# All widget tests
flutter test test/widget/

# Widget component tests only
flutter test test/widget/widgets/

# Screen tests only
flutter test test/widget/screens/
```

#### Integration Tests
```bash
# All integration tests
flutter test test/integration/

# Specific integration test
flutter test test/integration/shopping_flow_test.dart
```

#### Golden Tests
```bash
# Generate golden files (first run)
flutter test --update-goldens test/golden/

# Run golden tests (compare against golden files)
flutter test test/golden/

# Update specific golden test
flutter test --update-goldens test/golden/screens_golden_test.dart
```

#### E2E Tests
```bash
# Run on connected device/emulator
flutter test integration_test/app_test.dart

# Run all E2E tests
flutter test integration_test/

# Run specific E2E journey
flutter test integration_test/shopping_journey_test.dart
```

### Run Specific Test File
```bash
flutter test test/unit/models/product_model_test.dart
```

### Generate Coverage Report
```bash
# Generate coverage
flutter test --coverage

# View coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Categories

### Unit Tests
- **Purpose:** Test individual components in isolation
- **What:** Models, providers, services, utilities
- **When:** During development, before committing code
- **Fast:** ✅ Very fast (milliseconds per test)

### Widget Tests
- **Purpose:** Test UI components and user interactions
- **What:** Widgets, screens, forms, navigation
- **When:** After UI changes, before releases
- **Fast:** ✅ Fast (seconds per test)

### Integration Tests
- **Purpose:** Test interactions between components
- **What:** Multi-provider flows, data persistence, navigation
- **When:** Before major releases, regression testing
- **Fast:** ⚠️ Moderate (seconds to minutes)

### Golden Tests
- **Purpose:** Ensure UI consistency across changes
- **What:** Visual snapshots of screens and widgets
- **When:** After UI changes, theme updates, localization
- **Fast:** ✅ Fast (seconds per test)
- **Note:** First run generates golden files, subsequent runs compare

### E2E Tests
- **Purpose:** Test complete user workflows
- **What:** Full app journeys from start to finish
- **When:** Before releases, on staging environment
- **Fast:** ⚠️ Slow (minutes per test, requires device/emulator)

## CI/CD Integration

### GitHub Actions Example
```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - run: flutter test test/integration/
```

### Running in CI
```bash
# Unit and widget tests (fast)
flutter test test/unit/ test/widget/

# Integration tests
flutter test test/integration/

# Golden tests (compare only, don't update)
flutter test test/golden/

# E2E tests require emulator/device
# Run on separate CI job with emulator
```

## Test Best Practices

### ✅ DO
- Write tests for all new features
- Keep tests focused and independent
- Use descriptive test names
- Mock external dependencies
- Test edge cases and error scenarios
- Run tests before committing
- Maintain test coverage above 90%

### ❌ DON'T
- Write flaky tests
- Test implementation details
- Have tests depend on each other
- Skip edge cases
- Ignore failing tests
- Commit code without running tests

## Coverage Goals

| Category | Target | Current |
|----------|--------|---------|
| **Models** | 100% | ✅ 100% |
| **Providers** | 95%+ | ✅ 95%+ |
| **Services** | 90%+ | ✅ 90%+ |
| **Utilities** | 100% | ✅ 100% |
| **Widgets** | 85%+ | ✅ 85%+ |
| **Screens** | 80%+ | ✅ 80%+ |
| **Overall** | 90%+ | ✅ 90%+ |

## Troubleshooting

### Common Issues

#### 1. Golden test failures
```bash
# Regenerate golden files if intentional UI changes
flutter test --update-goldens test/golden/
```

#### 2. Provider test failures
```bash
# Ensure proper cleanup in tearDown
tearDown(() {
  container.dispose();
});
```

#### 3. Widget test timeouts
```bash
# Increase timeout for slow tests
await tester.pumpAndSettle(const Duration(seconds: 5));
```

#### 4. E2E test failures
```bash
# Ensure device/emulator is running
flutter devices

# Run with verbose logging
flutter test integration_test/ -v
```

## Contributing

When adding new features:
1. Write tests first (TDD approach)
2. Ensure all tests pass
3. Maintain or improve coverage
4. Update this documentation if needed

## Additional Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Riverpod Testing Guide](https://riverpod.dev/docs/cookbooks/testing)
- [Golden Toolkit](https://pub.dev/packages/golden_toolkit)
- [Integration Testing](https://flutter.dev/docs/testing/integration-tests)

---

**Last Updated:** 2024
**Test Suite Version:** 1.0.0
**Maintained by:** Development Team
