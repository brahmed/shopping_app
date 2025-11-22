import '../../models/product_model.dart';
import '../../models/category_model.dart';
import 'api_client.dart';

/// Remote data source for products
class ProductsRemoteDataSource {
  final ApiClient _apiClient;

  ProductsRemoteDataSource(this._apiClient);

  /// Fetch all products from API
  Future<List<Product>> getProducts() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/products');

    final data = response.data;
    if (data == null || !data.containsKey('products')) {
      return [];
    }

    final productsList = data['products'] as List;
    return productsList.map((json) => Product.fromJson(json)).toList();
  }

  /// Fetch product by ID from API
  Future<Product> getProductById(String id) async {
    final response =
        await _apiClient.get<Map<String, dynamic>>('/products/$id');

    final data = response.data;
    if (data == null) {
      throw Exception('Product not found');
    }

    return Product.fromJson(data);
  }

  /// Fetch products by category from API
  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/products',
      queryParameters: {'category': category},
    );

    final data = response.data;
    if (data == null || !data.containsKey('products')) {
      return [];
    }

    final productsList = data['products'] as List;
    return productsList.map((json) => Product.fromJson(json)).toList();
  }

  /// Search products from API
  Future<List<Product>> searchProducts(String query) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/products/search',
      queryParameters: {'q': query},
    );

    final data = response.data;
    if (data == null || !data.containsKey('products')) {
      return [];
    }

    final productsList = data['products'] as List;
    return productsList.map((json) => Product.fromJson(json)).toList();
  }

  /// Fetch all categories from API
  Future<List<Category>> getCategories() async {
    final response =
        await _apiClient.get<Map<String, dynamic>>('/categories');

    final data = response.data;
    if (data == null || !data.containsKey('categories')) {
      return [];
    }

    final categoriesList = data['categories'] as List;
    return categoriesList.map((json) => Category.fromJson(json)).toList();
  }
}
