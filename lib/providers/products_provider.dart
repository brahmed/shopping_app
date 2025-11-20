import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../models/category_model.dart';
import '../services/product_service.dart';

class ProductsProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProductsProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.getProducts();
      _categories = await _productService.getCategories();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((product) => product.category == categoryId).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;

    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.brand.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Product> filterProducts({
    List<Product>? products,
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    bool? inStockOnly,
  }) {
    var filtered = (products ?? _products).where((_) => true);

    if (category != null && category.isNotEmpty) {
      filtered = filtered.where((p) => p.category == category);
    }

    if (minPrice != null) {
      filtered = filtered.where((p) => p.price >= minPrice);
    }

    if (maxPrice != null) {
      filtered = filtered.where((p) => p.price <= maxPrice);
    }

    if (minRating != null) {
      filtered = filtered.where((p) => p.rating >= minRating);
    }

    if (inStockOnly == true) {
      filtered = filtered.where((p) => p.inStock);
    }

    return filtered.toList();
  }
}
