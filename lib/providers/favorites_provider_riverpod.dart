import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

// Favorites State
class FavoritesState {
  final List<Product> favorites;
  final bool isLoading;

  const FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
  });

  int get count => favorites.length;
  bool get isEmpty => favorites.isEmpty;

  FavoritesState copyWith({
    List<Product>? favorites,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Favorites Notifier
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  static const String _favoritesKey = 'favorites';

  FavoritesNotifier() : super(const FavoritesState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesData = prefs.getString(_favoritesKey);
      if (favoritesData != null) {
        final List<dynamic> decodedData = json.decode(favoritesData);
        final favorites = decodedData.map((item) => Product.fromJson(item)).toList();
        state = FavoritesState(favorites: favorites, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesData =
          json.encode(state.favorites.map((item) => item.toJson()).toList());
      await prefs.setString(_favoritesKey, favoritesData);
    } catch (e) {
      // Handle error
    }
  }

  bool isFavorite(String productId) {
    return state.favorites.any((product) => product.id == productId);
  }

  void toggleFavorite(Product product) {
    final favorites = List<Product>.from(state.favorites);
    if (isFavorite(product.id)) {
      favorites.removeWhere((p) => p.id == product.id);
    } else {
      favorites.add(product);
    }
    state = state.copyWith(favorites: favorites);
    _saveFavorites();
  }

  void addFavorite(Product product) {
    if (!isFavorite(product.id)) {
      final favorites = List<Product>.from(state.favorites)..add(product);
      state = state.copyWith(favorites: favorites);
      _saveFavorites();
    }
  }

  void removeFavorite(String productId) {
    final favorites = state.favorites.where((product) => product.id != productId).toList();
    state = state.copyWith(favorites: favorites);
    _saveFavorites();
  }

  void clearFavorites() {
    state = const FavoritesState(favorites: []);
    _saveFavorites();
  }
}

// Provider
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  return FavoritesNotifier();
});
