import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

// Cart State
class CartState {
  final List<CartItem> items;
  final bool isLoading;

  const CartState({
    this.items = const [],
    this.isLoading = false,
  });

  int get itemCount => items.length;

  int get totalItemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get isEmpty => items.isEmpty;

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

// Cart Notifier
class CartNotifier extends StateNotifier<CartState> {
  static const String _cartKey = 'shopping_cart';

  CartNotifier() : super(const CartState()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString(_cartKey);
      if (cartData != null) {
        final List<dynamic> decodedData = json.decode(cartData);
        final items = decodedData.map((item) => CartItem.fromJson(item)).toList();
        state = CartState(items: items, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = json.encode(state.items.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartData);
    } catch (e) {
      // Handle error
    }
  }

  void addItem(Product product, {String? size, String? color}) {
    final items = List<CartItem>.from(state.items);
    final existingIndex = items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      items[existingIndex].quantity++;
    } else {
      items.add(CartItem(
        product: product,
        quantity: 1,
        selectedSize: size,
        selectedColor: color,
      ));
    }

    state = state.copyWith(items: items);
    _saveCart();
  }

  void removeItem(String productId) {
    final items = state.items.where((item) => item.product.id != productId).toList();
    state = state.copyWith(items: items);
    _saveCart();
  }

  void updateQuantity(String productId, int quantity, {String? size, String? color}) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere(
      (item) =>
          item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index].quantity = quantity;
      }
      state = state.copyWith(items: items);
      _saveCart();
    }
  }

  void clearCart() {
    state = const CartState(items: []);
    _saveCart();
  }

  bool isInCart(String productId) {
    return state.items.any((item) => item.product.id == productId);
  }

  int getProductQuantity(String productId) {
    final item = state.items.firstWhere(
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

// Provider
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
