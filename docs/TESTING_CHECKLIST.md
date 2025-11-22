# Testing Checklist

Use this checklist when adding new features or making changes to ensure comprehensive test coverage.

## Pre-Development Checklist

- [ ] **Understand Requirements**
  - [ ] Clear acceptance criteria defined
  - [ ] Edge cases identified
  - [ ] Error scenarios documented

- [ ] **Review Existing Code**
  - [ ] Checked similar features for patterns
  - [ ] Identified affected components
  - [ ] Listed dependencies to mock

- [ ] **Plan Test Strategy**
  - [ ] Determined test types needed (unit/widget/integration)
  - [ ] Identified test data requirements
  - [ ] Listed happy paths and edge cases

---

## Feature Development Checklist

### ✅ Step 1: Models (if adding/modifying data models)

- [ ] **Unit Tests Created**
  - [ ] Constructor tests with all fields
  - [ ] Constructor tests with default values
  - [ ] `toJson()` serialization tests
  - [ ] `fromJson()` deserialization tests
  - [ ] Round-trip conversion test
  - [ ] Computed property tests
  - [ ] `copyWith()` method tests (if applicable)
  - [ ] Enum handling tests (if applicable)
  - [ ] Edge case tests (null, empty, invalid data)

**Test File Location:** `test/unit/models/{model_name}_test.dart`

**Example Checklist:**
```
Product Model:
✓ Constructor with required fields
✓ Constructor with optional fields
✓ discountPercentage getter
✓ hasDiscount getter
✓ toJson conversion
✓ fromJson parsing
✓ Round-trip preservation
✓ Null handling for optional fields
✓ Numeric type conversion (int/double)
```

---

### ✅ Step 2: Services/Repositories

- [ ] **Unit Tests Created**
  - [ ] Success case tests for all methods
  - [ ] Error handling tests
  - [ ] Network delay simulation
  - [ ] Data validation tests
  - [ ] Mock data tests
  - [ ] Async operation tests

**Test File Location:** `test/unit/services/{service_name}_test.dart`

---

### ✅ Step 3: Providers/State Management

- [ ] **Unit Tests Created**
  - [ ] Initial state test
  - [ ] All state mutation tests (add, update, delete, clear)
  - [ ] Computed property tests
  - [ ] Persistence tests (SharedPreferences if applicable)
  - [ ] Async operation tests
  - [ ] Error handling tests
  - [ ] State consistency tests
  - [ ] `setUp()` creates fresh ProviderContainer
  - [ ] `tearDown()` disposes container

**Test File Location:** `test/unit/providers/{provider_name}_test.dart`

**Example Checklist:**
```
Cart Provider:
✓ Initial state (empty cart)
✓ Add item to cart
✓ Remove item from cart
✓ Update item quantity
✓ Clear cart
✓ Total amount calculation
✓ Item count calculation
✓ Persistence to SharedPreferences
✓ Load from SharedPreferences
✓ Multiple items handling
```

---

### ✅ Step 4: Utilities/Helpers

- [ ] **Unit Tests Created**
  - [ ] Valid input tests
  - [ ] Invalid input tests
  - [ ] Null/empty input tests
  - [ ] Edge case tests
  - [ ] All validation rules tested

**Test File Location:** `test/unit/utils/{util_name}_test.dart`

---

### ✅ Step 5: Widgets

- [ ] **Widget Tests Created**
  - [ ] Rendering test
  - [ ] Required props test
  - [ ] Optional props test
  - [ ] Default values test
  - [ ] Callback/event handler tests
  - [ ] User interaction tests (tap, input, etc.)
  - [ ] Conditional rendering tests
  - [ ] State change tests
  - [ ] Theme integration tests
  - [ ] Accessibility tests

**Test File Location:** `test/widget/widgets/{widget_name}_test.dart`

**Example Checklist:**
```
ProductCard Widget:
✓ Renders with product data
✓ Displays product name
✓ Displays product price
✓ Shows discount badge when discounted
✓ Shows "Out of Stock" when not in stock
✓ Handles tap event
✓ Shows favorite icon when favorited
✓ Renders placeholder for missing image
✓ Applies correct theme colors
```

---

### ✅ Step 6: Screens/Pages

- [ ] **Widget Tests Created**
  - [ ] Initial render test
  - [ ] Loading state test
  - [ ] Success state test
  - [ ] Error state test
  - [ ] Empty state test
  - [ ] Navigation tests
  - [ ] Form submission tests (if applicable)
  - [ ] Input validation tests (if applicable)
  - [ ] User interaction workflow tests
  - [ ] ProviderScope wrapping

**Test File Location:** `test/widget/screens/{screen_name}_test.dart`

**Example Checklist:**
```
Login Screen:
✓ Renders login form
✓ Email field exists
✓ Password field exists
✓ Login button exists
✓ Shows validation error for invalid email
✓ Shows validation error for short password
✓ Calls onSubmit when form valid
✓ Navigates to home on success
✓ Shows loading indicator during login
✓ Shows error message on failure
✓ "Forgot password" link works
✓ "Register" navigation works
```

---

### ✅ Step 7: Integration Tests

- [ ] **Integration Tests Created**
  - [ ] Complete user flow tested end-to-end
  - [ ] Multi-screen navigation tested
  - [ ] Provider interactions tested
  - [ ] Data persistence tested
  - [ ] State synchronization tested
  - [ ] Error scenarios tested

**Test File Location:** `test/integration/{flow_name}_test.dart`

**Example Checklist:**
```
Shopping Flow:
✓ Browse products by category
✓ View product details
✓ Add product to cart
✓ Update cart quantity
✓ Apply coupon code
✓ Proceed to checkout
✓ Verify order created
✓ Verify cart cleared after order
```

---

### ✅ Step 8: Golden Tests (if UI component)

- [ ] **Golden Tests Created**
  - [ ] Light theme snapshot
  - [ ] Dark theme snapshot
  - [ ] Different screen sizes (if responsive)
  - [ ] Different locales (if localized)
  - [ ] Different states (empty, loading, error, success)

**Test File Location:** `test/golden/{component_name}_golden_test.dart`

**Commands:**
```bash
# Generate golden files
flutter test --update-goldens test/golden/{component_name}_golden_test.dart

# Verify golden files
flutter test test/golden/{component_name}_golden_test.dart
```

---

### ✅ Step 9: E2E Tests (for major features)

- [ ] **E2E Tests Created**
  - [ ] Complete user journey tested
  - [ ] Success path tested
  - [ ] Error paths tested
  - [ ] Edge cases tested
  - [ ] Platform-specific behavior tested

**Test File Location:** `integration_test/{journey_name}_test.dart`

**Example Checklist:**
```
Complete Purchase Journey:
✓ App launches successfully
✓ User logs in
✓ User browses products
✓ User adds items to cart
✓ User applies discount code
✓ User proceeds to checkout
✓ User completes payment
✓ Order confirmation displayed
✓ Order appears in order history
```

---

## Code Quality Checklist

- [ ] **Test Coverage**
  - [ ] Coverage meets target (90%+)
  - [ ] All new code has tests
  - [ ] Critical paths fully covered
  - [ ] Edge cases covered

- [ ] **Test Quality**
  - [ ] Tests are independent (no shared state)
  - [ ] Tests have descriptive names
  - [ ] Tests follow AAA pattern (Arrange-Act-Assert)
  - [ ] No test dependencies on execution order
  - [ ] No hardcoded delays (`Future.delayed()`)
  - [ ] Proper `setUp()` and `tearDown()` usage

- [ ] **Code Review**
  - [ ] Tests reviewed for completeness
  - [ ] Tests reviewed for clarity
  - [ ] No commented-out tests
  - [ ] No skipped tests without reason

---

## Pre-Commit Checklist

- [ ] **All Tests Pass**
  ```bash
  flutter test
  ```

- [ ] **Coverage Maintained**
  ```bash
  flutter test --coverage
  # Verify coverage hasn't decreased
  ```

- [ ] **No Linting Errors**
  ```bash
  flutter analyze
  ```

- [ ] **Format Code**
  ```bash
  flutter format .
  ```

- [ ] **Golden Tests Updated (if UI changed)**
  ```bash
  flutter test --update-goldens test/golden/
  ```

---

## Pull Request Checklist

- [ ] **Documentation**
  - [ ] README updated if needed
  - [ ] API documentation updated
  - [ ] Test documentation updated
  - [ ] CHANGELOG updated

- [ ] **Tests**
  - [ ] All new features have tests
  - [ ] All bug fixes have regression tests
  - [ ] Integration tests added for new flows
  - [ ] Golden tests updated for UI changes

- [ ] **CI/CD**
  - [ ] All CI checks pass
  - [ ] Coverage requirements met
  - [ ] No test flakiness observed

- [ ] **Code Quality**
  - [ ] No TODO comments without issues
  - [ ] No debugging code left behind
  - [ ] No console.log/print statements
  - [ ] Proper error handling in place

---

## Bug Fix Checklist

When fixing a bug:

- [ ] **Regression Test Created**
  - [ ] Test reproduces the bug
  - [ ] Test fails without the fix
  - [ ] Test passes with the fix

- [ ] **Root Cause Tests**
  - [ ] Tests cover the root cause
  - [ ] Tests cover similar scenarios
  - [ ] Tests prevent future regressions

- [ ] **Related Tests Updated**
  - [ ] Existing tests updated if behavior changed
  - [ ] Golden tests regenerated if UI changed

---

## Refactoring Checklist

When refactoring code:

- [ ] **Tests Still Pass**
  - [ ] All existing tests pass without changes
  - [ ] Coverage maintained or improved

- [ ] **Test Updates (if needed)**
  - [ ] Tests updated to match new API
  - [ ] Tests still test behavior, not implementation
  - [ ] No tests deleted without good reason

- [ ] **New Tests (if needed)**
  - [ ] New edge cases covered
  - [ ] New public APIs tested

---

## Performance Testing Checklist

- [ ] **Test Execution Time**
  - [ ] Unit tests run in < 30 seconds
  - [ ] Widget tests run in < 2 minutes
  - [ ] Integration tests run in < 5 minutes
  - [ ] Full suite runs in < 10 minutes

- [ ] **Optimization**
  - [ ] Slow tests identified and optimized
  - [ ] Unnecessary `pumpAndSettle()` removed
  - [ ] Mocks used instead of real services
  - [ ] Parallel execution enabled

---

## Accessibility Testing Checklist

- [ ] **Widget Tests Include**
  - [ ] Semantic labels tested
  - [ ] Screen reader compatibility
  - [ ] Keyboard navigation (web/desktop)
  - [ ] Proper focus management

---

## Localization Testing Checklist

- [ ] **Multi-Language Tests**
  - [ ] English (en_US) tested
  - [ ] Arabic (ar_TN) tested (RTL)
  - [ ] French (fr_FR) tested
  - [ ] Golden tests include all locales

---

## Platform Testing Checklist

- [ ] **Platform-Specific Tests**
  - [ ] iOS-specific behavior tested
  - [ ] Android-specific behavior tested
  - [ ] Web-specific behavior tested
  - [ ] Desktop-specific behavior tested

---

## Test Maintenance Checklist

### Monthly Review

- [ ] **Test Suite Health**
  - [ ] Remove obsolete tests
  - [ ] Update deprecated test utilities
  - [ ] Refactor duplicate test code
  - [ ] Update test dependencies

- [ ] **Coverage Review**
  - [ ] Identify coverage gaps
  - [ ] Add tests for uncovered code
  - [ ] Remove tests for deleted code

- [ ] **Performance Review**
  - [ ] Identify slow tests
  - [ ] Optimize or parallelize slow tests
  - [ ] Remove unnecessary delays

---

## Quick Reference

### Minimum Required Tests for:

**New Model:**
- Constructor tests (2-3 tests)
- JSON serialization (2 tests)
- Computed properties (1+ tests)
- **Total: 5-7 tests minimum**

**New Provider:**
- Initial state (1 test)
- CRUD operations (4+ tests)
- Computed properties (2+ tests)
- **Total: 7-10 tests minimum**

**New Widget:**
- Rendering (1 test)
- Props/callbacks (3+ tests)
- User interactions (2+ tests)
- **Total: 6-8 tests minimum**

**New Screen:**
- States (4 tests: loading, success, error, empty)
- Navigation (2+ tests)
- User workflow (3+ tests)
- **Total: 9-12 tests minimum**

**New Feature Flow:**
- Integration test (1+ tests)
- E2E test (1+ tests)
- **Total: 2-4 tests minimum**

---

## Example: Complete Feature Checklist

### Feature: Add Product Review

#### ✅ Models
- [x] Review model tests (review_model_test.dart)
  - [x] Constructor with all fields
  - [x] JSON serialization
  - [x] Helpful count calculations

#### ✅ Providers
- [x] Reviews provider tests (reviews_provider_test.dart)
  - [x] Add review
  - [x] Get reviews by product
  - [x] Mark review helpful
  - [x] Calculate average rating

#### ✅ Widgets
- [x] ReviewCard widget tests (review_card_test.dart)
  - [x] Displays review data
  - [x] Shows rating stars
  - [x] Helpful button works
- [x] ReviewForm widget tests (review_form_test.dart)
  - [x] Form validation
  - [x] Star rating selection
  - [x] Image upload

#### ✅ Screens
- [x] Reviews screen tests (reviews_screen_test.dart)
  - [x] Lists all reviews
  - [x] Filters by rating
  - [x] Loads more reviews
  - [x] Shows empty state

#### ✅ Integration
- [x] Review flow test (review_flow_test.dart)
  - [x] View product → Read reviews → Add review → See new review

#### ✅ Golden
- [x] Review card golden test
  - [x] Light theme
  - [x] Dark theme
  - [x] With/without images

#### ✅ E2E
- [x] Complete review journey
  - [x] Browse → Buy → Review → Submit

**Total Tests: 28**
**Coverage: 95%**
**Status: ✅ Complete**

---

**Print this checklist and use it for every feature!**

**Version:** 1.0.0
**Last Updated:** 2024
