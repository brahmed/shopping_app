import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wishlist_model.dart';
import '../models/product_model.dart';

// Wishlists State
class WishlistsState {
  final List<Wishlist> wishlists;
  final String? selectedWishlistId;
  final bool isLoading;
  final String? error;

  const WishlistsState({
    this.wishlists = const [],
    this.selectedWishlistId,
    this.isLoading = false,
    this.error,
  });

  Wishlist? get selectedWishlist {
    if (selectedWishlistId == null) return null;
    try {
      return wishlists.firstWhere((w) => w.id == selectedWishlistId);
    } catch (e) {
      return null;
    }
  }

  Wishlist? get defaultWishlist {
    return wishlists.isNotEmpty ? wishlists.first : null;
  }

  int get totalWishlists => wishlists.length;

  int get totalProducts {
    return wishlists.fold(0, (sum, wishlist) => sum + wishlist.productCount);
  }

  WishlistsState copyWith({
    List<Wishlist>? wishlists,
    String? selectedWishlistId,
    bool clearSelected = false,
    bool? isLoading,
    String? error,
  }) {
    return WishlistsState(
      wishlists: wishlists ?? this.wishlists,
      selectedWishlistId:
          clearSelected ? null : (selectedWishlistId ?? this.selectedWishlistId),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Wishlists Notifier
class WishlistsNotifier extends StateNotifier<WishlistsState> {
  static const String _wishlistsKey = 'user_wishlists';

  WishlistsNotifier() : super(const WishlistsState()) {
    _loadWishlists();
  }

  Future<void> _loadWishlists() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistsData = prefs.getString(_wishlistsKey);
      if (wishlistsData != null) {
        final List<dynamic> decodedData = json.decode(wishlistsData);
        final wishlists = decodedData.map((wishlist) => Wishlist.fromJson(wishlist)).toList();
        state = WishlistsState(
          wishlists: wishlists,
          selectedWishlistId: wishlists.isNotEmpty ? wishlists.first.id : null,
          isLoading: false,
        );
      } else {
        // Create default wishlist
        await _createDefaultWishlist();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _createDefaultWishlist() async {
    final defaultWishlist = Wishlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user',
      name: 'My Favorites',
      type: WishlistType.general,
      createdAt: DateTime.now(),
    );
    state = WishlistsState(
      wishlists: [defaultWishlist],
      selectedWishlistId: defaultWishlist.id,
      isLoading: false,
    );
    await _saveWishlists();
  }

  Future<void> _saveWishlists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistsData =
          json.encode(state.wishlists.map((wishlist) => wishlist.toJson()).toList());
      await prefs.setString(_wishlistsKey, wishlistsData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> createWishlist(String name, WishlistType type,
      {String? description, bool isPrivate = false}) async {
    final wishlist = Wishlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user',
      name: name,
      type: type,
      createdAt: DateTime.now(),
      isPrivate: isPrivate,
      description: description,
    );

    final wishlists = [...state.wishlists, wishlist];
    state = state.copyWith(wishlists: wishlists);
    await _saveWishlists();
  }

  Future<void> deleteWishlist(String wishlistId) async {
    final wishlists = state.wishlists.where((w) => w.id != wishlistId).toList();
    String? newSelectedId;

    if (state.selectedWishlistId == wishlistId && wishlists.isNotEmpty) {
      newSelectedId = wishlists.first.id;
    }

    state = state.copyWith(wishlists: wishlists, selectedWishlistId: newSelectedId);
    await _saveWishlists();
  }

  Future<void> updateWishlist(Wishlist wishlist) async {
    final wishlists = state.wishlists.map((w) {
      if (w.id == wishlist.id) {
        return wishlist;
      }
      return w;
    }).toList();

    state = state.copyWith(wishlists: wishlists);
    await _saveWishlists();
  }

  void selectWishlist(String wishlistId) {
    state = state.copyWith(selectedWishlistId: wishlistId);
  }

  Future<void> addProductToWishlist(String wishlistId, Product product) async {
    final wishlists = state.wishlists.map((wishlist) {
      if (wishlist.id == wishlistId) {
        final products = [...wishlist.products];
        if (!products.any((p) => p.id == product.id)) {
          products.add(product);
        }
        return wishlist.copyWith(products: products);
      }
      return wishlist;
    }).toList();

    state = state.copyWith(wishlists: wishlists);
    await _saveWishlists();
  }

  Future<void> removeProductFromWishlist(String wishlistId, String productId) async {
    final wishlists = state.wishlists.map((wishlist) {
      if (wishlist.id == wishlistId) {
        final products = wishlist.products.where((p) => p.id != productId).toList();
        return wishlist.copyWith(products: products);
      }
      return wishlist;
    }).toList();

    state = state.copyWith(wishlists: wishlists);
    await _saveWishlists();
  }

  Future<void> moveProductBetweenWishlists(
      String fromWishlistId, String toWishlistId, Product product) async {
    await removeProductFromWishlist(fromWishlistId, product.id);
    await addProductToWishlist(toWishlistId, product);
  }

  bool isProductInWishlist(String wishlistId, String productId) {
    try {
      final wishlist = state.wishlists.firstWhere((w) => w.id == wishlistId);
      return wishlist.products.any((p) => p.id == productId);
    } catch (e) {
      return false;
    }
  }

  bool isProductInAnyWishlist(String productId) {
    return state.wishlists.any((wishlist) => wishlist.products.any((p) => p.id == productId));
  }

  List<String> getWishlistsContainingProduct(String productId) {
    return state.wishlists
        .where((wishlist) => wishlist.products.any((p) => p.id == productId))
        .map((wishlist) => wishlist.id)
        .toList();
  }
}

// Provider
final wishlistsProvider = StateNotifierProvider<WishlistsNotifier, WishlistsState>((ref) {
  return WishlistsNotifier();
});
