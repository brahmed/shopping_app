import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

// Comparison State
class ComparisonState {
  final List<Product> products;
  static const int maxProducts = 4;

  const ComparisonState({
    this.products = const [],
  });

  bool get isEmpty => products.isEmpty;
  bool get isFull => products.length >= maxProducts;
  int get count => products.length;
  bool get canCompare => products.length >= 2;

  ComparisonState copyWith({
    List<Product>? products,
  }) {
    return ComparisonState(
      products: products ?? this.products,
    );
  }
}

// Comparison Notifier
class ComparisonNotifier extends StateNotifier<ComparisonState> {
  ComparisonNotifier() : super(const ComparisonState());

  bool addProduct(Product product) {
    if (state.isFull) {
      return false;
    }

    if (isInComparison(product.id)) {
      return false;
    }

    final products = [...state.products, product];
    state = state.copyWith(products: products);
    return true;
  }

  void removeProduct(String productId) {
    final products = state.products.where((p) => p.id != productId).toList();
    state = state.copyWith(products: products);
  }

  void clearAll() {
    state = const ComparisonState(products: []);
  }

  bool isInComparison(String productId) {
    return state.products.any((p) => p.id == productId);
  }

  void replaceProduct(int index, Product product) {
    if (index < 0 || index >= state.products.length) {
      return;
    }

    final products = [...state.products];
    products[index] = product;
    state = state.copyWith(products: products);
  }

  // Get comparison attributes
  Map<String, List<dynamic>> getComparisonData() {
    if (state.products.isEmpty) {
      return {};
    }

    return {
      'Names': state.products.map((p) => p.name).toList(),
      'Prices': state.products.map((p) => '\$${p.price.toStringAsFixed(2)}').toList(),
      'Original Prices': state.products
          .map((p) =>
              p.originalPrice != null ? '\$${p.originalPrice!.toStringAsFixed(2)}' : 'N/A')
          .toList(),
      'Brands': state.products.map((p) => p.brand).toList(),
      'Ratings': state.products.map((p) => '${p.rating} ⭐').toList(),
      'Reviews': state.products.map((p) => '${p.reviewCount} reviews').toList(),
      'In Stock': state.products.map((p) => p.inStock ? 'Yes' : 'No').toList(),
      'Discount': state.products
          .map((p) => p.hasDiscount ? '${p.discountPercentage.toStringAsFixed(0)}%' : 'None')
          .toList(),
    };
  }
}

// Provider
final comparisonProvider =
    StateNotifierProvider<ComparisonNotifier, ComparisonState>((ref) {
  return ComparisonNotifier();
});
