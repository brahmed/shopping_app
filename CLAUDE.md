# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based e-commerce shopping application with offline-first architecture, supporting multiple locales (English, French, Arabic). The app uses Riverpod for state management, GoRouter for navigation, and Drift for local database persistence.

## Development Commands

### Building and Running
```bash
# Run the app
flutter run

# Run on specific device
flutter run -d <device_id>

# Build for release
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

### Code Generation
```bash
# Generate code for Drift database and other build_runner dependencies
flutter pub run build_runner build

# Watch mode (auto-regenerates on changes)
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

### Localization
```bash
# Generate localization files (after modifying .arb files in lib/l10n/)
flutter gen-l10n
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test category
flutter test test/unit/              # Unit tests only
flutter test test/widget/            # Widget tests only
flutter test test/integration/       # Integration tests only
flutter test test/golden/            # Golden tests only
flutter test integration_test/       # E2E tests only

# Run specific test file
flutter test test/unit/models/product_model_test.dart

# Run with coverage
flutter test --coverage

# Generate and view HTML coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Update golden files (after intentional UI changes)
flutter test --update-goldens test/golden/
```

### Linting and Analysis
```bash
# Analyze code for issues
flutter analyze

# Format code
flutter format lib/ test/
```

## Architecture

### Offline-First Strategy

The app implements a comprehensive offline-first architecture:

1. **Data Flow**: Local cache → Remote API (when online) → Update cache
2. **Repository Pattern**: All data access goes through repositories that handle offline/online logic
3. **Sync Manager** (`lib/services/sync_manager.dart`): Coordinates data synchronization
   - Auto-syncs every 15 minutes when online
   - Auto-syncs when connectivity is restored
   - Manages sync callbacks for all entity types
4. **Offline Queue** (`lib/services/offline_queue_service.dart`): Queues write operations when offline
   - Stores operations in `PendingOperations` table
   - Processes queue when back online
   - Supports retry logic for failed operations (max 3 attempts)
   - Exponential backoff: 2s, 4s, 8s delays
5. **Connectivity Service** (`lib/services/connectivity_service.dart`): Monitors network status using `connectivity_plus` package

### Database (Drift)

The app uses Drift (SQLite) for local persistence with these key tables:
- **Products, Categories**: Catalog data with cache timestamps
- **Orders, Addresses, Reviews, Wishlists, Subscriptions**: User-generated data with `isSynced` flags
- **CartItems, Favorites, SaveForLater, RecentlyViewed**: Local-only user data
- **PendingOperations**: Queue for offline write operations
- **SyncMetadata**: Tracks last sync times per entity type
- **Notifications, Coupons**: App data

Database singleton: `AppDatabase()` in `lib/data/local/database/app_database.dart`

After schema changes:
1. Update table definitions in `app_database.dart`
2. Increment `schemaVersion` in `AppDatabase` class
3. Add migration logic in `onUpgrade` callback
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`

### State Management (Riverpod)

The app uses Riverpod 2.x with these provider patterns:
- **StateNotifierProvider**: For mutable state (e.g., `productsProvider`, `cartProvider`, `userProvider`)
- **Provider**: For services and repositories (e.g., `connectivityServiceProvider`, `productsRepositoryProvider`)
- **FutureProvider**: For async data loading
- **StreamProvider**: For real-time data streams (e.g., `pendingOperationsCountProvider`)

All providers are in `lib/providers/` directory.

**Important**: This project uses Riverpod extensively. Do not suggest switching to built-in Flutter state management solutions.

### Data Layer Structure

```
lib/data/
├── local/               # Drift database and local data sources
│   ├── database/
│   │   ├── app_database.dart       # Table definitions
│   │   └── app_database.g.dart     # Generated code
│   ├── products_local_data_source.dart
│   └── orders_local_data_source.dart
└── remote/              # API client and remote data sources
    ├── api_client.dart              # Dio-based HTTP client
    ├── products_remote_data_source.dart
    └── orders_remote_data_source.dart
```

### Repository Pattern

Repositories (`lib/repositories/`) implement the offline-first strategy:
1. Check local cache first (fast response)
2. Determine if cache is stale (default: 1 hour for products)
3. If online and cache stale, fetch from remote API
4. Update cache with fresh data
5. Fall back to cache on network errors
6. Throw `OfflineException` if offline with no cache

Example: `ProductsRepository.getProducts()` in `lib/repositories/products_repository.dart:28`

**Cache Strategy**:
- Products cache duration: 1 hour
- Categories: Cached indefinitely (refresh in background when available)
- User data (orders, addresses): Relies on `isSynced` flag

### Navigation (GoRouter)

Routes defined in `lib/navigation/app_router.dart` with route constants in `AppRoutes` class.

To navigate:
```dart
context.go(AppRoutes.productDetail, extra: product);
context.push(AppRoutes.cart);
```

When passing data between routes, use the `extra` parameter with typed models.

**Route Structure**:
- Main tabs: `/` (home, search, bookmarks, profile)
- Product detail: `/product/:id`
- Cart: `/cart`
- Orders: `/orders`, `/order-details`
- Authentication: `/login`, `/register`
- Settings: `/settings`, `/languages`, `/notification-settings`
- Profile: `/help`, `/contact`

### Localization (i18n)

Supported locales: English (en_US), French (fr_FR), Arabic (ar_TN)

**Workflow**:
1. Add translations to `lib/l10n/app_en.arb` (template file)
2. Add translations to `app_fr.arb` and `app_ar.arb`
3. Run `flutter gen-l10n` to generate localization classes
4. Access in code: `AppLocalizations.of(context).keyName`

Locale switching handled by `UserProvider` which persists locale preference via SharedPreferences.

Configuration in `l10n.yaml`:
- Template: `app_en.arb`
- Output class: `AppLocalizations`
- Non-nullable getters

### Theme Management

Light/dark theme support via `AppTheme` class in `lib/config/app_theme.dart`.

Theme features:
- Custom color scheme (not using `ColorScheme.fromSeed()`)
- OpenSans font family (weights: 300-700)
- Separate light/dark text themes
- Zero elevation app bars
- Theme state managed by `UserProvider` with persistence

Access theme: `Theme.of(context)` or `AppTheme.light()` / `AppTheme.dark()`

## Key Services

### ConnectivityService
Monitors network status with real-time updates via stream. Used throughout repositories to determine offline/online behavior.

**API**:
- `currentStatus`: Current connectivity status
- `statusStream`: Stream of status changes
- `isOnline`: Boolean check
- `checkConnection()`: Force connectivity check

### SyncManager
Coordinates all sync operations across entity types.

**API**:
- `syncAll()`: Sync all registered entities
- `syncEntity(type, callback)`: Sync specific entity
- `registerSyncCallback(callback)`: Register entity for auto-sync
- `getPendingCount()`: Get pending operations count
- `retryFailedOperations()`: Retry failed queue items

Auto-sync triggers:
- Every 15 minutes when online
- When connectivity restored
- Manual trigger via `forceSync()`

### OfflineQueueService
Handles queuing write operations when offline.

**Operation Types**:
- CREATE, UPDATE, DELETE
- Stores: entity type, entity ID, endpoint, HTTP method, payload

**API**:
- `addOperation()`: Add to queue
- `processQueue()`: Process pending operations
- `getPendingCount()`: Count pending
- `getFailedCount()`: Count failed
- `retryFailedOperations()`: Retry failed with pending status

## Testing

Test structure (100+ test files):
- `test/unit/`: Unit tests for models (14), providers (14), services, utils
- `test/widget/`: Widget tests for components (15) and screens (17)
- `test/integration/`: Integration tests for complete user flows (9)
- `test/golden/`: Golden file tests for UI consistency (5)
- `integration_test/`: E2E tests for complete journeys (9)

**Coverage Targets**:
- Models: 100%
- Providers: 95%+
- Services: 90%+
- Overall: 90%+

See `test/README.md` for comprehensive testing documentation.

## Common Workflows

### Adding a New Feature with Offline Support

1. **Define table schema** in `app_database.dart` if persistence needed
2. **Run code generation**: `flutter pub run build_runner build`
3. **Create local data source** in `lib/data/local/`
4. **Create remote data source** in `lib/data/remote/`
5. **Create repository** implementing offline-first pattern
6. **Create provider** in `lib/providers/`
7. **Register sync callback** in `SyncManager` if entity needs syncing
8. **Create UI screens** in `lib/screens/`
9. **Add routes** to `lib/navigation/app_router.dart`
10. **Add localization** keys to all `.arb` files and run `flutter gen-l10n`
11. **Write tests** (unit, widget, integration)

### Adding Translations

1. Add new keys to `lib/l10n/app_en.arb` (template)
2. Add translations to `app_fr.arb` and `app_ar.arb`
3. Run `flutter gen-l10n`
4. Use in code: `AppLocalizations.of(context).newKey`

### Using the Offline Queue

For user-generated write operations:
```dart
await offlineQueueService.addOperation(
  operationType: 'CREATE',
  entityType: 'order',
  entityId: order.id,
  endpoint: '/orders',
  method: 'POST',
  payload: order.toJson(),
);
```

The queue will automatically process when online.

## API Integration

The API client is configured in `lib/data/remote/api_client.dart` with:
- Base URL: `https://api.yourshop.com/v1` (update as needed)
- 30-second timeouts for all requests
- Automatic JWT token injection from local storage
- Offline detection via interceptor
- Custom exception types: `NetworkException`, `OfflineException`, `TimeoutException`, `ServerException`

Authentication tokens stored via `lib/utils/token_prefs_helpers.dart` using SharedPreferences.

## Project Coding Standards

This project follows specific Flutter/Dart best practices defined in `rules.md`:

### Code Style
- **Line length**: 80 characters or fewer
- **Naming**: `PascalCase` for classes, `camelCase` for members/variables/functions, `snake_case` for files
- **Functions**: Keep short (< 20 lines) with single purpose
- **Null safety**: Avoid `!` operator unless value is guaranteed non-null
- **Const constructors**: Use `const` for widgets wherever possible to reduce rebuilds
- **Logging**: Use `dart:developer`'s `log()` instead of `print()`

### Code Generation
After modifying files that use code generation (Drift database, JSON serialization):
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Testing Standards
- Follow Arrange-Act-Assert pattern
- Target 90%+ test coverage
- Write unit tests for domain logic, data layer, state management
- Write widget tests for UI components
- Write integration tests for user flows
- Use `package:mockito` or `mocktail` for mocks (prefer fakes/stubs)

### Documentation
- Use `///` for doc comments on all public APIs
- First sentence should be concise summary ending with period
- Explain "why" not "what" in comments
- Use backticks for code references
- Include code samples for complex APIs

## Important Notes

- **Write operations**: All user-generated create/update/delete should use offline queue
- **Cache-only data**: Products and categories update local DB directly (no sync flags)
- **isSynced flag**: Tracks whether user data has been synced to server
- **Exception handling**: Always handle `OfflineException` in UI with appropriate messaging
- **Accessibility**: Text scaling supports up to 2.0x (see `main.dart:62-73`)
- **Semantic labels**: Required for all interactive widgets
- **Composition**: Prefer composition over inheritance when building widgets
- **Widget size**: Break large `build()` methods into smaller private Widget classes
- **List performance**: Use `ListView.builder` for long lists
- **Async operations**: Always use `async`/`await` with proper error handling
