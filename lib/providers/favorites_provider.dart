import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _favorites = [];
  static const String _favoritesKey = 'favorites';

  List<Product> get favorites => _favorites;

  int get count => _favorites.length;

  bool get isEmpty => _favorites.isEmpty;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesData = prefs.getString(_favoritesKey);
      if (favoritesData != null) {
        final List<dynamic> decodedData = json.decode(favoritesData);
        _favorites = decodedData.map((item) => Product.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesData =
          json.encode(_favorites.map((item) => item.toJson()).toList());
      await prefs.setString(_favoritesKey, favoritesData);
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  bool isFavorite(String productId) {
    return _favorites.any((product) => product.id == productId);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    _saveFavorites();
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!isFavorite(product.id)) {
      _favorites.add(product);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavorite(String productId) {
    _favorites.removeWhere((product) => product.id == productId);
    _saveFavorites();
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    _saveFavorites();
    notifyListeners();
  }
}
