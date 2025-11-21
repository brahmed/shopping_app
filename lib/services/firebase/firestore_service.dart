import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/address_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/coupon_model.dart';
import '../../models/notification_model.dart';
import '../../models/order_model_enhanced.dart';
import '../../models/product_model.dart';
import '../../models/review_model.dart';
import '../../models/user_profile_model.dart';
import '../../models/wishlist_model.dart';

/// Central Firestore service for all database operations
class FirestoreService {
  static FirestoreService? _instance;
  static FirestoreService get instance {
    _instance ??= FirestoreService._();
    return _instance!;
  }

  FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _users => _firestore.collection('users');
  CollectionReference get _products => _firestore.collection('products');
  CollectionReference get _orders => _firestore.collection('orders');
  CollectionReference get _coupons => _firestore.collection('coupons');
  CollectionReference get _categories => _firestore.collection('categories');
  CollectionReference get _cart => _firestore.collection('cart');
  CollectionReference get _notifications => _firestore.collection('notifications');

  /// Enable offline persistence
  Future<void> enableOfflinePersistence() async {
    try {
      await _firestore.enablePersistence(
        const PersistenceSettings(synchronizeTabs: true),
      );
      debugPrint('✅ Firestore offline persistence enabled');
    } catch (e) {
      debugPrint('⚠️ Offline persistence error: $e');
    }
  }

  // ==========================================================================
  // USER OPERATIONS
  // ==========================================================================

  /// Check if user profile exists
  Future<bool> userProfileExists(String userId) async {
    final doc = await _users.doc(userId).get();
    return doc.exists;
  }

  /// Create user profile
  Future<void> createUserProfile(UserProfile profile) async {
    await _users.doc(profile.id).set(profile.toJson());
    debugPrint('✅ User profile created: ${profile.id}');
  }

  /// Get user profile
  Future<UserProfile?> getUserProfile(String userId) async {
    final doc = await _users.doc(userId).get();
    if (!doc.exists) return null;
    return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
  }

  /// Watch user profile (real-time)
  Stream<UserProfile?> watchUserProfile(String userId) {
    return _users.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  /// Update user profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _users.doc(userId).update(data);
    debugPrint('✅ User profile updated');
  }

  /// Update user stats
  Future<void> updateUserStats(String userId, Map<String, dynamic> stats) async {
    await _users.doc(userId).update({
      'stats': stats,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Add loyalty points
  Future<void> addLoyaltyPoints(String userId, int points) async {
    await _users.doc(userId).update({
      'loyaltyPoints': FieldValue.increment(points),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('✅ Added $points loyalty points to user $userId');
  }

  /// Delete user data
  Future<void> deleteUserData(String userId) async {
    final batch = _firestore.batch();

    // Delete main user document
    batch.delete(_users.doc(userId));

    // Delete subcollections
    final addresses = await _users.doc(userId).collection('addresses').get();
    for (final doc in addresses.docs) {
      batch.delete(doc.reference);
    }

    final wishlists = await _users.doc(userId).collection('wishlists').get();
    for (final doc in wishlists.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    debugPrint('✅ User data deleted');
  }

  // ==========================================================================
  // ADDRESS OPERATIONS
  // ==========================================================================

  /// Get user addresses
  Future<List<Address>> getUserAddresses(String userId) async {
    final snapshot = await _users.doc(userId).collection('addresses').get();
    return snapshot.docs
        .map((doc) => Address.fromJson(doc.data()))
        .toList();
  }

  /// Watch user addresses (real-time)
  Stream<List<Address>> watchUserAddresses(String userId) {
    return _users
        .doc(userId)
        .collection('addresses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Address.fromJson(doc.data())).toList());
  }

  /// Add address
  Future<void> addAddress(String userId, Address address) async {
    await _users
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .set(address.toJson());
    debugPrint('✅ Address added');
  }

  /// Update address
  Future<void> updateAddress(String userId, Address address) async {
    await _users
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .update(address.toJson());
    debugPrint('✅ Address updated');
  }

  /// Delete address
  Future<void> deleteAddress(String userId, String addressId) async {
    await _users.doc(userId).collection('addresses').doc(addressId).delete();
    debugPrint('✅ Address deleted');
  }

  // ==========================================================================
  // PRODUCT OPERATIONS
  // ==========================================================================

  /// Get all products
  Future<List<Product>> getProducts({
    int limit = 50,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = _products
        .where('status', isEqualTo: 'published')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Get product by ID
  Future<Product?> getProductById(String productId) async {
    final doc = await _products.doc(productId).get();
    if (!doc.exists) return null;
    return Product.fromJson(doc.data() as Map<String, dynamic>);
  }

  /// Watch product (real-time)
  Stream<Product?> watchProduct(String productId) {
    return _products.doc(productId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return Product.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final snapshot = await _products
        .where('category', isEqualTo: categoryId)
        .where('status', isEqualTo: 'published')
        .get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Search products
  Future<List<Product>> searchProducts(String query) async {
    // Note: For production, use Algolia or ElasticSearch for better search
    final snapshot = await _products
        .where('status', isEqualTo: 'published')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Get featured products
  Future<List<Product>> getFeaturedProducts() async {
    final snapshot = await _products
        .where('featured', isEqualTo: true)
        .where('status', isEqualTo: 'published')
        .limit(10)
        .get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Update product inventory
  Future<void> updateProductInventory(String productId, int quantityChange) async {
    await _products.doc(productId).update({
      'inventory.quantity': FieldValue.increment(quantityChange),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ==========================================================================
  // REVIEW OPERATIONS
  // ==========================================================================

  /// Get product reviews
  Future<List<Review>> getProductReviews(String productId) async {
    final snapshot = await _products
        .doc(productId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Review.fromJson(doc.data()))
        .toList();
  }

  /// Watch product reviews (real-time)
  Stream<List<Review>> watchProductReviews(String productId) {
    return _products
        .doc(productId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Review.fromJson(doc.data())).toList());
  }

  /// Add review
  Future<void> addReview(String productId, Review review) async {
    await _products
        .doc(productId)
        .collection('reviews')
        .doc(review.id)
        .set(review.toJson());

    // Update product rating
    await _updateProductRating(productId);
    debugPrint('✅ Review added');
  }

  /// Update review
  Future<void> updateReview(String productId, Review review) async {
    await _products
        .doc(productId)
        .collection('reviews')
        .doc(review.id)
        .update(review.toJson());
    debugPrint('✅ Review updated');
  }

  /// Delete review
  Future<void> deleteReview(String productId, String reviewId) async {
    await _products.doc(productId).collection('reviews').doc(reviewId).delete();
    await _updateProductRating(productId);
    debugPrint('✅ Review deleted');
  }

  /// Update product rating (called after review changes)
  Future<void> _updateProductRating(String productId) async {
    final reviews = await getProductReviews(productId);
    if (reviews.isEmpty) {
      await _products.doc(productId).update({
        'rating': 0.0,
        'reviewCount': 0,
      });
      return;
    }

    final totalRating = reviews.fold(0.0, (sum, review) => sum + review.rating);
    final avgRating = totalRating / reviews.length;

    await _products.doc(productId).update({
      'rating': avgRating,
      'reviewCount': reviews.length,
    });
  }

  // ==========================================================================
  // ORDER OPERATIONS
  // ==========================================================================

  /// Create order
  Future<String> createOrder(OrderEnhanced order) async {
    final docRef = await _orders.add(order.toJson());
    debugPrint('✅ Order created: ${docRef.id}');
    return docRef.id;
  }

  /// Get user orders
  Future<List<OrderEnhanced>> getUserOrders(String userId) async {
    final snapshot = await _orders
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => OrderEnhanced.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Watch user orders (real-time)
  Stream<List<OrderEnhanced>> watchUserOrders(String userId) {
    return _orders
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderEnhanced.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  /// Get order by ID
  Future<OrderEnhanced?> getOrderById(String orderId) async {
    final doc = await _orders.doc(orderId).get();
    if (!doc.exists) return null;
    return OrderEnhanced.fromJson(doc.data() as Map<String, dynamic>);
  }

  /// Watch order (real-time)
  Stream<OrderEnhanced?> watchOrder(String orderId) {
    return _orders.doc(orderId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return OrderEnhanced.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    await _orders.doc(orderId).update({
      'status': newStatus.index,
      'statusUpdates': FieldValue.arrayUnion([
        {
          'status': newStatus.index,
          'timestamp': FieldValue.serverTimestamp(),
        }
      ]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('✅ Order status updated');
  }

  // ==========================================================================
  // WISHLIST OPERATIONS
  // ==========================================================================

  /// Get user wishlists
  Future<List<Wishlist>> getUserWishlists(String userId) async {
    final snapshot = await _users.doc(userId).collection('wishlists').get();
    return snapshot.docs
        .map((doc) => Wishlist.fromJson(doc.data()))
        .toList();
  }

  /// Watch user wishlists (real-time)
  Stream<List<Wishlist>> watchUserWishlists(String userId) {
    return _users
        .doc(userId)
        .collection('wishlists')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Wishlist.fromJson(doc.data())).toList());
  }

  /// Add wishlist
  Future<void> addWishlist(String userId, Wishlist wishlist) async {
    await _users
        .doc(userId)
        .collection('wishlists')
        .doc(wishlist.id)
        .set(wishlist.toJson());
    debugPrint('✅ Wishlist added');
  }

  /// Update wishlist
  Future<void> updateWishlist(String userId, Wishlist wishlist) async {
    await _users
        .doc(userId)
        .collection('wishlists')
        .doc(wishlist.id)
        .update(wishlist.toJson());
    debugPrint('✅ Wishlist updated');
  }

  /// Delete wishlist
  Future<void> deleteWishlist(String userId, String wishlistId) async {
    await _users.doc(userId).collection('wishlists').doc(wishlistId).delete();
    debugPrint('✅ Wishlist deleted');
  }

  // ==========================================================================
  // CART OPERATIONS
  // ==========================================================================

  /// Get user cart
  Future<List<CartItem>> getUserCart(String userId) async {
    final doc = await _cart.doc(userId).get();
    if (!doc.exists) return [];

    final data = doc.data() as Map<String, dynamic>;
    final items = data['items'] as List<dynamic>?;
    if (items == null) return [];

    return items.map((item) => CartItem.fromJson(item)).toList();
  }

  /// Watch user cart (real-time)
  Stream<List<CartItem>> watchUserCart(String userId) {
    return _cart.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return [];

      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) return [];

      final items = data['items'] as List<dynamic>?;
      if (items == null) return [];

      return items.map((item) => CartItem.fromJson(item)).toList();
    });
  }

  /// Update cart
  Future<void> updateCart(String userId, List<CartItem> items) async {
    await _cart.doc(userId).set({
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'lastUpdated': FieldValue.serverTimestamp(),
    });
    debugPrint('✅ Cart updated');
  }

  // ==========================================================================
  // COUPON OPERATIONS
  // ==========================================================================

  /// Get all active coupons
  Future<List<Coupon>> getActiveCoupons() async {
    final now = Timestamp.now();
    final snapshot = await _coupons
        .where('isActive', isEqualTo: true)
        .where('validFrom', isLessThanOrEqualTo: now)
        .where('validUntil', isGreaterThanOrEqualTo: now)
        .get();
    return snapshot.docs
        .map((doc) => Coupon.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Get coupon by code
  Future<Coupon?> getCouponByCode(String code) async {
    final snapshot = await _coupons
        .where('code', isEqualTo: code.toUpperCase())
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return Coupon.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  /// Increment coupon usage
  Future<void> incrementCouponUsage(String couponId) async {
    await _coupons.doc(couponId).update({
      'usedCount': FieldValue.increment(1),
    });
  }

  // ==========================================================================
  // NOTIFICATION OPERATIONS
  // ==========================================================================

  /// Get user notifications
  Future<List<AppNotification>> getUserNotifications(String userId) async {
    final snapshot = await _notifications
        .doc(userId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();
    return snapshot.docs
        .map((doc) => AppNotification.fromJson(doc.data()))
        .toList();
  }

  /// Watch user notifications (real-time)
  Stream<List<AppNotification>> watchUserNotifications(String userId) {
    return _notifications
        .doc(userId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppNotification.fromJson(doc.data()))
            .toList());
  }

  /// Add notification
  Future<void> addNotification(String userId, AppNotification notification) async {
    await _notifications
        .doc(userId)
        .collection('messages')
        .doc(notification.id)
        .set(notification.toJson());
    debugPrint('✅ Notification added');
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    await _notifications
        .doc(userId)
        .collection('messages')
        .doc(notificationId)
        .update({
      'isRead': true,
      'readAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete notification
  Future<void> deleteNotification(String userId, String notificationId) async {
    await _notifications
        .doc(userId)
        .collection('messages')
        .doc(notificationId)
        .delete();
  }

  // ==========================================================================
  // BATCH OPERATIONS
  // ==========================================================================

  /// Batch write operation
  Future<void> batchWrite(Function(WriteBatch batch) operation) async {
    final batch = _firestore.batch();
    operation(batch);
    await batch.commit();
    debugPrint('✅ Batch write completed');
  }

  /// Transaction operation
  Future<T> runTransaction<T>(
    Future<T> Function(Transaction transaction) operation,
  ) async {
    return await _firestore.runTransaction(operation);
  }
}
