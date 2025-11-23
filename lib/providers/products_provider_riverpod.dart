import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_model.dart' as models;
import '../models/product_model.dart' as models;
import '../repositories/products_repository.dart';
import '../data/remote/api_client.dart';

// Products State
class ProductsState {
  final List<models.Product> products;
  final List<models.Category> categories;
  final bool isLoading;
  final String? error;
  final bool isOfflineMode;
  final DateTime? lastSync;

  const ProductsState({
    this.products = const [],
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.isOfflineMode = false,
    this.lastSync,
  });

  ProductsState copyWith({
    List<models.Product>? products,
    List<models.Category>? categories,
    bool? isLoading,
    String? Function()? error,
    bool? isOfflineMode,
    DateTime? Function()? lastSync,
  }) {
    return ProductsState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
      lastSync: lastSync != null ? lastSync() : this.lastSync,
    );
  }
}

// Products Notifier with offline-first support
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository _repository;

  ProductsNotifier(this._repository) : super(const ProductsState()) {
    loadProducts();
  }

  /// Load products with offline-first strategy
  Future<void> loadProducts({bool forceRefresh = false}) async {
    state = state.copyWith(isLoading: true, error: () => null);

    try {
      // Load products and categories using offline-first repository
      final products = await _repository.getProducts(forceRefresh: forceRefresh);
      final categories = await _repository.getCategories(forceRefresh: forceRefresh);

      state = ProductsState(
        products: products,
        categories: categories,
        isLoading: false,
        isOfflineMode: false,
        lastSync: DateTime.now(),
      );
    } on OfflineException catch (e) {
      // Offline and no cache available
      state = state.copyWith(
        isLoading: false,
        error: () => e.message,
        isOfflineMode: true,
      );
    } on NetworkException catch (e) {
      // Network error - try to use cached data
      state = state.copyWith(
        isLoading: false,
        error: () => 'Network error: ${e.message}',
        isOfflineMode: true,
      );
    } on TimeoutException catch (e) {
      // Timeout - try to use cached data
      state = state.copyWith(
        isLoading: false,
        error: () => 'Request timeout: ${e.message}',
        isOfflineMode: true,
      );
    } on ServerException catch (e) {
      // Server error
      state = state.copyWith(
        isLoading: false,
        error: () => 'Server error: ${e.message}',
      );
    } catch (e) {
      // Generic error
      state = state.copyWith(
        isLoading: false,
        error: () => 'Error loading products: ${e.toString()}',
      );
    }
  }

  /// Force refresh from server (manual sync)
  Future<void> refresh() async {
    await loadProducts(forceRefresh: true);
  }

  List<models.Product> getProductsByCategory(String categoryId) {
    return state.products.where((product) => product.category == categoryId).toList();
  }

  models.Product? getProductById(String id) {
    try {
      return state.products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<models.Product> searchProducts(String query) {
    if (query.isEmpty) return state.products;

    final lowerQuery = query.toLowerCase();
    return state.products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.brand.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<models.Product> filterProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? inStockOnly,
  }) {
    var filtered = state.products;

    if (category != null && category.isNotEmpty) {
      filtered = filtered.where((p) => p.category == category).toList();
    }

    if (minPrice != null) {
      filtered = filtered.where((p) => p.price >= minPrice).toList();
    }

    if (maxPrice != null) {
      filtered = filtered.where((p) => p.price <= maxPrice).toList();
    }

    if (minRating != null) {
      filtered = filtered.where((p) => p.rating >= minRating).toList();
    }

    if (inStockOnly == true) {
      filtered = filtered.where((p) => p.inStock).toList();
    }

    return filtered;
  }
}

// Provider with repository injection
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(repository);
});
