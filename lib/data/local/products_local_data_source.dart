import 'dart:convert';
import 'package:drift/drift.dart';
import '../../models/product_model.dart';
import '../../models/category_model.dart';
import 'database/app_database.dart';

/// Local data source for products
class ProductsLocalDataSource {
  final AppDatabase _db;

  ProductsLocalDataSource(this._db);

  // PRODUCTS

  /// Get all cached products
  Future<List<Product>> getAllProducts() async {
    final results = await _db.select(_db.products).get();
    return results.map(_productFromDb).toList();
  }

  /// Get product by ID
  Future<Product?> getProductById(String id) async {
    final result = await (_db.select(_db.products)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (result == null) return null;
    return _productFromDb(result);
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final results = await (_db.select(_db.products)
          ..where((tbl) => tbl.category.equals(category)))
        .get();
    return results.map(_productFromDb).toList();
  }

  /// Search products
  Future<List<Product>> searchProducts(String query) async {
    final lowerQuery = query.toLowerCase();
    final results = await (_db.select(_db.products)
          ..where((tbl) =>
              tbl.name.lower().like('%$lowerQuery%') |
              tbl.description.lower().like('%$lowerQuery%') |
              tbl.brand.lower().like('%$lowerQuery%')))
        .get();
    return results.map(_productFromDb).toList();
  }

  /// Cache single product
  Future<void> cacheProduct(Product product) async {
    await _db.into(_db.products).insertOnConflictUpdate(
          ProductsCompanion.insert(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            originalPrice: Value(product.originalPrice),
            imageUrl: product.imageUrl,
            images: jsonEncode(product.images),
            category: product.category,
            rating: product.rating,
            reviewCount: product.reviewCount,
            inStock: product.inStock,
            sizes: jsonEncode(product.sizes),
            colors: jsonEncode(product.colors),
            brand: Value(product.brand),
            cachedAt: DateTime.now(),
          ),
        );
  }

  /// Cache multiple products
  Future<void> cacheProducts(List<Product> products) async {
    await _db.batch((batch) {
      for (final product in products) {
        batch.insert(
          _db.products,
          ProductsCompanion.insert(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            originalPrice: Value(product.originalPrice),
            imageUrl: product.imageUrl,
            images: jsonEncode(product.images),
            category: product.category,
            rating: product.rating,
            reviewCount: product.reviewCount,
            inStock: product.inStock,
            sizes: jsonEncode(product.sizes),
            colors: jsonEncode(product.colors),
            brand: Value(product.brand),
            cachedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Delete product from cache
  Future<void> deleteProduct(String id) async {
    await (_db.delete(_db.products)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Clear all cached products
  Future<void> clearAllProducts() async {
    await _db.delete(_db.products).go();
  }

  /// Check if products are cached
  Future<bool> hasCache() async {
    final count = await _db.select(_db.products).get();
    return count.isNotEmpty;
  }

  /// Get cache age
  Future<Duration?> getCacheAge() async {
    final products = await (_db.select(_db.products)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.cachedAt)])
          ..limit(1))
        .get();

    if (products.isEmpty) return null;

    final cachedAt = products.first.cachedAt;
    return DateTime.now().difference(cachedAt);
  }

  // CATEGORIES

  /// Get all cached categories
  Future<List<Category>> getAllCategories() async {
    final results = await _db.select(_db.categories).get();
    return results.map(_categoryFromDb).toList();
  }

  /// Get category by ID
  Future<Category?> getCategoryById(String id) async {
    final result = await (_db.select(_db.categories)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (result == null) return null;
    return _categoryFromDb(result);
  }

  /// Cache categories
  Future<void> cacheCategories(List<Category> categories) async {
    await _db.batch((batch) {
      for (final category in categories) {
        batch.insert(
          _db.categories,
          CategoriesCompanion.insert(
            id: category.id,
            name: category.name,
            iconName: Value(category.iconName),
            imageUrl: Value(category.imageUrl),
            cachedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Clear all categories
  Future<void> clearAllCategories() async {
    await _db.delete(_db.categories).go();
  }

  // HELPER METHODS

  /// Convert database model to Product
  Product _productFromDb(ProductEntry dbProduct) {
    return Product(
      id: dbProduct.id,
      name: dbProduct.name,
      description: dbProduct.description,
      price: dbProduct.price,
      originalPrice: dbProduct.originalPrice,
      imageUrl: dbProduct.imageUrl,
      images: (jsonDecode(dbProduct.images) as List).cast<String>(),
      category: dbProduct.category,
      rating: dbProduct.rating,
      reviewCount: dbProduct.reviewCount,
      inStock: dbProduct.inStock,
      sizes: (jsonDecode(dbProduct.sizes) as List).cast<String>(),
      colors: (jsonDecode(dbProduct.colors) as List).cast<String>(),
      brand: dbProduct.brand,
    );
  }

  /// Convert database model to Category
  Category _categoryFromDb(CategoryEntry dbCategory) {
    return Category(
      id: dbCategory.id,
      name: dbCategory.name,
      iconName: dbCategory.iconName,
      imageUrl: dbCategory.imageUrl,
    );
  }
}
