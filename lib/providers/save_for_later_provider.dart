import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

// Save for Later State
class SaveForLaterState {
  final List<CartItem> items;
  final bool isLoading;

  const SaveForLaterState({
    this.items = const [],
    this.isLoading = false,
  });

  int get itemCount => items.length;

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  double get totalValue {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  SaveForLaterState copyWith({
    List<CartItem>? items,
    bool? isLoading,
  }) {
    return SaveForLaterState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Save for Later Notifier
class SaveForLaterNotifier extends StateNotifier<SaveForLaterState> {
  static const String _saveForLaterKey = 'save_for_later';

  SaveForLaterNotifier() : super(const SaveForLaterState()) {
    _loadSaveForLater();
  }

  Future<void> _loadSaveForLater() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final saveForLaterData = prefs.getString(_saveForLaterKey);
      if (saveForLaterData != null) {
        final List<dynamic> decodedData = json.decode(saveForLaterData);
        final items = decodedData.map((item) => CartItem.fromJson(item)).toList();
        state = SaveForLaterState(items: items, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveSaveForLater() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saveForLaterData =
          json.encode(state.items.map((item) => item.toJson()).toList());
      await prefs.setString(_saveForLaterKey, saveForLaterData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addItem(Product product, {String? size, String? color, int quantity = 1}) async {
    final items = List<CartItem>.from(state.items);
    final existingIndex = items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      items[existingIndex].quantity += quantity;
    } else {
      items.add(CartItem(
        product: product,
        quantity: quantity,
        selectedSize: size,
        selectedColor: color,
      ));
    }

    state = state.copyWith(items: items);
    await _saveSaveForLater();
  }

  Future<void> removeItem(String productId, {String? size, String? color}) async {
    final items = state.items.where((item) {
      return !(item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color);
    }).toList();
    state = state.copyWith(items: items);
    await _saveSaveForLater();
  }

  Future<void> updateQuantity(String productId, int quantity,
      {String? size, String? color}) async {
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
      await _saveSaveForLater();
    }
  }

  Future<void> clearAll() async {
    state = const SaveForLaterState(items: []);
    await _saveSaveForLater();
  }

  bool isInSaveForLater(String productId) {
    return state.items.any((item) => item.product.id == productId);
  }

  CartItem? getItem(String productId, {String? size, String? color}) {
    try {
      return state.items.firstWhere(
        (item) =>
            item.product.id == productId &&
            item.selectedSize == size &&
            item.selectedColor == color,
      );
    } catch (e) {
      return null;
    }
  }
}

// Provider
final saveForLaterProvider =
    StateNotifierProvider<SaveForLaterNotifier, SaveForLaterState>((ref) {
  return SaveForLaterNotifier();
});
