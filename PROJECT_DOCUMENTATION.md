# Shopping App - Project Documentation

## Table of Contents
1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Architecture](#architecture)
4. [Core Features](#core-features)
5. [Technical Stack](#technical-stack)
6. [State Management](#state-management)
7. [Navigation](#navigation)
8. [Data Models](#data-models)
9. [Screens & UI](#screens--ui)
10. [Localization](#localization)
11. [Assets](#assets)
12. [Getting Started](#getting-started)
13. [Future Enhancements](#future-enhancements)

---

## Overview

**Shopping App** is a modern, cross-platform e-commerce mobile application built with Flutter. The app provides a complete shopping experience with product browsing, search, favorites, cart management, and user authentication features. It demonstrates best practices in Flutter development including clean architecture, state management with Riverpod, and declarative routing with GoRouter.

### Key Highlights
- **Flutter-based**: Cross-platform support (iOS, Android, Web, Windows)
- **Modern State Management**: Uses Riverpod for reactive state management
- **Declarative Routing**: GoRouter for type-safe navigation
- **Multi-language Support**: Built-in localization (English, Arabic, French)
- **Theme Support**: Light and dark mode themes
- **Offline Persistence**: Cart and favorites persist using SharedPreferences

---

## Project Structure

```
shopping_app/
├── android/              # Android-specific files
├── ios/                  # iOS-specific files
├── web/                  # Web-specific files
├── windows/              # Windows-specific files
├── assets/               # App assets
│   ├── fonts/           # Custom fonts (OpenSans family)
│   ├── images/          # Images and SVG files
│   └── languages/       # Localization JSON files
├── lib/                  # Main application code
│   ├── config/          # App configuration
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── constants.dart
│   │   ├── images.dart
│   │   └── localizations/
│   ├── models/          # Data models
│   │   ├── product_model.dart
│   │   ├── cart_item_model.dart
│   │   ├── category_model.dart
│   │   ├── order_model.dart
│   │   └── help_question_model.dart
│   ├── navigation/      # Routing configuration
│   │   └── app_router.dart
│   ├── providers/       # Riverpod state providers
│   │   ├── cart_provider_riverpod.dart
│   │   ├── favorites_provider_riverpod.dart
│   │   ├── products_provider_riverpod.dart
│   │   └── user_provider_riverpod.dart
│   ├── screens/         # UI screens
│   │   ├── cart/
│   │   ├── products/
│   │   ├── profile/
│   │   └── tab_pages/
│   ├── services/        # Business logic & API services
│   │   └── product_service.dart
│   ├── utils/           # Utility functions
│   │   ├── show_bottom_sheet.dart
│   │   ├── token_prefs_helpers.dart
│   │   └── validators.dart
│   ├── widgets/         # Reusable widgets
│   │   ├── app/
│   │   ├── buttons/
│   │   ├── cards/
│   │   └── form/
│   └── main.dart        # App entry point
├── test/                # Unit and widget tests
├── pubspec.yaml         # Project dependencies
└── README.md           # Basic project info
```

**Total Dart Files**: 49 files

---

## Architecture

The application follows a **clean architecture** pattern with clear separation of concerns:

### Layer Structure

1. **Presentation Layer** (`screens/`, `widgets/`)
   - UI components and screens
   - Consumes state from providers
   - Displays data and handles user interactions

2. **Business Logic Layer** (`providers/`, `services/`)
   - State management with Riverpod
   - Business logic and data transformations
   - Mock API services (ProductService)

3. **Data Layer** (`models/`)
   - Data models with JSON serialization
   - Immutable data structures

4. **Configuration Layer** (`config/`)
   - App-wide configurations
   - Theme settings
   - Constants and colors

### Design Patterns Used

- **Provider Pattern**: State management with Riverpod
- **Repository Pattern**: ProductService abstracts data access
- **State Pattern**: UserState, CartState, ProductsState, FavoritesState
- **Factory Pattern**: JSON serialization with factory constructors

---

## Core Features

### 1. Product Browsing
- Browse products by categories (Electronics, Clothing, Shoes, Accessories, Sports, Home & Garden)
- View 15 mock products with detailed information
- Product details include images, pricing, ratings, reviews, sizes, and colors
- Discount badges for products on sale

### 2. Search & Discovery
- Real-time product search functionality
- Search by product name, description, brand, or category
- Filter products by:
  - Category
  - Price range (min/max)
  - Rating
  - Stock availability

### 3. Shopping Cart
- Add products to cart with size/color selection
- Adjust quantity for cart items
- Remove items from cart
- Calculate total price automatically
- Cart persistence using SharedPreferences
- Cart badge showing total item count

### 4. Favorites/Bookmarks
- Add/remove products to favorites
- Toggle favorite status
- Persistent storage of favorites
- Quick access to favorite products
- Favorites badge counter

### 5. User Authentication
- Login functionality
- User registration
- Logout capability
- Token-based authentication storage
- Conditional UI based on login status

### 6. User Profile & Settings
- User profile management
- Settings page with options:
  - Theme switching (Light/Dark mode)
  - Language selection (English, Arabic, French)
  - Notification settings
- Help & Support page
- Contact Us page

### 7. Multi-language Support
- Support for 3 languages:
  - English (en_US)
  - Arabic (ar_TN)
  - French (fr_FR)
- Dynamic locale switching
- Fallback to default locale

### 8. Theme Support
- Light and dark themes
- Material Design 3 principles
- Consistent color scheme
- Custom OpenSans font family with multiple weights

---

## Technical Stack

### Core Framework
- **Flutter SDK**: >=2.15.1 <3.0.0
- **Dart**: Language for Flutter development

### State Management
- **flutter_riverpod**: ^2.3.6 - Reactive state management

### Navigation
- **go_router**: ^9.0.0 - Declarative routing solution

### UI Components & Utilities
- **cupertino_icons**: ^1.0.2 - iOS-style icons
- **cached_network_image**: ^3.2.0 - Image caching and loading
- **flutter_svg**: ^1.0.3 - SVG support

### Localization
- **flutter_localizations**: SDK-provided - Internationalization support

### Data Persistence
- **shared_preferences**: ^2.0.13 - Local key-value storage

### Development Tools
- **flutter_test**: SDK-provided - Testing framework
- **flutter_lints**: ^1.0.0 - Linting rules

---

## State Management

The app uses **Riverpod** for state management with four main providers:

### 1. User Provider (`user_provider_riverpod.dart`)

**Purpose**: Manages user authentication state, theme, and locale

**State Structure** (`UserState`):
```dart
{
  currentUserToken: String?,
  currentLocale: Locale?,
  isLightTheme: bool,
  isUserLogged: bool
}
```

**Actions**:
- `loginUser()` - Authenticate user and save token
- `logoutUser()` - Clear user session
- `changeLocale(Locale)` - Switch app language
- `switchThemeMode()` - Toggle light/dark theme

### 2. Products Provider (`products_provider_riverpod.dart`)

**Purpose**: Manages product catalog and categories

**State Structure** (`ProductsState`):
```dart
{
  products: List<Product>,
  categories: List<Category>,
  isLoading: bool,
  error: String?
}
```

**Actions**:
- `loadProducts()` - Fetch products and categories from service
- `getProductsByCategory(categoryId)` - Filter by category
- `getProductById(id)` - Get single product
- `searchProducts(query)` - Search products
- `filterProducts(...)` - Advanced filtering

### 3. Cart Provider (`cart_provider_riverpod.dart`)

**Purpose**: Manages shopping cart with persistence

**State Structure** (`CartState`):
```dart
{
  items: List<CartItem>,
  isLoading: bool,
  itemCount: int (computed),
  totalItemsCount: int (computed),
  totalAmount: double (computed),
  isEmpty: bool (computed)
}
```

**Actions**:
- `addItem(product, size?, color?)` - Add to cart
- `removeItem(productId)` - Remove from cart
- `updateQuantity(productId, quantity)` - Update item quantity
- `clearCart()` - Empty the cart
- `isInCart(productId)` - Check if product exists
- `getProductQuantity(productId)` - Get item quantity

**Persistence**: Automatically saves/loads cart using SharedPreferences

### 4. Favorites Provider (`favorites_provider_riverpod.dart`)

**Purpose**: Manages user's favorite products

**State Structure** (`FavoritesState`):
```dart
{
  favorites: List<Product>,
  isLoading: bool,
  count: int (computed),
  isEmpty: bool (computed)
}
```

**Actions**:
- `toggleFavorite(product)` - Add/remove favorite
- `addFavorite(product)` - Add to favorites
- `removeFavorite(productId)` - Remove favorite
- `clearFavorites()` - Clear all favorites
- `isFavorite(productId)` - Check favorite status

**Persistence**: Automatically saves/loads favorites using SharedPreferences

---

## Navigation

The app uses **GoRouter** for type-safe, declarative routing.

### Route Configuration (`app_router.dart`)

| Route Path | Screen | Description |
|------------|--------|-------------|
| `/` | TabsManager | Main tabs (Home, Search, Bookmarks, Profile) |
| `/cart` | CartPage | Shopping cart |
| `/product/:id` | ProductDetailPage | Product details (requires Product extra) |
| `/help` | HelpPage | Help & support |
| `/contact` | ContactUsPage | Contact information |
| `/settings` | SettingsPage | App settings |
| `/notification-settings` | NotificationsSettingsPage | Notification preferences |
| `/languages` | LanguagesPage | Language selection |
| `/login` | LoginPage | User login |
| `/register` | RegisterPage | User registration |

### Navigation Features
- **Declarative routing**: Routes defined in a single configuration
- **Type-safe**: Compile-time route checking
- **Extra parameters**: Pass complex objects (e.g., Product)
- **Error handling**: Custom 404 page for unknown routes
- **Deep linking support**: Ready for web and mobile deep links

---

## Data Models

### 1. Product Model (`product_model.dart`)

Core model representing a product in the store.

**Properties**:
- `id` (String) - Unique identifier
- `name` (String) - Product name
- `description` (String) - Detailed description
- `price` (double) - Current price
- `originalPrice` (double?) - Original price (for discounts)
- `imageUrl` (String) - Main product image
- `images` (List<String>) - Additional images
- `category` (String) - Category ID
- `rating` (double) - Average rating (0-5)
- `reviewCount` (int) - Number of reviews
- `inStock` (bool) - Availability status
- `sizes` (List<String>) - Available sizes
- `colors` (List<String>) - Available colors
- `brand` (String) - Brand name

**Computed Properties**:
- `discountPercentage` - Calculated discount %
- `hasDiscount` - Boolean if discount exists

**Methods**:
- `fromJson(Map)` - JSON deserialization
- `toJson()` - JSON serialization

### 2. CartItem Model (`cart_item_model.dart`)

Represents a product in the shopping cart.

**Properties**:
- `product` (Product) - The product reference
- `quantity` (int) - Number of items
- `selectedSize` (String?) - Chosen size
- `selectedColor` (String?) - Chosen color

**Computed Properties**:
- `totalPrice` - product.price × quantity

### 3. Category Model (`category_model.dart`)

Product category representation.

**Properties**:
- `id` (String) - Category identifier
- `name` (String) - Display name
- `iconName` (String) - Material icon name
- `imageUrl` (String) - Category image

### 4. Order Model (`order_model.dart`)

Represents a customer order (structure defined but not actively used in current implementation).

### 5. HelpQuestion Model (`help_question_model.dart`)

FAQ/Help system model (structure defined but not actively used in current implementation).

---

## Screens & UI

### Tab-based Navigation

The app uses a bottom navigation bar with different tabs for logged-in and non-logged-in users.

**Logged-in Users** (4 tabs):
1. **Home** - Product catalog and categories
2. **Search** - Product search and filters
3. **Bookmarks** - Favorite products
4. **Profile** - User settings and account

**Non-logged-in Users** (3 tabs):
1. **Home** - Product catalog and categories
2. **Search** - Product search
3. **Profile** - Login/Register options

### Screen Details

#### 1. Home Page (`home_page_riverpod.dart`)
- Displays categories as horizontal scrollable cards
- Shows product grid/list
- Featured products section
- Quick access to cart
- Category-based filtering

#### 2. Search Page (`search_page_riverpod.dart`)
- Search bar for product queries
- Real-time search results
- Filter options
- Empty state for no results

#### 3. Bookmarks/Favorites Page (`bookmarks_page_riverpod.dart`)
- Grid of favorite products
- Remove from favorites option
- Empty state with SVG illustration
- Quick add to cart

#### 4. Profile Page (`profile_page.dart`)
- User information (if logged in)
- Settings access
- Help & Support
- Contact Us
- Login/Logout actions

#### 5. Cart Page (`cart_page.dart`)
- List of cart items
- Quantity adjusters
- Item removal
- Price breakdown
- Total amount
- Checkout button
- Empty cart state

#### 6. Product Detail Page (`product_detail_page.dart`)
- Product image gallery
- Product information
- Price and discount display
- Size/color selectors
- Add to cart button
- Add to favorites
- Reviews and ratings

#### 7. Authentication Pages
- **Login Page** (`login_page.dart`) - User login form
- **Register Page** (`register_page.dart`) - User registration form

#### 8. Settings Pages
- **Settings Page** (`settings_page.dart`) - Main settings hub
- **Languages Page** (`languages_page.dart`) - Language selection
- **Notifications Settings** (`notifications_settings_page.dart`) - Notification preferences

#### 9. Support Pages
- **Help Page** (`help_page.dart`) - FAQ and help resources
- **Contact Us Page** (`contact_us_page.dart`) - Contact information

### Reusable Widgets

The app includes a comprehensive widget library:

**Buttons**:
- `AppFilledButton` - Primary filled buttons
- `AppOutlinedButton` - Outlined buttons

**Cards**:
- `ProductCard` - Product display card
- `CategoryCard` - Category display card
- `AppCard` - Generic card container
- `AppListTile` - Custom list tile
- `AppPageContainer` - Page wrapper

**Form Components**:
- `AppTextField` - Custom text input
- `AuthRedirectionText` - Login/Register navigation
- `GestureText` - Clickable text

**Other**:
- `AppLogo` - Application logo
- `PageAppBar` - Custom app bar
- `ArrowIcon` - Navigation arrow

---

## Localization

### Supported Locales
1. **English** (en_US) - Default
2. **Arabic** (ar_TN) - Right-to-left support
3. **French** (fr_FR)

### Implementation

**Locale Files**: Located in `assets/languages/`
- `en.json` - English translations
- `ar.json` - Arabic translations
- `fr.json` - French translations

**Current Implementation**: Basic localization structure is in place with welcome text. The app is ready for full translation expansion.

**Locale Resolution**:
- Matches device locale to supported locales
- Falls back to English if locale not supported
- User can manually change language in settings

**Integration**:
```dart
// In main.dart
localizationsDelegates: [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
]
```

---

## Assets

### Fonts
**OpenSans Font Family** with 5 weights:
- Light (300)
- Regular (400)
- Medium (500)
- SemiBold (600)
- Bold (700)

### Images
- `logo.png` - App logo
- `empty-box.svg` - Empty cart illustration
- `empty-shelf.svg` - Empty favorites illustration

### Languages
- JSON files for each supported locale

---

## Getting Started

### Prerequisites
- Flutter SDK >=2.15.1 <3.0.0
- Dart SDK (included with Flutter)
- IDE (VS Code, Android Studio, or IntelliJ)
- Platform-specific tools:
  - **Android**: Android Studio, Android SDK
  - **iOS**: Xcode, CocoaPods (macOS only)
  - **Web**: Chrome
  - **Windows**: Visual Studio 2019 or later

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd shopping_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # On connected device/emulator
   flutter run

   # On specific platform
   flutter run -d chrome       # Web
   flutter run -d windows      # Windows
   flutter run -d <device-id>  # Mobile device
   ```

4. **Build for production**
   ```bash
   flutter build apk           # Android APK
   flutter build ios           # iOS
   flutter build web           # Web
   flutter build windows       # Windows
   ```

### Project Setup
- **No backend required**: Uses mock data from ProductService
- **No API keys needed**: All functionality works offline
- **Persistent storage**: Cart and favorites auto-save locally

---

## Future Enhancements

### Suggested Features

1. **Backend Integration**
   - Replace ProductService mock with real API calls
   - User authentication with OAuth/JWT
   - Order management system
   - Payment gateway integration

2. **Enhanced Features**
   - Product reviews and ratings submission
   - Order history and tracking
   - Wishlist sharing
   - Push notifications
   - Social login (Google, Facebook)
   - Product recommendations
   - Advanced filters (brand, price range sliders)

3. **UI/UX Improvements**
   - Animations and transitions
   - Skeleton loaders
   - Pull-to-refresh
   - Infinite scroll for products
   - Product comparison
   - Image zoom and gallery

4. **Technical Improvements**
   - Unit and widget tests
   - Integration tests
   - Error handling and logging
   - Analytics integration
   - Crashlytics
   - Performance monitoring
   - CI/CD pipeline

5. **E-commerce Features**
   - Coupon/promo codes
   - Multiple addresses
   - Saved payment methods
   - Product variants
   - Inventory management
   - Guest checkout

6. **Accessibility**
   - Screen reader support
   - High contrast themes
   - Font scaling
   - Keyboard navigation

---

## Code Quality & Best Practices

### Architecture Strengths
- ✅ Clean separation of concerns
- ✅ Immutable state objects
- ✅ Reactive state management with Riverpod
- ✅ Type-safe navigation
- ✅ Reusable widget library
- ✅ Consistent code structure
- ✅ JSON serialization/deserialization

### Code Style
- Follows Flutter/Dart conventions
- Uses `flutter_lints` for code quality
- Meaningful variable and function names
- Organized imports

### Performance Considerations
- Cached network images for better performance
- Efficient state updates with `copyWith`
- Lazy loading of favorites and cart
- Minimal rebuilds with Riverpod

---

## Summary

The **Shopping App** is a well-architected Flutter e-commerce application that demonstrates modern Flutter development practices. It features a complete shopping experience with product browsing, search, cart management, favorites, and user authentication. The app is built with scalability in mind, using Riverpod for state management and GoRouter for navigation.

The current implementation uses mock data, making it perfect for:
- Learning Flutter development
- Prototyping e-commerce ideas
- Portfolio projects
- Foundation for production apps

With 49 Dart files, comprehensive state management, and a beautiful UI, this project serves as an excellent reference for building production-ready Flutter applications.

---

**Document Version**: 1.0
**Last Updated**: 2025-11-21
**Project Version**: 1.0.0
