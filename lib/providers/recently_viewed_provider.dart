import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

// Recently Viewed State
class RecentlyViewedState {
  final List<Product> products;
  final bool isLoading;

  const RecentlyViewedState({
    this.products = const [],
    this.isLoading = false,
  });

  bool get isEmpty => products.isEmpty;
  bool get isNotEmpty => products.isNotEmpty;
  int get count => products.length;

  RecentlyViewedState copyWith({
    List<Product>? products,
    bool? isLoading,
  }) {
    return RecentlyViewedState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Recently Viewed Notifier
class RecentlyViewedNotifier extends StateNotifier<RecentlyViewedState> {
  static const String _recentlyViewedKey = 'recently_viewed';
  static const int _maxItems = 20; // Keep last 20 viewed products

  RecentlyViewedNotifier() : super(const RecentlyViewedState()) {
    _loadRecentlyViewed();
  }

  Future<void> _loadRecentlyViewed() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final recentlyViewedData = prefs.getString(_recentlyViewedKey);
      if (recentlyViewedData != null) {
        final List<dynamic> decodedData = json.decode(recentlyViewedData);
        final products = decodedData.map((product) => Product.fromJson(product)).toList();
        state = RecentlyViewedState(products: products, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveRecentlyViewed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recentlyViewedData =
          json.encode(state.products.map((product) => product.toJson()).toList());
      await prefs.setString(_recentlyViewedKey, recentlyViewedData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addProduct(Product product) async {
    List<Product> products = [...state.products];

    // Remove if already exists
    products.removeWhere((p) => p.id == product.id);

    // Add to beginning
    products.insert(0, product);

    // Keep only last _maxItems
    if (products.length > _maxItems) {
      products = products.sublist(0, _maxItems);
    }

    state = state.copyWith(products: products);
    await _saveRecentlyViewed();
  }

  Future<void> removeProduct(String productId) async {
    final products = state.products.where((product) => product.id != productId).toList();
    state = state.copyWith(products: products);
    await _saveRecentlyViewed();
  }

  Future<void> clearAll() async {
    state = const RecentlyViewedState(products: []);
    await _saveRecentlyViewed();
  }

  bool hasViewed(String productId) {
    return state.products.any((product) => product.id == productId);
  }
}

// Provider
final recentlyViewedProvider =
    StateNotifierProvider<RecentlyViewedNotifier, RecentlyViewedState>((ref) {
  return RecentlyViewedNotifier();
});
