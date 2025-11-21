import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product_model.dart';
import '../screens/cart/cart_page.dart';
import '../screens/products/product_detail_page.dart';
import '../screens/profile/authentication/login_page.dart';
import '../screens/profile/authentication/register_page.dart';
import '../screens/profile/contact_us_page.dart';
import '../screens/profile/help_page.dart';
import '../screens/profile/settings/languages_page.dart';
import '../screens/profile/settings/notifications_settings_page.dart';
import '../screens/profile/settings/settings_page.dart';
import '../screens/tab_pages/tabs_manager.dart';

// Route paths
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

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: AppRoutes.tabs,
  routes: [
    // Main tabs (Home, Search, Bookmarks, Profile)
    GoRoute(
      path: AppRoutes.tabs,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const TabsManager(),
      ),
    ),

    // Cart
    GoRoute(
      path: AppRoutes.cart,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CartPage(),
      ),
    ),

    // Product Detail
    GoRoute(
      path: AppRoutes.productDetail,
      pageBuilder: (context, state) {
        final product = state.extra as Product;
        return MaterialPage(
          key: state.pageKey,
          child: ProductDetailPage(product: product),
        );
      },
    ),

    // Profile section
    GoRoute(
      path: AppRoutes.help,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HelpPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.contact,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ContactUsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SettingsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.notificationSettings,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const NotificationsSettingsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.languages,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LanguagesPage(),
      ),
    ),

    // Authentication
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const RegisterPage(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text('Page not found: ${state.location}'),
      ),
    ),
  ),
);
