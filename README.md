# Shopping App 🛍️

A modern, fully-functional e-commerce mobile application built with Flutter, featuring Riverpod state management and GoRouter navigation.

![Flutter](https://img.shields.io/badge/Flutter->=2.15.1-blue)
![Dart](https://img.shields.io/badge/Dart->=2.15.1-blue)
![Riverpod](https://img.shields.io/badge/Riverpod-2.3.6-purple)
![GoRouter](https://img.shields.io/badge/GoRouter-9.0.0-green)

## ✨ Features

- 🛒 **Shopping Cart** - Add products with size/color selection, persistent storage
- ❤️ **Favorites** - Save favorite products across sessions
- 🔍 **Search & Filter** - Text search, category filter, price range, sorting
- 👤 **User Authentication** - Login/register with session persistence
- 🌍 **Multi-language** - English, French, Arabic support
- 🎨 **Theme Support** - Light and dark mode toggle
- 📱 **Modern UI** - Material 3 design with custom components
- 🗂️ **Product Catalog** - 15 products across 6 categories
- 🧭 **Type-safe Navigation** - GoRouter with declarative routing
- ⚡ **State Management** - Riverpod with StateNotifier pattern

## 📸 Screenshots

*Coming soon*

## 🏗️ Architecture

### Tech Stack
- **Frontend**: Flutter
- **State Management**: Riverpod (StateNotifier pattern)
- **Navigation**: GoRouter
- **Storage**: SharedPreferences
- **Image Caching**: cached_network_image
- **Patterns**: MVVM, Immutable State, Dependency Injection

### Project Structure
```
lib/
├── main.dart              # App entry point
├── models/                # Data models
├── providers/             # Riverpod state management
├── services/              # Business logic & API
├── screens/               # UI screens
├── widgets/               # Reusable components
├── navigation/            # Routing configuration
├── config/                # App configuration
└── utils/                 # Helper functions
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK >=2.15.1
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile platforms)

### Installation

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
flutter run
```

### Building for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📚 Documentation

For complete documentation, see [DOCUMENTATION.md](DOCUMENTATION.md)

### Quick Links
- [Architecture & Design Patterns](DOCUMENTATION.md#architecture--design-patterns)
- [State Management Guide](DOCUMENTATION.md#state-management)
- [Navigation System](DOCUMENTATION.md#navigation-system)
- [API Reference](DOCUMENTATION.md#api-reference)
- [Code Statistics](DOCUMENTATION.md#code-statistics)

## 🔑 Key Components

### State Providers
- **CartProvider** - Shopping cart management with persistence
- **ProductsProvider** - Product catalog and categories
- **FavoritesProvider** - User favorites with persistence
- **UserProvider** - Authentication and user preferences

### Main Screens
- **HomePage** - Product grid with category filters
- **SearchPage** - Search with filters and sorting
- **BookmarksPage** - User's favorite products
- **ProfilePage** - User profile and settings
- **ProductDetailPage** - Detailed product view
- **CartPage** - Shopping cart with checkout

## 📱 Features in Detail

### Shopping Cart
- Add products with size/color variants
- Quantity management
- Real-time total calculation
- Persistent storage (survives app restart)
- Cart badge with item count

### Search & Filter
- Real-time text search
- Category filtering
- Price range filter
- Sort by price (low-to-high, high-to-low)
- Instant results

### User Preferences
- Theme toggle (light/dark)
- Language selection (3 languages)
- Notification settings
- Profile management

## 🌍 Localization

Supported languages:
- 🇺🇸 English (en-US)
- 🇫🇷 Français (fr-FR)
- 🇹🇳 العربية (ar-TN)

## 📊 Code Statistics

- **Total Lines**: ~4,900 lines
- **Dart Files**: 49 files
- **Deprecated APIs**: 0
- **Migration Status**: 100% complete
- **Code Quality**: flutter_lints enabled

## 🔧 Configuration

### Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.3.6
  go_router: ^9.0.0
  cached_network_image: ^3.2.0
  shared_preferences: ^2.0.13
  flutter_svg: ^1.0.3
```

### Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web
- ⚠️ Desktop (not tested)

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

*Note: Test suite is currently under development*

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'feat: Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Commit Convention
```
feat: Add new feature
fix: Bug fix
refactor: Code refactoring
docs: Documentation update
test: Add tests
style: Code style changes
```

## 📝 License

This project is a demonstration/educational application.

## 🐛 Known Issues

- Desktop platforms not fully tested
- Mock data service (no real backend)
- Payment integration not implemented

## 🗺️ Roadmap

### Version 1.1
- [ ] Real backend API integration
- [ ] User authentication with JWT
- [ ] Product reviews and ratings
- [ ] Order tracking

### Version 2.0
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Social sharing
- [ ] Advanced analytics

## 📞 Contact & Support

For questions or issues:
- Open an issue on GitHub
- Submit a pull request
- Contact the maintainers

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod by Remi Rousselet
- GoRouter by Flutter team
- OpenSans font family

---

**Version**: 1.0.0
**Last Updated**: 2025-11-21
**Built with**: Flutter & ❤️

## 📖 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Material Design 3](https://m3.material.io)

---

Made with 💙 using Flutter
