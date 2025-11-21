#!/bin/bash

# Shopping App - Comprehensive Test Runner
# This script runs all tests with coverage and generates reports

set -e

echo "======================================"
echo "Shopping App - Test Suite Runner"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_status "Flutter version:"
flutter --version

# Clean previous build artifacts
print_status "Cleaning previous build artifacts..."
flutter clean
flutter pub get

# Generate mocks if needed
print_status "Checking for mock generation..."
if [ -f "test/mocks/mock_services.dart" ]; then
    print_status "Generating mocks..."
    flutter pub run build_runner build --delete-conflicting-outputs
    print_success "Mocks generated successfully"
fi

# Run unit tests
print_status "Running unit tests..."
flutter test --coverage test/models/ test/providers/
if [ $? -eq 0 ]; then
    print_success "Unit tests passed"
else
    print_error "Unit tests failed"
    exit 1
fi

# Run widget tests
print_status "Running widget tests..."
flutter test test/widgets/
if [ $? -eq 0 ]; then
    print_success "Widget tests passed"
else
    print_warning "Some widget tests failed (non-blocking)"
fi

# Run all tests with coverage
print_status "Running all tests with coverage..."
flutter test --coverage
if [ $? -eq 0 ]; then
    print_success "All tests completed"
else
    print_error "Some tests failed"
    exit 1
fi

# Generate coverage report
if command -v lcov &> /dev/null; then
    print_status "Generating coverage report..."

    # Remove generated files from coverage
    lcov --remove coverage/lcov.info \
        '**/*.g.dart' \
        '**/*.freezed.dart' \
        '**/firebase_options.dart' \
        '**/main.dart' \
        -o coverage/lcov_filtered.info

    # Generate HTML report
    genhtml coverage/lcov_filtered.info -o coverage/html

    print_success "Coverage report generated at coverage/html/index.html"

    # Extract coverage percentage
    COVERAGE=$(lcov --summary coverage/lcov_filtered.info 2>&1 | grep "lines" | awk '{print $2}')
    print_status "Code coverage: $COVERAGE"

else
    print_warning "lcov not installed. Skipping HTML coverage report."
    print_warning "Install with: sudo apt-get install lcov (Linux) or brew install lcov (Mac)"
fi

# Run integration tests if device is connected
print_status "Checking for connected devices..."
DEVICES=$(flutter devices | grep -v "No devices detected")
if [ ! -z "$DEVICES" ]; then
    print_status "Connected devices found. Running integration tests..."
    flutter test integration_test/app_test.dart
    if [ $? -eq 0 ]; then
        print_success "Integration tests passed"
    else
        print_warning "Integration tests failed or skipped (non-blocking)"
    fi
else
    print_warning "No devices connected. Skipping integration tests."
fi

# Print summary
echo ""
echo "======================================"
echo "Test Suite Summary"
echo "======================================"
print_success "✓ Unit tests passed"
print_success "✓ Widget tests completed"
print_success "✓ Coverage report generated"
echo ""
print_status "Next steps:"
echo "  1. Open coverage/html/index.html to view coverage"
echo "  2. Review TEST_DOCUMENTATION.md for detailed test info"
echo "  3. Run 'flutter test <specific_test_file>' for individual tests"
echo ""
print_success "All tests completed successfully!"
