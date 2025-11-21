import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/review_model.dart';

// Reviews State
class ReviewsState {
  final List<Review> reviews;
  final bool isLoading;
  final String? error;

  const ReviewsState({
    this.reviews = const [],
    this.isLoading = false,
    this.error,
  });

  ReviewsState copyWith({
    List<Review>? reviews,
    bool? isLoading,
    String? error,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Reviews Notifier
class ReviewsNotifier extends StateNotifier<ReviewsState> {
  static const String _reviewsKey = 'product_reviews';

  ReviewsNotifier() : super(const ReviewsState()) {
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final reviewsData = prefs.getString(_reviewsKey);
      if (reviewsData != null) {
        final List<dynamic> decodedData = json.decode(reviewsData);
        final reviews = decodedData.map((review) => Review.fromJson(review)).toList();
        state = ReviewsState(reviews: reviews, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _saveReviews() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reviewsData = json.encode(state.reviews.map((review) => review.toJson()).toList());
      await prefs.setString(_reviewsKey, reviewsData);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addReview(Review review) async {
    final reviews = [...state.reviews, review];
    state = state.copyWith(reviews: reviews);
    await _saveReviews();
  }

  Future<void> updateReview(Review review) async {
    final reviews = state.reviews.map((r) {
      if (r.id == review.id) {
        return review;
      }
      return r;
    }).toList();

    state = state.copyWith(reviews: reviews);
    await _saveReviews();
  }

  Future<void> deleteReview(String reviewId) async {
    final reviews = state.reviews.where((review) => review.id != reviewId).toList();
    state = state.copyWith(reviews: reviews);
    await _saveReviews();
  }

  List<Review> getReviewsByProduct(String productId) {
    return state.reviews.where((review) => review.productId == productId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  double getAverageRating(String productId) {
    final productReviews = getReviewsByProduct(productId);
    if (productReviews.isEmpty) return 0.0;

    final totalRating = productReviews.fold(0.0, (sum, review) => sum + review.rating);
    return totalRating / productReviews.length;
  }

  int getReviewCount(String productId) {
    return getReviewsByProduct(productId).length;
  }

  Future<void> markReviewHelpful(String reviewId, bool isHelpful) async {
    final reviews = state.reviews.map((review) {
      if (review.id == reviewId) {
        if (isHelpful) {
          return review.copyWith(helpfulCount: review.helpfulCount + 1);
        } else {
          return review.copyWith(notHelpfulCount: review.notHelpfulCount + 1);
        }
      }
      return review;
    }).toList();

    state = state.copyWith(reviews: reviews);
    await _saveReviews();
  }

  List<Review> getReviewsByUser(String userId) {
    return state.reviews.where((review) => review.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<Review> getVerifiedPurchaseReviews(String productId) {
    return state.reviews
        .where((review) => review.productId == productId && review.isVerifiedPurchase)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<Review> filterReviewsByRating(String productId, double minRating) {
    return state.reviews
        .where((review) => review.productId == productId && review.rating >= minRating)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}

// Provider
final reviewsProvider = StateNotifierProvider<ReviewsNotifier, ReviewsState>((ref) {
  return ReviewsNotifier();
});
