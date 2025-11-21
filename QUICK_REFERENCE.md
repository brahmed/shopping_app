# Quick Reference Guide

## State Management - Riverpod

### Accessing State in UI

```dart
// ConsumerWidget - for StatelessWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    // Use cartState
  }
}

// ConsumerStatefulWidget - for StatefulWidget
class MyWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    // Use cartState
  }
}
```

### Reading vs Watching State

```dart
// Watch - rebuilds widget when state changes
final cart = ref.watch(cartProvider);

// Read - one-time access, doesn't listen for changes
ref.read(cartProvider.notifier).addItem(product);
```

---

## Navigation - GoRouter

### Basic Navigation

```dart
// Push new route
context.push(AppRoutes.cart);

// Replace current route
context.go(AppRoutes.tabs);

// Navigate with data
context.push(
  AppRoutes.productDetail,
  extra: product,
);

// Go back
context.pop();
```

### Available Routes

```dart
AppRoutes.tabs              // '/'
AppRoutes.cart              // '/cart'
AppRoutes.productDetail     // '/product/:id'
AppRoutes.login             // '/login'
AppRoutes.register          // '/register'
AppRoutes.settings          // '/settings'
AppRoutes.languages         // '/languages'
AppRoutes.help              // '/help'
AppRoutes.contact           // '/contact'
AppRoutes.notificationSettings  // '/notification-settings'
```

---

## Cart Operations

### Add to Cart

```dart
ref.read(cartProvider.notifier).addItem(
  product,
  size: 'L',
  color: 'Blue',
);
```

### Update Quantity

```dart
ref.read(cartProvider.notifier).updateQuantity(
  productId,
  newQuantity,
  size: 'L',
  color: 'Blue',
);
```

### Remove Item

```dart
ref.read(cartProvider.notifier).removeItem(productId);
```

### Clear Cart

```dart
ref.read(cartProvider.notifier).clearCart();
```

### Get Cart Info

```dart
// Get cart state
final cartState = ref.watch(cartProvider);

// Access cart data
int itemCount = cartState.itemCount;
int totalItems = cartState.totalItemsCount;
double total = cartState.totalAmount;
bool isEmpty = cartState.isEmpty;
List<CartItem> items = cartState.items;

// Check if product is in cart
bool inCart = ref.read(cartProvider.notifier).isInCart(productId);

// Get product quantity
int qty = ref.read(cartProvider.notifier).getProductQuantity(productId);
```

---

## Favorites Operations

### Toggle Favorite

```dart
ref.read(favoritesProvider.notifier).toggleFavorite(product);
```

### Check if Favorited

```dart
bool isFavorite = ref.read(favoritesProvider.notifier).isFavorite(productId);
```

### Get All Favorites

```dart
final favoritesState = ref.watch(favoritesProvider);
List<Product> favorites = favoritesState.favoriteProducts;
```

### Clear All Favorites

```dart
ref.read(favoritesProvider.notifier).clearFavorites();
```

---

## User Operations

### Login

```dart
await ref.read(userProvider.notifier).loginUser();
context.go(AppRoutes.tabs);
```

### Logout

```dart
await ref.read(userProvider.notifier).logoutUser();
context.go(AppRoutes.login);
```

### Change Language

```dart
ref.read(userProvider.notifier).changeLocale(
  const Locale('fr', 'FR'),  // French
);

// Available locales:
// Locale('en', 'US')  // English
// Locale('fr', 'FR')  // French
// Locale('ar', 'TN')  // Arabic
```

### Toggle Theme

```dart
ref.read(userProvider.notifier).switchThemeMode();
```

### Get User State

```dart
final userState = ref.watch(userProvider);

bool isLogged = userState.isUserLogged;
bool isLight = userState.isLightTheme;
Locale? locale = userState.currentLocale;
String? token = userState.currentUserToken;
```

---

## Products Operations

### Load Products

```dart
ref.read(productsProvider.notifier).loadProducts();
```

### Load Categories

```dart
ref.read(productsProvider.notifier).loadCategories();
```

### Get Products

```dart
final productsState = ref.watch(productsProvider);

List<Product> products = productsState.products;
List<Category> categories = productsState.categories;
bool isLoading = productsState.isLoading;
String? error = productsState.error;
```

### Get Product by ID

```dart
Product? product = ref.read(productsProvider.notifier)
    .getProductById('1');
```

### Filter by Category

```dart
List<Product> filtered = ref.read(productsProvider.notifier)
    .getProductsByCategory('electronics');
```

---

## Showing Snackbars

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Product added to cart'),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'VIEW CART',
      onPressed: () => context.push(AppRoutes.cart),
    ),
  ),
);
```

---

## Theming

### Access Theme

```dart
// Get current theme
final theme = Theme.of(context);

// Use theme colors
theme.primaryColor
theme.scaffoldBackgroundColor
theme.textTheme.headlineMedium
theme.textTheme.bodyLarge

// Check brightness
bool isDark = theme.brightness == Brightness.dark;
```

### TextTheme Styles

```dart
Theme.of(context).textTheme.displayLarge     // 32px, bold
Theme.of(context).textTheme.displayMedium    // 21px, weight 700
Theme.of(context).textTheme.headlineMedium   // 16px, weight 600
Theme.of(context).textTheme.titleLarge       // 20px, weight 600
Theme.of(context).textTheme.bodyLarge        // 14px, weight 700
Theme.of(context).textTheme.bodyMedium       // Default body
```

---

## Common Widget Patterns

### Product Card

```dart
ProductCard(
  product: product,
  onTap: () => context.push(
    AppRoutes.productDetail,
    extra: product,
  ),
)
```

### App Button

```dart
// Filled button
AppButtonFilled(
  text: 'Add to Cart',
  onClick: () {
    // Handle click
  },
)

// Outlined button
AppButtonOutlined(
  text: 'Cancel',
  onClick: () => context.pop(),
)
```

### Text Field

```dart
AppTextField(
  controller: _controller,
  focusNode: _focusNode,
  label: const Text('Email'),
  hintText: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    }
    return null;
  },
)
```

### List Tile

```dart
AppListTile(
  text: 'Settings',
  iconData: Icons.settings,
  onTap: () => context.push(AppRoutes.settings),
  margin: 10.0,
  padding: 10.0,
  radius: 10.0,
)
```

---

## Form Validation

### Basic Validation

```dart
final _formKey = GlobalKey<FormState>();

// In build method
Form(
  key: _formKey,
  child: Column(
    children: [
      AppTextField(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Field is required';
          }
          return null;
        },
      ),
      AppButtonFilled(
        text: 'Submit',
        onClick: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid
          }
        },
      ),
    ],
  ),
)
```

---

## Image Loading

### Cached Network Image

```dart
CachedNetworkImage(
  imageUrl: product.imageUrl,
  fit: BoxFit.cover,
  placeholder: (context, url) => Container(
    color: Colors.grey[300],
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  ),
  errorWidget: (context, url, error) => Container(
    color: Colors.grey[300],
    child: const Icon(Icons.image, size: 100),
  ),
)
```

---

## Useful Helpers

### Check Empty List

```dart
if (products.isEmpty) {
  return Center(
    child: Text('No products found'),
  );
}
```

### Async Operations

```dart
Future<void> loadData() async {
  setState(() => isLoading = true);
  try {
    await someAsyncOperation();
  } catch (e) {
    // Handle error
  } finally {
    setState(() => isLoading = false);
  }
}
```

### Focus Management

```dart
// Request focus
FocusScope.of(context).requestFocus(_focusNode);

// Unfocus (dismiss keyboard)
FocusScope.of(context).unfocus();
```

---

## Debugging

### Print State

```dart
print('Cart state: ${ref.read(cartProvider)}');
print('Cart items: ${ref.read(cartProvider).items.length}');
```

### Check Widget Rebuilds

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  print('Building MyWidget');
  // Widget content
}
```

---

## Performance Tips

1. **Use const constructors** when possible
2. **Extract widgets** instead of using builder methods
3. **Use ref.read()** for one-time access
4. **Use ref.watch()** only when you need reactivity
5. **Avoid rebuilding entire screen** - use granular widgets
6. **Cache expensive computations** with getters

---

## Common Patterns

### Loading State

```dart
if (state.isLoading) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
```

### Error State

```dart
if (state.error != null) {
  return Center(
    child: Text('Error: ${state.error}'),
  );
}
```

### Empty State

```dart
if (state.items.isEmpty) {
  return const Center(
    child: Text('No items found'),
  );
}
```

### Success State

```dart
return ListView.builder(
  itemCount: state.items.length,
  itemBuilder: (context, index) {
    final item = state.items[index];
    return ListTile(
      title: Text(item.name),
    );
  },
);
```

---

## File Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables**: `camelCase`
- **Constants**: `kCamelCase` or `SCREAMING_SNAKE_CASE`
- **Private**: `_prefixWithUnderscore`

---

## Folder Organization

```
lib/
├── models/           # Data models (plain Dart)
├── providers/        # State management
├── services/         # Business logic
├── screens/          # Full page widgets
├── widgets/          # Reusable components
├── navigation/       # Routing config
├── config/           # Configuration
└── utils/            # Helper functions
```

---

This is a quick reference. For complete documentation, see [DOCUMENTATION.md](DOCUMENTATION.md).
