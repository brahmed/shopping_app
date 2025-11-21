# Shopping App - Complete Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture & Design Patterns](#architecture--design-patterns)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Features](#features)
6. [State Management](#state-management)
7. [Navigation System](#navigation-system)
8. [Data Models](#data-models)
9. [Providers (State Notifiers)](#providers-state-notifiers)
10. [Services](#services)
11. [UI Components](#ui-components)
12. [Screens](#screens)
13. [Configuration](#configuration)
14. [Setup & Installation](#setup--installation)
15. [Code Statistics](#code-statistics)
16. [API Reference](#api-reference)

---

## Project Overview

**Shopping App** is a modern, fully-functional e-commerce mobile application built with Flutter. It provides a complete shopping experience with product browsing, cart management, favorites, user authentication, and multi-language support.

### Key Highlights
- **100% Modern Architecture**: Migrated to Riverpod state management and GoRouter navigation
- **Multi-language Support**: English, French, and Arabic
- **Persistent Storage**: Cart and favorites persist across sessions
- **Mock Backend**: Complete product service with 15 sample products across 6 categories
- **Material 3 Design**: Modern UI with light/dark theme support
- **Type-Safe Navigation**: Declarative routing with GoRouter
- **Clean Code**: Zero deprecated APIs, 100% migrated architecture

### Version
- **Version**: 1.0.0
- **Flutter SDK**: >=2.15.1 <3.0.0
- **Total Lines of Code**: ~4,900 lines
- **Total Dart Files**: 49 files

---

## Architecture & Design Patterns

### 1. **MVVM Pattern (Model-View-ViewModel)**
The app follows the MVVM architecture pattern:
- **Models**: Represent data structures (Product, CartItem, Order, etc.)
- **Views**: Flutter widgets (screens and UI components)
- **ViewModels**: Riverpod StateNotifiers manage business logic and state

### 2. **State Management: Riverpod**
- Uses **StateNotifier** pattern for mutable state management
- All state is **immutable** with `copyWith()` methods
- Providers expose state to the UI layer
- Reactive UI updates with `ref.watch()` and `ref.read()`

### 3. **Separation of Concerns**
```
lib/
├── models/          # Data models (Plain Dart classes)
├── providers/       # State management (Riverpod StateNotifiers)
├── services/        # Business logic & API calls
├── screens/         # UI screens/pages
├── widgets/         # Reusable UI components
├── navigation/      # Routing configuration
├── config/          # App configuration & constants
└── utils/           # Helper functions & utilities
```

### 4. **Design Principles**
- **Single Responsibility**: Each class has one responsibility
- **Dependency Injection**: Providers inject dependencies
- **Immutability**: State objects are immutable
- **Composition over Inheritance**: Widgets are composed, not extended

---

## Technology Stack

### Core Technologies
```yaml
Flutter SDK: ">=2.15.1 <3.0.0"
Language: Dart
```

### Dependencies

#### State Management & Navigation
- **flutter_riverpod: ^2.3.6** - Modern state management
- **go_router: ^9.0.0** - Declarative routing

#### UI & Assets
- **cached_network_image: ^3.2.0** - Image caching
- **flutter_svg: ^1.0.3** - SVG support
- **cupertino_icons: ^1.0.2** - iOS-style icons

#### Data Persistence
- **shared_preferences: ^2.0.13** - Local storage for cart & settings

#### Localization
- **flutter_localizations** - Multi-language support

### Dev Dependencies
- **flutter_test** - Testing framework
- **flutter_lints: ^1.0.0** - Code quality

---

## Project Structure

```
lib/
├── main.dart                          # App entry point
│
├── config/                            # Configuration files
│   ├── app_theme.dart                # Theme definitions (light/dark)
│   ├── colors.dart                   # Color palette
│   ├── constants.dart                # App constants
│   ├── images.dart                   # Image asset paths
│   └── localizations/
│       └── application_localizations.dart
│
├── models/                            # Data models
│   ├── product_model.dart            # Product entity
│   ├── cart_item_model.dart          # Cart item entity
│   ├── category_model.dart           # Category entity
│   ├── order_model.dart              # Order entity
│   └── help_question_model.dart      # FAQ entity
│
├── providers/                         # Riverpod state management
│   ├── cart_provider_riverpod.dart   # Cart state management
│   ├── products_provider_riverpod.dart # Products state
│   ├── favorites_provider_riverpod.dart # Favorites state
│   └── user_provider_riverpod.dart   # User/auth state
│
├── services/                          # Business logic layer
│   └── product_service.dart          # Product API service (mock)
│
├── navigation/                        # Routing configuration
│   └── app_router.dart               # GoRouter setup
│
├── screens/                           # App screens
│   ├── tab_pages/                    # Main tab pages
│   │   ├── tabs_manager.dart         # Bottom nav controller
│   │   ├── home_page.dart            # Home screen
│   │   ├── search_page.dart          # Search screen
│   │   ├── bookmarks_page.dart       # Favorites screen
│   │   └── profile_page.dart         # Profile screen
│   ├── cart/
│   │   └── cart_page.dart            # Shopping cart
│   ├── products/
│   │   └── product_detail_page.dart  # Product details
│   └── profile/
│       ├── authentication/
│       │   ├── login_page.dart       # Login screen
│       │   └── register_page.dart    # Registration
│       ├── settings/
│       │   ├── settings_page.dart    # Settings
│       │   ├── languages_page.dart   # Language selection
│       │   └── notifications_settings_page.dart
│       ├── help_page.dart            # Help/FAQ
│       └── contact_us_page.dart      # Contact form
│
├── widgets/                           # Reusable components
│   ├── buttons/
│   │   ├── app_filled_button.dart    # Primary button
│   │   └── app_outlined_button.dart  # Secondary button
│   ├── cards/
│   │   ├── product_card.dart         # Product card widget
│   │   ├── category_card.dart        # Category card
│   │   ├── app_card.dart             # Generic card
│   │   ├── app_list_tile.dart        # List item
│   │   └── app_page_container.dart   # Page wrapper
│   ├── form/
│   │   ├── app_text_field.dart       # Custom text input
│   │   ├── auth_redirection_text.dart # Auth link
│   │   └── gesture_text.dart         # Clickable text
│   ├── app/
│   │   └── app_logo.dart             # App logo
│   ├── page_app_bar.dart             # Custom app bar
│   └── arrow_icon.dart               # Navigation arrow
│
└── utils/                             # Utility functions
    ├── validators.dart               # Form validation
    ├── token_prefs_helpers.dart      # Token storage
    └── show_bottom_sheet.dart        # Bottom sheet helper
```

---

## Features

### Core Features

#### 1. **Product Catalog**
- Browse 15 products across 6 categories
- Product categories: Electronics, Clothing, Shoes, Accessories, Sports, Home & Garden
- Product details with images, ratings, reviews
- Price display with discount calculations
- Stock availability indicators

#### 2. **Shopping Cart**
- Add products to cart with size/color selection
- Quantity management
- Real-time total calculation
- Persistent storage (survives app restarts)
- Visual cart badge with item count

#### 3. **Favorites/Bookmarks**
- Add/remove products from favorites
- Persistent favorites list
- Quick access to saved items
- Heart icon toggle

#### 4. **Search & Filter**
- Text-based product search
- Filter by category
- Filter by price range
- Sort by price (low-to-high, high-to-low)
- Real-time search results

#### 5. **User Authentication**
- Login functionality
- Registration with form validation
- Logout capability
- Session persistence
- Protected routes for logged-in users

#### 6. **Settings & Preferences**
- **Theme Toggle**: Switch between light/dark mode
- **Language Selection**: English, French, Arabic (3 locales)
- **Notification Settings**: 4 notification categories
- Profile management

#### 7. **Multi-language Support**
- **Supported Languages**:
  - English (en-US)
  - Français (fr-FR)
  - العربية (ar-TN)
- Dynamic locale switching
- Locale persistence

#### 8. **Navigation**
- Bottom navigation bar (4 tabs for logged-in, 3 for guests)
- Type-safe routing with GoRouter
- Deep linking support
- Route parameters for product details

---

## State Management

### Riverpod Architecture

The app uses **Riverpod** with the **StateNotifier** pattern for state management.

### Core Concepts

#### 1. **Immutable State**
All state classes are immutable and provide `copyWith()` methods:

```dart
class CartState {
  final List<CartItem> items;
  final bool isLoading;

  const CartState({
    this.items = const [],
    this.isLoading = false,
  });

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
```

#### 2. **StateNotifier**
Business logic is encapsulated in StateNotifier classes:

```dart
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState()) {
    _loadCart();
  }

  void addItem(Product product, {String? size, String? color}) {
    // Creates new state
    state = state.copyWith(items: newItems);
  }
}
```

#### 3. **Provider Declaration**
```dart
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
```

#### 4. **Consuming State in UI**
```dart
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    // Use cartState.items, cartState.totalAmount, etc.
  }
}
```

### State Providers

#### **CartProvider** (`cart_provider_riverpod.dart`)
**State**: `CartState`
- `items`: List<CartItem>
- `isLoading`: bool
- `itemCount`: int (computed)
- `totalItemsCount`: int (computed)
- `totalAmount`: double (computed)
- `isEmpty`: bool (computed)

**Methods**:
- `addItem(Product, size, color)` - Add product to cart
- `removeItem(productId)` - Remove product
- `updateQuantity(productId, quantity, size, color)` - Update quantity
- `clearCart()` - Empty cart
- `isInCart(productId)` - Check if in cart
- `getProductQuantity(productId)` - Get quantity

**Persistence**: Uses SharedPreferences to save/load cart

#### **ProductsProvider** (`products_provider_riverpod.dart`)
**State**: `ProductsState`
- `products`: List<Product>
- `categories`: List<Category>
- `isLoading`: bool
- `error`: String?

**Methods**:
- `loadProducts()` - Fetch products from service
- `loadCategories()` - Fetch categories

#### **FavoritesProvider** (`favorites_provider_riverpod.dart`)
**State**: `FavoritesState`
- `favoriteProducts`: List<Product>
- `isLoading`: bool

**Methods**:
- `toggleFavorite(Product)` - Add/remove favorite
- `isFavorite(productId)` - Check if favorited
- `clearFavorites()` - Remove all favorites

**Persistence**: Uses SharedPreferences

#### **UserProvider** (`user_provider_riverpod.dart`)
**State**: `UserState`
- `currentUserToken`: String?
- `currentLocale`: Locale?
- `isLightTheme`: bool
- `isUserLogged`: bool

**Methods**:
- `loginUser()` - Authenticate user
- `logoutUser()` - Sign out
- `changeLocale(Locale)` - Switch language
- `switchThemeMode()` - Toggle light/dark theme

---

## Navigation System

### GoRouter Configuration

The app uses **GoRouter** for declarative, type-safe routing.

#### Route Structure

**File**: `lib/navigation/app_router.dart`

```dart
class AppRoutes {
  static const String tabs = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String bookmarks = '/bookmarks';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String productDetail = '/product/:id';
  static const String help = '/help';
  static const String contact = '/contact';
  static const String settings = '/settings';
  static const String notificationSettings = '/notification-settings';
  static const String languages = '/languages';
  static const String login = '/login';
  static const String register = '/register';
}
```

#### Navigation Usage

```dart
// Navigate to cart
context.push(AppRoutes.cart);

// Navigate to product detail with extra data
context.push(
  AppRoutes.productDetail,
  extra: product,
);

// Replace current route
context.go(AppRoutes.tabs);

// Go back
context.pop();
```

#### Routes Configuration

| Route | Path | Screen | Extra Data |
|-------|------|--------|------------|
| Tabs | `/` | TabsManager | - |
| Cart | `/cart` | CartPage | - |
| Product Detail | `/product/:id` | ProductDetailPage | Product object |
| Login | `/login` | LoginPage | - |
| Register | `/register` | RegisterPage | - |
| Settings | `/settings` | SettingsPage | - |
| Languages | `/languages` | LanguagesPage | - |
| Help | `/help` | HelpPage | - |
| Contact | `/contact` | ContactUsPage | - |
| Notifications | `/notification-settings` | NotificationsSettingsPage | - |

---

## Data Models

### 1. Product Model

**File**: `lib/models/product_model.dart`

```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final List<String> sizes;
  final List<String> colors;
  final String brand;

  // Computed properties
  double get discountPercentage;
  bool get hasDiscount;

  // JSON serialization
  factory Product.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

**Example**:
```dart
Product(
  id: '1',
  name: 'Wireless Headphones',
  price: 199.99,
  originalPrice: 249.99,
  category: 'electronics',
  rating: 4.5,
  reviewCount: 328,
  brand: 'TechSound',
  sizes: [],
  colors: ['Black', 'Silver', 'Blue'],
)
```

### 2. CartItem Model

**File**: `lib/models/cart_item_model.dart`

```dart
class CartItem {
  final Product product;
  int quantity;
  final String? selectedSize;
  final String? selectedColor;

  // Computed property
  double get totalPrice => product.price * quantity;

  // JSON serialization
  factory CartItem.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

### 3. Category Model

**File**: `lib/models/category_model.dart`

```dart
class Category {
  final String id;
  final String name;
  final String iconName;
  final String imageUrl;

  factory Category.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

### 4. Order Model

**File**: `lib/models/order_model.dart`

```dart
enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String deliveryAddress;
  final String? trackingNumber;

  String get statusString;

  factory Order.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

---

## Providers (State Notifiers)

### Complete Provider Reference

#### 1. CartProvider
- **File**: `lib/providers/cart_provider_riverpod.dart`
- **Purpose**: Manage shopping cart state
- **Persistence**: SharedPreferences
- **Key**: 'shopping_cart'

**State Properties**:
```dart
items: List<CartItem>
isLoading: bool
itemCount: int          // Number of unique items
totalItemsCount: int    // Total quantity
totalAmount: double     // Total price
isEmpty: bool
```

**Methods**:
```dart
addItem(Product product, {String? size, String? color})
removeItem(String productId)
updateQuantity(String productId, int quantity, {String? size, String? color})
clearCart()
isInCart(String productId) -> bool
getProductQuantity(String productId) -> int
```

#### 2. ProductsProvider
- **File**: `lib/providers/products_provider_riverpod.dart`
- **Purpose**: Manage product catalog state
- **Data Source**: ProductService

**State Properties**:
```dart
products: List<Product>
categories: List<Category>
isLoading: bool
error: String?
```

**Methods**:
```dart
loadProducts()
loadCategories()
getProductById(String id) -> Product?
getProductsByCategory(String category) -> List<Product>
```

#### 3. FavoritesProvider
- **File**: `lib/providers/favorites_provider_riverpod.dart`
- **Purpose**: Manage user favorites
- **Persistence**: SharedPreferences
- **Key**: 'favorites'

**State Properties**:
```dart
favoriteProducts: List<Product>
isLoading: bool
```

**Methods**:
```dart
toggleFavorite(Product product)
isFavorite(String productId) -> bool
clearFavorites()
```

#### 4. UserProvider
- **File**: `lib/providers/user_provider_riverpod.dart`
- **Purpose**: Manage user authentication and preferences

**State Properties**:
```dart
currentUserToken: String?
currentLocale: Locale?
isLightTheme: bool
isUserLogged: bool
```

**Methods**:
```dart
loginUser()
logoutUser()
changeLocale(Locale locale)
switchThemeMode()
```

---

## Services

### ProductService

**File**: `lib/services/product_service.dart`

Mock service that simulates backend API calls.

#### Methods

```dart
Future<List<Category>> getCategories()
```
Returns 6 categories: Electronics, Clothing, Shoes, Accessories, Sports, Home & Garden

```dart
Future<List<Product>> getProducts()
```
Returns 15 sample products with complete details

```dart
Future<Product?> getProductById(String id)
```
Fetches a single product by ID

#### Sample Data

**15 Products**:
1. Wireless Headphones - $199.99 (Electronics)
2. Smart Watch Pro - $299.99 (Electronics)
3. Wireless Mouse - $29.99 (Electronics)
4. Cotton T-Shirt - $24.99 (Clothing)
5. Denim Jeans - $59.99 (Clothing)
6. Hooded Jacket - $89.99 (Clothing)
7. Running Shoes - $119.99 (Shoes)
8. Casual Sneakers - $79.99 (Shoes)
9. Leather Wallet - $49.99 (Accessories)
10. Sunglasses - $89.99 (Accessories)
11. Backpack - $69.99 (Accessories)
12. Yoga Mat - $39.99 (Sports)
13. Dumbbell Set - $149.99 (Sports)
14. Coffee Maker - $79.99 (Home)
15. Table Lamp - $44.99 (Home)

**6 Categories**:
- Electronics
- Clothing
- Shoes
- Accessories
- Sports
- Home & Garden

---

## UI Components

### Button Components

#### AppButtonFilled
- **File**: `lib/widgets/buttons/app_filled_button.dart`
- **Purpose**: Primary action button
- **Props**: `text: String`, `onClick: VoidCallback`

#### AppButtonOutlined
- **File**: `lib/widgets/buttons/app_outlined_button.dart`
- **Purpose**: Secondary action button
- **Props**: `text: String`, `onClick: VoidCallback`

### Card Components

#### ProductCard
- **File**: `lib/widgets/cards/product_card.dart`
- **Purpose**: Display product in grid/list
- **Features**:
  - Product image with caching
  - Price with discount badge
  - Rating stars
  - Add to cart button
  - Favorite toggle
- **Props**: `product: Product`

#### CategoryCard
- **File**: `lib/widgets/cards/category_card.dart`
- **Purpose**: Display category tile
- **Props**: `category: Category`, `onTap: VoidCallback`

#### AppCard
- **File**: `lib/widgets/cards/app_card.dart`
- **Purpose**: Generic card container
- **Props**: `child: Widget`, `margin`, `padding`, `radius`

#### AppListTile
- **File**: `lib/widgets/cards/app_list_tile.dart`
- **Purpose**: List item with icon and arrow
- **Props**: `text`, `iconData`, `onTap`, `margin`, `padding`

### Form Components

#### AppTextField
- **File**: `lib/widgets/form/app_text_field.dart`
- **Purpose**: Custom text input field
- **Features**:
  - Validation support
  - Focus node management
  - Obscure text for passwords
  - Keyboard type configuration
- **Props**: `controller`, `focusNode`, `label`, `hintText`, `validator`, `obscureText`, `keyboardType`

#### AuthRedirectionText
- **File**: `lib/widgets/form/auth_redirection_text.dart`
- **Purpose**: "Don't have an account? Sign up" style link
- **Props**: `staticText`, `clickableText`, `redirectionRouteName`

#### GestureText
- **File**: `lib/widgets/form/gesture_text.dart`
- **Purpose**: Clickable text widget
- **Props**: `text`, `onTap`, `textStyle`

### Other Components

#### AppLogo
- **File**: `lib/widgets/app/app_logo.dart`
- **Purpose**: Display app branding

#### PageAppBar
- **File**: `lib/widgets/page_app_bar.dart`
- **Purpose**: Consistent app bar across screens
- **Props**: `title: String`

#### ArrowIcon
- **File**: `lib/widgets/arrow_icon.dart`
- **Purpose**: Navigation arrow for list items

---

## Screens

### Main Tab Pages

#### 1. TabsManager
- **File**: `lib/screens/tab_pages/tabs_manager.dart`
- **Purpose**: Bottom navigation controller
- **Features**:
  - PageView for smooth transitions
  - Dynamic tabs based on login status
  - Logged in: Home, Search, Bookmarks, Profile (4 tabs)
  - Guest: Home, Search, Profile (3 tabs)

#### 2. HomePage
- **File**: `lib/screens/tab_pages/home_page.dart`
- **Type**: `ConsumerStatefulWidget`
- **Features**:
  - Category grid
  - Product grid
  - Filter by category
  - Cart button with badge
  - Pull-to-refresh

#### 3. SearchPage
- **File**: `lib/screens/tab_pages/search_page.dart`
- **Type**: `ConsumerStatefulWidget`
- **Features**:
  - Search bar with real-time filtering
  - Category filter chips
  - Price range filter
  - Sort options (price low-to-high, high-to-low)
  - Product grid results

#### 4. BookmarksPage (Favorites)
- **File**: `lib/screens/tab_pages/bookmarks_page.dart`
- **Type**: `ConsumerWidget`
- **Features**:
  - Display favorited products
  - Remove from favorites
  - Empty state message
  - Navigate to product details

#### 5. ProfilePage
- **File**: `lib/screens/tab_pages/profile_page.dart`
- **Type**: `ConsumerWidget`
- **Features**:
  - User info (if logged in)
  - Settings navigation
  - Help & Contact
  - Login/Logout
  - Dynamic UI based on auth state

### Product Screens

#### ProductDetailPage
- **File**: `lib/screens/products/product_detail_page.dart`
- **Type**: `ConsumerStatefulWidget`
- **Features**:
  - Image carousel with indicators
  - Product name, brand, description
  - Rating and reviews
  - Price with discount badge
  - Size selector (if available)
  - Color selector (if available)
  - Quantity picker
  - Add to cart button
  - Favorite toggle
  - Stock status indicator
  - "View Cart" snackbar action

### Cart Screen

#### CartPage
- **File**: `lib/screens/cart/cart_page.dart`
- **Type**: `ConsumerWidget`
- **Features**:
  - Cart item list
  - Product thumbnails
  - Quantity controls (+/-)
  - Remove item button
  - Price breakdown
  - Total amount
  - Checkout button
  - Empty cart state

### Authentication Screens

#### LoginPage
- **File**: `lib/screens/profile/authentication/login_page.dart`
- **Type**: `ConsumerStatefulWidget`
- **Features**:
  - Email field
  - Password field
  - Form validation
  - Login button
  - "Create account" link
  - App logo

#### RegisterPage
- **File**: `lib/screens/profile/authentication/register_page.dart`
- **Type**: `ConsumerStatefulWidget`
- **Features**:
  - First name field
  - Last name field
  - Email field
  - Password field
  - Form validation
  - Register button
  - "Already have account?" link

### Settings Screens

#### SettingsPage
- **File**: `lib/screens/profile/settings/settings_page.dart`
- **Type**: `ConsumerWidget`
- **Features**:
  - Language selection
  - Notification settings
  - Theme toggle (light/dark)

#### LanguagesPage
- **File**: `lib/screens/profile/settings/languages_page.dart`
- **Type**: `ConsumerWidget`
- **Features**:
  - English option
  - Français option
  - العربية (Arabic) option
  - Active language indicator

#### NotificationsSettingsPage
- **File**: `lib/screens/profile/settings/notifications_settings_page.dart`
- **Type**: `StatefulWidget`
- **Features**:
  - Account notifications toggle
  - Shipments notifications toggle
  - Recommendations toggle
  - Deals & waitlist toggle

### Other Screens

#### HelpPage
- **File**: `lib/screens/profile/help_page.dart`
- **Purpose**: Display FAQ

#### ContactUsPage
- **File**: `lib/screens/profile/contact_us_page.dart`
- **Purpose**: Contact form/information

---

## Configuration

### Theme Configuration

**File**: `lib/config/app_theme.dart`

#### Light Theme
```dart
AppTheme.light()
```
- Primary Color: Blue
- Background: White
- Text: Dark gray
- Card Background: Light gray

#### Dark Theme
```dart
AppTheme.dark()
```
- Primary Color: Blue
- Background: Dark gray
- Text: White
- Card Background: Darker gray

#### TextTheme (Material 3)
```dart
bodyLarge       // Body text (14px, weight 700)
bodyMedium      // Secondary body text
displayLarge    // Large headings (32px, bold)
displayMedium   // Medium headings (21px, weight 700)
headlineMedium  // Section headings (16px, weight 600)
titleLarge      // Titles (20px, weight 600)
```

### Color Configuration

**File**: `lib/config/colors.dart`

```dart
// Light Theme Colors
appPrimaryColorLight: MaterialColor
appBackgroundColorLight: Color
appContainersBackgroundColorLight: Color
appTextColorLight: Color
appIconColorLight: Color

// Dark Theme Colors
appPrimaryColorDark: MaterialColor
appBackgroundColorDark: Color
appContainersBackgroundColorDark: Color
appTextColorDark: Color
appIconColorDark: Color
```

### Constants

**File**: `lib/config/constants.dart`

```dart
const String kAppTitle = "Shopping App";
const String userToken = "token";
```

### Localization

**Supported Locales**:
```dart
supportedLocales: [
  Locale('fr', 'FR'),  // French
  Locale('en', 'US'),  // English
  Locale('ar', 'TN'),  // Arabic
]
```

### Assets

#### Images
- Path: `assets/images/`
- Usage: App logos, placeholders

#### Fonts
- **Family**: OpenSans
- **Weights**: 300, 400, 500, 600, 700
- **Files**:
  - OpenSans-Light.ttf (300)
  - OpenSans-Regular.ttf (400)
  - OpenSans-Medium.ttf (500)
  - OpenSans-SemiBold.ttf (600)
  - OpenSans-Bold.ttf (700)

---

## Setup & Installation

### Prerequisites
- Flutter SDK >=2.15.1
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile)

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
# On Android
flutter run

# On iOS
flutter run

# On Web
flutter run -d chrome

# On specific device
flutter devices
flutter run -d <device-id>
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### Project Configuration

#### pubspec.yaml
```yaml
name: shopping_app
description: Online Shopping App
version: 1.0.0

environment:
  sdk: ">=2.15.1 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cached_network_image: ^3.2.0
  shared_preferences: ^2.0.13
  flutter_riverpod: ^2.3.6
  go_router: ^9.0.0
  flutter_svg: ^1.0.3
  cupertino_icons: ^1.0.2
```

---

## Code Statistics

### Project Metrics
- **Total Lines of Code**: ~4,900 lines
- **Total Dart Files**: 49 files
- **Code Deletion**: -512 lines (legacy code removed)
- **Net Code Change**: -457 lines (cleaner codebase)

### File Distribution
```
models/           5 files    ~300 lines
providers/        4 files    ~500 lines
services/         1 file     ~325 lines
screens/         17 files   ~2,200 lines
widgets/         20 files    ~900 lines
config/           5 files    ~250 lines
navigation/       1 file     ~130 lines
utils/            3 files    ~150 lines
main.dart         1 file      ~54 lines
```

### Code Quality Metrics
- **Deprecated APIs**: 0
- **Legacy Code**: 0%
- **Test Coverage**: Not implemented yet
- **Linting**: flutter_lints enabled
- **Type Safety**: 100% (strict null safety)

---

## API Reference

### Quick Reference Guide

#### Accessing State in UI

```dart
// Read and watch for changes
final cartState = ref.watch(cartProvider);

// Read once without listening
final cartNotifier = ref.read(cartProvider.notifier);

// Execute action
ref.read(cartProvider.notifier).addItem(product);
```

#### Navigation

```dart
// Push new route
context.push(AppRoutes.cart);

// Replace current route
context.go(AppRoutes.tabs);

// Navigate with data
context.push(AppRoutes.productDetail, extra: product);

// Go back
context.pop();
```

#### Cart Operations

```dart
// Add to cart
ref.read(cartProvider.notifier).addItem(
  product,
  size: 'L',
  color: 'Blue',
);

// Update quantity
ref.read(cartProvider.notifier).updateQuantity(
  productId,
  quantity,
  size: 'L',
  color: 'Blue',
);

// Remove from cart
ref.read(cartProvider.notifier).removeItem(productId);

// Clear cart
ref.read(cartProvider.notifier).clearCart();

// Check if in cart
bool inCart = ref.read(cartProvider.notifier).isInCart(productId);

// Get cart total
double total = ref.watch(cartProvider).totalAmount;
```

#### Favorites Operations

```dart
// Toggle favorite
ref.read(favoritesProvider.notifier).toggleFavorite(product);

// Check if favorited
bool isFav = ref.read(favoritesProvider.notifier).isFavorite(productId);

// Get all favorites
List<Product> favorites = ref.watch(favoritesProvider).favoriteProducts;
```

#### User Operations

```dart
// Login
await ref.read(userProvider.notifier).loginUser();

// Logout
await ref.read(userProvider.notifier).logoutUser();

// Change language
ref.read(userProvider.notifier).changeLocale(Locale('fr', 'FR'));

// Toggle theme
ref.read(userProvider.notifier).switchThemeMode();

// Check login status
bool isLogged = ref.watch(userProvider).isUserLogged;
```

#### Products Operations

```dart
// Load products
ref.read(productsProvider.notifier).loadProducts();

// Get all products
List<Product> products = ref.watch(productsProvider).products;

// Get product by ID
Product? product = ref.read(productsProvider.notifier).getProductById('1');

// Filter by category
List<Product> filtered = ref.read(productsProvider.notifier)
    .getProductsByCategory('electronics');
```

---

## Best Practices

### 1. State Management
- Always use `ref.watch()` in build methods for reactive updates
- Use `ref.read()` for one-time actions (button clicks)
- Never mutate state directly; use `copyWith()`

### 2. Navigation
- Use named routes from `AppRoutes` class
- Pass complex data via `extra` parameter
- Use `context.go()` for root navigation
- Use `context.push()` for stack navigation

### 3. Widgets
- Prefer `ConsumerWidget` over `StatelessWidget`
- Prefer `ConsumerStatefulWidget` over `StatefulWidget`
- Extract reusable widgets into separate files
- Use `const` constructors when possible

### 4. Code Style
- Follow Dart style guide
- Use `flutter_lints` for code quality
- Name files with snake_case
- Name classes with PascalCase
- Name variables with camelCase

---

## Future Enhancements

### Potential Features
1. **Backend Integration**
   - Replace mock service with real API
   - User authentication with JWT
   - Real product database

2. **Payment Integration**
   - Stripe/PayPal integration
   - Order checkout flow
   - Payment history

3. **Enhanced Features**
   - Product reviews and ratings
   - Order tracking
   - Push notifications
   - Wishlists
   - Product recommendations

4. **Testing**
   - Unit tests for providers
   - Widget tests for UI
   - Integration tests
   - Test coverage > 80%

5. **Performance**
   - Image optimization
   - Lazy loading
   - Caching strategies
   - Code splitting

---

## Troubleshooting

### Common Issues

#### 1. Build Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### 2. Dependency Issues
```bash
# Update dependencies
flutter pub upgrade

# Fix version conflicts
flutter pub upgrade --major-versions
```

#### 3. Cache Issues
```bash
# Clear cache
flutter clean
rm -rf ~/.pub-cache
flutter pub get
```

---

## Contributing Guidelines

### Code Contributions
1. Fork the repository
2. Create a feature branch
3. Follow the existing code style
4. Write meaningful commit messages
5. Submit a pull request

### Commit Message Format
```
feat: Add product filter by price
fix: Cart total calculation bug
refactor: Migrate settings to Riverpod
docs: Update README with setup instructions
```

---

## License

This project is a demonstration/educational application.

---

## Contact & Support

For questions, issues, or contributions:
- Create an issue on GitHub
- Submit a pull request
- Contact the maintainers

---

## Changelog

### Version 1.0.0 (Current)
- ✅ Complete migration to Riverpod state management
- ✅ Complete migration to GoRouter navigation
- ✅ Updated all deprecated APIs to Material 3
- ✅ Implemented shopping cart with persistence
- ✅ Implemented favorites with persistence
- ✅ Product catalog with 15 sample products
- ✅ Search and filter functionality
- ✅ Multi-language support (3 languages)
- ✅ Light/dark theme support
- ✅ User authentication flow
- ✅ Settings and preferences

---

**Last Updated**: 2025-11-21
**Documentation Version**: 1.0
**App Version**: 1.0.0
