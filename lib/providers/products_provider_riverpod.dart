import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

// Products State
class ProductsState {
  final List<Product> products;
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  const ProductsState({
    this.products = const [],
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  ProductsState copyWith({
    List<Product>? products,
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return ProductsState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Products Notifier
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductService _productService = ProductService();

  ProductsNotifier() : super(const ProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final products = await _productService.getProducts();
      final categories = await _productService.getCategories();
      state = ProductsState(
        products: products,
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  List<Product> getProductsByCategory(String categoryId) {
    return state.products.where((product) => product.category == categoryId).toList();
  }

  Product? getProductById(String id) {
    try {
      return state.products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return state.products;

    final lowerQuery = query.toLowerCase();
    return state.products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.brand.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Product> filterProducts({
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

// Provider
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  return ProductsNotifier();
});
