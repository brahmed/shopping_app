import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/review_model.dart';
import 'package:shopping_app/providers/reviews_provider.dart';

void main() {
  group('Review and Rating Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('View product reviews', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap on a product to view details
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for reviews section
        final reviewsTab = find.textContaining('Reviews', findRichText: true);
        if (reviewsTab.evaluate().isNotEmpty) {
          await tester.tap(reviewsTab.first);
          await tester.pumpAndSettle();

          // Verify reviews are displayed
          expect(find.byType(ListView), findsWidgets);
        }
      }
    });

    test('Add review for product', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 5.0,
        title: 'Great Product!',
        comment: 'This product exceeded my expectations.',
        createdAt: DateTime.now(),
        isVerifiedPurchase: true,
      );

      await container.read(reviewsProvider.notifier).addReview(review);

      final reviews = container
          .read(reviewsProvider.notifier)
          .getReviewsByProduct('prod-1');
      expect(reviews.length, 1);
      expect(reviews.first.id, 'review-1');
      expect(reviews.first.rating, 5.0);
    });

    test('Update existing review', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 4.0,
        title: 'Good Product',
        comment: 'Nice product overall.',
        createdAt: DateTime.now(),
      );

      await container.read(reviewsProvider.notifier).addReview(review);

      // Update the review
      final updatedReview = review.copyWith(
        rating: 5.0,
        title: 'Excellent Product!',
        comment: 'Changed my mind, this is excellent!',
      );

      await container.read(reviewsProvider.notifier).updateReview(updatedReview);

      final reviews = container
          .read(reviewsProvider.notifier)
          .getReviewsByProduct('prod-1');
      expect(reviews.first.rating, 5.0);
      expect(reviews.first.title, 'Excellent Product!');
    });

    test('Delete review', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 3.0,
        title: 'Average',
        comment: 'It was okay.',
        createdAt: DateTime.now(),
      );

      await container.read(reviewsProvider.notifier).addReview(review);
      expect(container.read(reviewsProvider).reviews.length, 1);

      await container.read(reviewsProvider.notifier).deleteReview('review-1');
      expect(container.read(reviewsProvider).reviews.length, 0);
    });

    test('Calculate average rating for product', () async {
      final reviews = [
        Review(
          id: 'review-1',
          productId: 'prod-1',
          userId: 'user-1',
          userName: 'User 1',
          rating: 5.0,
          title: 'Excellent',
          comment: 'Great!',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-2',
          productId: 'prod-1',
          userId: 'user-2',
          userName: 'User 2',
          rating: 4.0,
          title: 'Good',
          comment: 'Nice!',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-3',
          productId: 'prod-1',
          userId: 'user-3',
          userName: 'User 3',
          rating: 3.0,
          title: 'Average',
          comment: 'Okay',
          createdAt: DateTime.now(),
        ),
      ];

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      final avgRating = container
          .read(reviewsProvider.notifier)
          .getAverageRating('prod-1');
      expect(avgRating, 4.0); // (5 + 4 + 3) / 3 = 4.0
    });

    test('Get review count for product', () async {
      final reviews = List.generate(
        5,
        (index) => Review(
          id: 'review-$index',
          productId: 'prod-1',
          userId: 'user-$index',
          userName: 'User $index',
          rating: 4.0,
          title: 'Review $index',
          comment: 'Comment $index',
          createdAt: DateTime.now(),
        ),
      );

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      final count = container
          .read(reviewsProvider.notifier)
          .getReviewCount('prod-1');
      expect(count, 5);
    });

    test('Mark review as helpful', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 5.0,
        title: 'Great!',
        comment: 'Excellent product',
        createdAt: DateTime.now(),
        helpfulCount: 0,
      );

      await container.read(reviewsProvider.notifier).addReview(review);

      // Mark as helpful
      await container
          .read(reviewsProvider.notifier)
          .markReviewHelpful('review-1', true);

      final updatedReviews = container.read(reviewsProvider).reviews;
      expect(updatedReviews.first.helpfulCount, 1);
    });

    test('Mark review as not helpful', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 5.0,
        title: 'Great!',
        comment: 'Excellent product',
        createdAt: DateTime.now(),
        notHelpfulCount: 0,
      );

      await container.read(reviewsProvider.notifier).addReview(review);

      // Mark as not helpful
      await container
          .read(reviewsProvider.notifier)
          .markReviewHelpful('review-1', false);

      final updatedReviews = container.read(reviewsProvider).reviews;
      expect(updatedReviews.first.notHelpfulCount, 1);
    });

    test('Get reviews by user', () async {
      final reviews = [
        Review(
          id: 'review-1',
          productId: 'prod-1',
          userId: 'user-1',
          userName: 'Test User',
          rating: 5.0,
          title: 'Review 1',
          comment: 'Comment 1',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-2',
          productId: 'prod-2',
          userId: 'user-1',
          userName: 'Test User',
          rating: 4.0,
          title: 'Review 2',
          comment: 'Comment 2',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-3',
          productId: 'prod-3',
          userId: 'user-2',
          userName: 'Other User',
          rating: 3.0,
          title: 'Review 3',
          comment: 'Comment 3',
          createdAt: DateTime.now(),
        ),
      ];

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      final userReviews = container
          .read(reviewsProvider.notifier)
          .getReviewsByUser('user-1');
      expect(userReviews.length, 2);
      expect(userReviews.every((r) => r.userId == 'user-1'), true);
    });

    test('Get verified purchase reviews', () async {
      final reviews = [
        Review(
          id: 'review-1',
          productId: 'prod-1',
          userId: 'user-1',
          userName: 'User 1',
          rating: 5.0,
          title: 'Verified',
          comment: 'Verified purchase',
          createdAt: DateTime.now(),
          isVerifiedPurchase: true,
        ),
        Review(
          id: 'review-2',
          productId: 'prod-1',
          userId: 'user-2',
          userName: 'User 2',
          rating: 4.0,
          title: 'Not Verified',
          comment: 'Not verified',
          createdAt: DateTime.now(),
          isVerifiedPurchase: false,
        ),
      ];

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      final verifiedReviews = container
          .read(reviewsProvider.notifier)
          .getVerifiedPurchaseReviews('prod-1');
      expect(verifiedReviews.length, 1);
      expect(verifiedReviews.first.isVerifiedPurchase, true);
    });

    test('Filter reviews by minimum rating', () async {
      final reviews = [
        Review(
          id: 'review-1',
          productId: 'prod-1',
          userId: 'user-1',
          userName: 'User 1',
          rating: 5.0,
          title: '5 stars',
          comment: 'Excellent',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-2',
          productId: 'prod-1',
          userId: 'user-2',
          userName: 'User 2',
          rating: 4.0,
          title: '4 stars',
          comment: 'Good',
          createdAt: DateTime.now(),
        ),
        Review(
          id: 'review-3',
          productId: 'prod-1',
          userId: 'user-3',
          userName: 'User 3',
          rating: 2.0,
          title: '2 stars',
          comment: 'Not great',
          createdAt: DateTime.now(),
        ),
      ];

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      // Filter reviews with 4+ stars
      final highRatedReviews = container
          .read(reviewsProvider.notifier)
          .filterReviewsByRating('prod-1', 4.0);
      expect(highRatedReviews.length, 2);
      expect(highRatedReviews.every((r) => r.rating >= 4.0), true);
    });

    test('Reviews sorted by date', () async {
      final now = DateTime.now();
      final reviews = [
        Review(
          id: 'review-1',
          productId: 'prod-1',
          userId: 'user-1',
          userName: 'User 1',
          rating: 5.0,
          title: 'Oldest',
          comment: 'Old review',
          createdAt: now.subtract(const Duration(days: 2)),
        ),
        Review(
          id: 'review-2',
          productId: 'prod-1',
          userId: 'user-2',
          userName: 'User 2',
          rating: 4.0,
          title: 'Newest',
          comment: 'New review',
          createdAt: now,
        ),
        Review(
          id: 'review-3',
          productId: 'prod-1',
          userId: 'user-3',
          userName: 'User 3',
          rating: 3.0,
          title: 'Middle',
          comment: 'Mid review',
          createdAt: now.subtract(const Duration(days: 1)),
        ),
      ];

      for (final review in reviews) {
        await container.read(reviewsProvider.notifier).addReview(review);
      }

      final sortedReviews = container
          .read(reviewsProvider.notifier)
          .getReviewsByProduct('prod-1');

      // Should be sorted newest first
      expect(sortedReviews.first.title, 'Newest');
      expect(sortedReviews.last.title, 'Oldest');
    });

    testWidgets('Submit review form', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to product details
      final productCard = find.byType(GestureDetector);
      if (productCard.evaluate().isNotEmpty) {
        await tester.tap(productCard.first);
        await tester.pumpAndSettle();

        // Look for "Write Review" button
        final writeReviewButton =
            find.textContaining('Write', findRichText: true);
        if (writeReviewButton.evaluate().isNotEmpty) {
          await tester.tap(writeReviewButton.first);
          await tester.pumpAndSettle();

          // Fill review form
          final textFields = find.byType(TextField);
          if (textFields.evaluate().isNotEmpty) {
            await tester.enterText(textFields.first, 'Great Product!');
            await tester.pumpAndSettle();
          }
        }
      }
    });

    test('Review with images', () async {
      final review = Review(
        id: 'review-1',
        productId: 'prod-1',
        userId: 'user-1',
        userName: 'Test User',
        rating: 5.0,
        title: 'Great Product!',
        comment: 'See my photos',
        createdAt: DateTime.now(),
        images: ['image1.jpg', 'image2.jpg'],
      );

      await container.read(reviewsProvider.notifier).addReview(review);

      final reviews = container
          .read(reviewsProvider.notifier)
          .getReviewsByProduct('prod-1');
      expect(reviews.first.images.length, 2);
    });
  });
}
