import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/providers/reviews_provider.dart';
import 'package:shopping_app/models/review_model.dart';

void main() {
  group('ReviewsProvider Tests', () {
    late ProviderContainer container;
    late Review testReview1;
    late Review testReview2;
    late Review testReview3;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      testReview1 = Review(
        id: 'review1',
        productId: 'prod1',
        userId: 'user1',
        userName: 'John Doe',
        rating: 5.0,
        title: 'Excellent Product!',
        comment: 'This is an amazing product. Highly recommended!',
        createdAt: DateTime.now(),
        isVerifiedPurchase: true,
      );

      testReview2 = Review(
        id: 'review2',
        productId: 'prod1',
        userId: 'user2',
        userName: 'Jane Smith',
        rating: 4.0,
        title: 'Good product',
        comment: 'Works well but could be better.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isVerifiedPurchase: false,
      );

      testReview3 = Review(
        id: 'review3',
        productId: 'prod2',
        userId: 'user1',
        userName: 'John Doe',
        rating: 3.0,
        title: 'Average',
        comment: 'It is okay for the price.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isVerifiedPurchase: true,
      );

      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      container.dispose();
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        final state = container.read(reviewsProvider);

        expect(state.reviews, isEmpty);
        expect(state.isLoading, false);
        expect(state.error, isNull);
      });
    });

    group('Add Review', () {
      test('should add review', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.length, 1);
        expect(state.reviews.first.id, testReview1.id);
      });

      test('should add multiple reviews', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await notifier.addReview(testReview2);
        await notifier.addReview(testReview3);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(reviewsProvider);
        expect(state.reviews.length, 3);
      });
    });

    group('Update Review', () {
      test('should update review', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        final updatedReview = testReview1.copyWith(
          rating: 4.5,
          title: 'Updated Title',
        );

        await notifier.updateReview(updatedReview);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.rating, 4.5);
        expect(state.reviews.first.title, 'Updated Title');
      });

      test('should not update non-existent review', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        final nonExistentReview = testReview2.copyWith(id: 'non_existent');
        await notifier.updateReview(nonExistentReview);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.length, 1);
      });
    });

    group('Delete Review', () {
      test('should delete review', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.deleteReview(testReview1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews, isEmpty);
      });

      test('should delete correct review from multiple', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await notifier.addReview(testReview2);
        await Future.delayed(const Duration(milliseconds: 100));

        await notifier.deleteReview(testReview1.id);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.length, 1);
        expect(state.reviews.first.id, testReview2.id);
      });
    });

    group('Get Reviews By Product', () {
      test('should get reviews for specific product', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1); // prod1
        await notifier.addReview(testReview2); // prod1
        await notifier.addReview(testReview3); // prod2
        await Future.delayed(const Duration(milliseconds: 100));

        final productReviews = notifier.getReviewsByProduct('prod1');

        expect(productReviews.length, 2);
        expect(productReviews.every((r) => r.productId == 'prod1'), true);
      });

      test('should sort reviews by date', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview2);
        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 100));

        final productReviews = notifier.getReviewsByProduct('prod1');

        // Should be sorted newest first
        expect(productReviews.first.id, testReview1.id);
      });

      test('should return empty list for product with no reviews', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        final productReviews = notifier.getReviewsByProduct('non_existent');

        expect(productReviews, isEmpty);
      });
    });

    group('Get Average Rating', () {
      test('should calculate average rating', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1); // 5.0
        await notifier.addReview(testReview2); // 4.0
        await Future.delayed(const Duration(milliseconds: 100));

        final avgRating = notifier.getAverageRating('prod1');

        expect(avgRating, 4.5);
      });

      test('should return 0 for product with no reviews', () {
        final notifier = container.read(reviewsProvider.notifier);

        final avgRating = notifier.getAverageRating('non_existent');

        expect(avgRating, 0.0);
      });
    });

    group('Get Review Count', () {
      test('should count reviews for product', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await notifier.addReview(testReview2);
        await Future.delayed(const Duration(milliseconds: 100));

        final count = notifier.getReviewCount('prod1');

        expect(count, 2);
      });

      test('should return 0 for product with no reviews', () {
        final notifier = container.read(reviewsProvider.notifier);

        final count = notifier.getReviewCount('non_existent');

        expect(count, 0);
      });
    });

    group('Mark Review Helpful', () {
      test('should increment helpful count', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.markReviewHelpful(testReview1.id, true);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.helpfulCount, 1);
      });

      test('should increment not helpful count', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.markReviewHelpful(testReview1.id, false);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.notHelpfulCount, 1);
      });

      test('should handle multiple helpful marks', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 50));

        await notifier.markReviewHelpful(testReview1.id, true);
        await notifier.markReviewHelpful(testReview1.id, true);
        await notifier.markReviewHelpful(testReview1.id, false);
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.helpfulCount, 2);
        expect(state.reviews.first.notHelpfulCount, 1);
      });
    });

    group('Get Reviews By User', () {
      test('should get reviews by user', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1); // user1
        await notifier.addReview(testReview2); // user2
        await notifier.addReview(testReview3); // user1
        await Future.delayed(const Duration(milliseconds: 100));

        final userReviews = notifier.getReviewsByUser('user1');

        expect(userReviews.length, 2);
        expect(userReviews.every((r) => r.userId == 'user1'), true);
      });
    });

    group('Get Verified Purchase Reviews', () {
      test('should get only verified purchase reviews', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1); // verified
        await notifier.addReview(testReview2); // not verified
        await Future.delayed(const Duration(milliseconds: 100));

        final verifiedReviews =
            notifier.getVerifiedPurchaseReviews('prod1');

        expect(verifiedReviews.length, 1);
        expect(verifiedReviews.first.id, testReview1.id);
        expect(verifiedReviews.first.isVerifiedPurchase, true);
      });
    });

    group('Filter Reviews By Rating', () {
      test('should filter by minimum rating', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1); // 5.0
        await notifier.addReview(testReview2); // 4.0
        await Future.delayed(const Duration(milliseconds: 100));

        final filtered = notifier.filterReviewsByRating('prod1', 4.5);

        expect(filtered.length, 1);
        expect(filtered.first.rating, 5.0);
      });
    });

    group('Persistence', () {
      test('should save reviews to SharedPreferences', () async {
        final notifier = container.read(reviewsProvider.notifier);

        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 100));

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('product_reviews'), isNotNull);
      });

      test('should load reviews from SharedPreferences', () async {
        final notifier = container.read(reviewsProvider.notifier);
        await notifier.addReview(testReview1);
        await Future.delayed(const Duration(milliseconds: 100));

        container.dispose();
        container = ProviderContainer();
        await Future.delayed(const Duration(milliseconds: 100));

        final state = container.read(reviewsProvider);
        expect(state.reviews, isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle review with images', () async {
        final notifier = container.read(reviewsProvider.notifier);

        final reviewWithImages = testReview1.copyWith(
          images: ['img1.jpg', 'img2.jpg', 'img3.jpg'],
        );

        await notifier.addReview(reviewWithImages);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.images.length, 3);
      });

      test('should handle extreme ratings', () async {
        final notifier = container.read(reviewsProvider.notifier);

        final lowRating = testReview1.copyWith(rating: 1.0);
        final highRating = testReview2.copyWith(rating: 5.0);

        await notifier.addReview(lowRating);
        await notifier.addReview(highRating);
        await Future.delayed(const Duration(milliseconds: 100));

        final avgRating = notifier.getAverageRating('prod1');
        expect(avgRating, 3.0);
      });

      test('should handle very long comment', () async {
        final notifier = container.read(reviewsProvider.notifier);

        final longComment = 'A' * 10000;
        final reviewWithLongComment =
            testReview1.copyWith(comment: longComment);

        await notifier.addReview(reviewWithLongComment);
        await Future.delayed(const Duration(milliseconds: 50));

        final state = container.read(reviewsProvider);
        expect(state.reviews.first.comment.length, 10000);
      });
    });
  });
}
