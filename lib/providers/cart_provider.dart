import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  static const String _cartKey = 'shopping_cart';

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalItemsCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get isEmpty => _items.isEmpty;

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString(_cartKey);
      if (cartData != null) {
        final List<dynamic> decodedData = json.decode(cartData);
        _items = decodedData.map((item) => CartItem.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = json.encode(_items.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartData);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  void addItem(Product product, {String? size, String? color}) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: 1,
        selectedSize: size,
        selectedColor: color,
      ));
    }

    _saveCart();
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity, {String? size, String? color}) {
    final index = _items.indexWhere(
      (item) =>
          item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  int getProductQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(
        product: Product(
          id: '',
          name: '',
          description: '',
          price: 0,
          imageUrl: '',
          images: [],
          category: '',
          brand: '',
        ),
        quantity: 0,
      ),
    );
    return item.quantity;
  }
}
