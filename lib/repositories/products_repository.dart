import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/database/app_database.dart';
import '../data/local/products_local_data_source.dart';
import '../data/remote/api_client.dart';
import '../data/remote/products_remote_data_source.dart';
import '../models/product_model.dart' as models;
import '../models/category_model.dart' as models;
import '../services/connectivity_service.dart';
import '../services/offline_queue_service.dart';

/// Products repository with offline-first strategy
class ProductsRepository {
  final ProductsLocalDataSource _localDataSource;
  final ProductsRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;

  // Cache duration - products are considered stale after 1 hour
  static const Duration cacheDuration = Duration(hours: 1);

  ProductsRepository(
    this._localDataSource,
    this._remoteDataSource,
    this._connectivityService,
  );

  /// Get all products with offline-first strategy
  /// Strategy: Read from cache first, then refresh from remote if online
  Future<List<models.Product>> getProducts({bool forceRefresh = false}) async {
    try {
      // 1. Always return cached data first (if available)
      final cachedProducts = await _localDataSource.getAllProducts();
      final hasCache = cachedProducts.isNotEmpty;

      // 2. Check if cache is fresh or if force refresh
      final cacheAge = await _localDataSource.getCacheAge();
      final isCacheStale =
          cacheAge == null || cacheAge > cacheDuration || forceRefresh;

      // 3. If we have fresh cache, return it immediately
      if (hasCache && !isCacheStale) {
        return cachedProducts;
      }

      // 4. Try to fetch fresh data from remote if online
      if (_connectivityService.isOnline) {
        try {
          final remoteProducts = await _remoteDataSource.getProducts();

          // 5. Update cache with fresh data
          await _localDataSource.cacheProducts(remoteProducts);

          return remoteProducts;
        } catch (e) {
          // 6. If remote fetch fails but we have cache, return cached data
          if (hasCache) {
            return cachedProducts;
          }
          rethrow;
        }
      }

      // 7. Offline and have cache - return cached data
      if (hasCache) {
        return cachedProducts;
      }

      // 8. Offline and no cache - throw exception
      throw OfflineException(
        'No internet connection and no cached data available',
      );
    } catch (e) {
      // Handle any errors and fallback to cache if available
      final cachedProducts = await _localDataSource.getAllProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
      rethrow;
    }
  }

  /// Get product by ID with offline-first strategy
  Future<models.Product?> getProductById(String id) async {
    try {
      // 1. Try to get from local cache first
      final cachedProduct = await _localDataSource.getProductById(id);

      // 2. If online, try to fetch fresh data
      if (_connectivityService.isOnline) {
        try {
          final remoteProduct = await _remoteDataSource.getProductById(id);

          // 3. Update cache
          await _localDataSource.cacheProduct(remoteProduct);

          return remoteProduct;
        } catch (e) {
          // 4. If remote fails, return cached data if available
          if (cachedProduct != null) {
            return cachedProduct;
          }
          rethrow;
        }
      }

      // 5. Offline - return cached data
      return cachedProduct;
    } catch (e) {
      // Fallback to cache
      final cachedProduct = await _localDataSource.getProductById(id);
      if (cachedProduct != null) {
        return cachedProduct;
      }
      rethrow;
    }
  }

  /// Get products by category with offline-first strategy
  Future<List<models.Product>> getProductsByCategory(String category) async {
    try {
      // 1. Get from cache first
      final cachedProducts =
          await _localDataSource.getProductsByCategory(category);

      // 2. If online, try to fetch fresh data
      if (_connectivityService.isOnline) {
        try {
          final remoteProducts =
              await _remoteDataSource.getProductsByCategory(category);

          // 3. Update cache (only for this category)
          for (final product in remoteProducts) {
            await _localDataSource.cacheProduct(product);
          }

          return remoteProducts;
        } catch (e) {
          // Fallback to cache
          if (cachedProducts.isNotEmpty) {
            return cachedProducts;
          }
          rethrow;
        }
      }

      // Offline - return cached data
      return cachedProducts;
    } catch (e) {
      // Fallback to cache
      final cachedProducts =
          await _localDataSource.getProductsByCategory(category);
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
      rethrow;
    }
  }

  /// Search products with offline-first strategy
  Future<List<models.Product>> searchProducts(String query) async {
    // Always search in local cache
    final localResults = await _localDataSource.searchProducts(query);

    // If online, also try remote search
    if (_connectivityService.isOnline) {
      try {
        final remoteResults = await _remoteDataSource.searchProducts(query);

        // Cache remote results
        for (final product in remoteResults) {
          await _localDataSource.cacheProduct(product);
        }

        return remoteResults;
      } catch (e) {
        // Fallback to local search results
        return localResults;
      }
    }

    // Offline - return local results
    return localResults;
  }

  /// Get all categories with offline-first strategy
  Future<List<models.Category>> getCategories({bool forceRefresh = false}) async {
    try {
      // 1. Get from cache first
      final cachedCategories = await _localDataSource.getAllCategories();
      final hasCache = cachedCategories.isNotEmpty;

      // 2. If we have cache and not forcing refresh, return it
      if (hasCache && !forceRefresh) {
        // If online, refresh in background
        if (_connectivityService.isOnline) {
          _refreshCategoriesInBackground();
        }
        return cachedCategories;
      }

      // 3. Try to fetch from remote if online
      if (_connectivityService.isOnline) {
        try {
          final remoteCategories = await _remoteDataSource.getCategories();

          // 4. Update cache
          await _localDataSource.cacheCategories(remoteCategories);

          return remoteCategories;
        } catch (e) {
          // Fallback to cache
          if (hasCache) {
            return cachedCategories;
          }
          rethrow;
        }
      }

      // 5. Offline and have cache - return cached data
      if (hasCache) {
        return cachedCategories;
      }

      // 6. Offline and no cache - throw exception
      throw OfflineException(
        'No internet connection and no cached categories available',
      );
    } catch (e) {
      // Fallback to cache
      final cachedCategories = await _localDataSource.getAllCategories();
      if (cachedCategories.isNotEmpty) {
        return cachedCategories;
      }
      rethrow;
    }
  }

  /// Refresh categories in background (fire and forget)
  void _refreshCategoriesInBackground() {
    _remoteDataSource.getCategories().then((categories) {
      _localDataSource.cacheCategories(categories);
    }).catchError((error) {
      // Silently fail - user already has cached data
    });
  }

  /// Force refresh all products (manual sync)
  Future<List<models.Product>> refreshProducts() async {
    return getProducts(forceRefresh: true);
  }

  /// Force refresh categories (manual sync)
  Future<List<models.Category>> refreshCategories() async {
    return getCategories(forceRefresh: true);
  }

  /// Clear local cache
  Future<void> clearCache() async {
    await _localDataSource.clearAllProducts();
    await _localDataSource.clearAllCategories();
  }

  /// Check if data is cached
  Future<bool> hasCache() async {
    return _localDataSource.hasCache();
  }

  /// Get cache age
  Future<Duration?> getCacheAge() async {
    return _localDataSource.getCacheAge();
  }
}

/// Provider for ProductsRepository
final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final apiClient = ref.watch(apiClientProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);

  final localDataSource = ProductsLocalDataSource(db);
  final remoteDataSource = ProductsRemoteDataSource(apiClient);

  return ProductsRepository(
    localDataSource,
    remoteDataSource,
    connectivityService,
  );
});
