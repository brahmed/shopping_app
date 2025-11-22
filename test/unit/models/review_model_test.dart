import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/review_model.dart';

void main() {
  group('Review Model Tests', () {
    late Review testReview;
    late DateTime testDate;

    setUp(() {
      testDate = DateTime(2024, 1, 15, 10, 30);
      testReview = Review(
        id: 'review1',
        productId: 'prod1',
        userId: 'user1',
        userName: 'John Doe',
        userAvatar: 'https://example.com/avatar.jpg',
        rating: 4.5,
        title: 'Great Product!',
        comment: 'This product exceeded my expectations. Highly recommended!',
        images: ['https://example.com/review1.jpg', 'https://example.com/review2.jpg'],
        createdAt: testDate,
        isVerifiedPurchase: true,
        helpfulCount: 25,
        notHelpfulCount: 3,
      );
    });

    test('should create Review instance with all fields', () {
      expect(testReview.id, 'review1');
      expect(testReview.productId, 'prod1');
      expect(testReview.userId, 'user1');
      expect(testReview.userName, 'John Doe');
      expect(testReview.userAvatar, 'https://example.com/avatar.jpg');
      expect(testReview.rating, 4.5);
      expect(testReview.title, 'Great Product!');
      expect(testReview.comment, contains('exceeded my expectations'));
      expect(testReview.images.length, 2);
      expect(testReview.createdAt, testDate);
      expect(testReview.isVerifiedPurchase, true);
      expect(testReview.helpfulCount, 25);
      expect(testReview.notHelpfulCount, 3);
    });

    test('should have default values for optional fields', () {
      final review = Review(
        id: 'review2',
        productId: 'prod2',
        userId: 'user2',
        userName: 'Jane Smith',
        rating: 5.0,
        title: 'Excellent',
        comment: 'Perfect!',
        createdAt: DateTime.now(),
      );

      expect(review.userAvatar, null);
      expect(review.images, isEmpty);
      expect(review.isVerifiedPurchase, false);
      expect(review.helpfulCount, 0);
      expect(review.notHelpfulCount, 0);
    });

    test('should serialize to JSON correctly', () {
      final json = testReview.toJson();

      expect(json['id'], 'review1');
      expect(json['productId'], 'prod1');
      expect(json['userId'], 'user1');
      expect(json['userName'], 'John Doe');
      expect(json['userAvatar'], 'https://example.com/avatar.jpg');
      expect(json['rating'], 4.5);
      expect(json['title'], 'Great Product!');
      expect(json['comment'], contains('exceeded my expectations'));
      expect(json['images'], isA<List>());
      expect(json['images'].length, 2);
      expect(json['createdAt'], testDate.toIso8601String());
      expect(json['isVerifiedPurchase'], true);
      expect(json['helpfulCount'], 25);
      expect(json['notHelpfulCount'], 3);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'review3',
        'productId': 'prod3',
        'userId': 'user3',
        'userName': 'Bob Wilson',
        'userAvatar': 'https://example.com/bob.jpg',
        'rating': 3.5,
        'title': 'Good but could be better',
        'comment': 'Decent product with room for improvement.',
        'images': ['https://example.com/img1.jpg'],
        'createdAt': '2024-02-20T14:30:00.000',
        'isVerifiedPurchase': true,
        'helpfulCount': 10,
        'notHelpfulCount': 2,
      };

      final review = Review.fromJson(json);

      expect(review.id, 'review3');
      expect(review.productId, 'prod3');
      expect(review.userId, 'user3');
      expect(review.userName, 'Bob Wilson');
      expect(review.userAvatar, 'https://example.com/bob.jpg');
      expect(review.rating, 3.5);
      expect(review.title, 'Good but could be better');
      expect(review.comment, 'Decent product with room for improvement.');
      expect(review.images.length, 1);
      expect(review.isVerifiedPurchase, true);
      expect(review.helpfulCount, 10);
      expect(review.notHelpfulCount, 2);
    });

    test('should handle null userAvatar in JSON', () {
      final json = {
        'id': 'review4',
        'productId': 'prod4',
        'userId': 'user4',
        'userName': 'Alice Brown',
        'userAvatar': null,
        'rating': 5.0,
        'title': 'Perfect',
        'comment': 'Amazing!',
        'createdAt': '2024-03-01T10:00:00.000',
      };

      final review = Review.fromJson(json);

      expect(review.userAvatar, null);
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'review5',
        'productId': 'prod5',
        'userId': 'user5',
        'userName': 'Charlie Davis',
        'rating': 4.0,
        'title': 'Good',
        'comment': 'Nice product.',
        'createdAt': '2024-01-10T12:00:00.000',
      };

      final review = Review.fromJson(json);

      expect(review.userAvatar, null);
      expect(review.images, isEmpty);
      expect(review.isVerifiedPurchase, false);
      expect(review.helpfulCount, 0);
      expect(review.notHelpfulCount, 0);
    });

    test('should handle numeric types in JSON (int/double conversion)', () {
      final json = {
        'id': 'review6',
        'productId': 'prod6',
        'userId': 'user6',
        'userName': 'Test User',
        'rating': 5, // int instead of double
        'title': 'Test',
        'comment': 'Test',
        'createdAt': '2024-01-01T00:00:00.000',
        'helpfulCount': 15,
        'notHelpfulCount': 5,
      };

      final review = Review.fromJson(json);

      expect(review.rating, 5.0);
      expect(review.helpfulCount, 15);
      expect(review.notHelpfulCount, 5);
    });

    test('should copyWith correctly - updating single field', () {
      final updatedReview = testReview.copyWith(title: 'Updated Title');

      expect(updatedReview.title, 'Updated Title');
      expect(updatedReview.id, testReview.id);
      expect(updatedReview.comment, testReview.comment);
      expect(updatedReview.rating, testReview.rating);
    });

    test('should copyWith correctly - updating helpful counts', () {
      final updatedReview = testReview.copyWith(
        helpfulCount: 50,
        notHelpfulCount: 5,
      );

      expect(updatedReview.helpfulCount, 50);
      expect(updatedReview.notHelpfulCount, 5);
      expect(updatedReview.id, testReview.id);
      expect(updatedReview.comment, testReview.comment);
    });

    test('should copyWith correctly - no changes', () {
      final copiedReview = testReview.copyWith();

      expect(copiedReview.id, testReview.id);
      expect(copiedReview.productId, testReview.productId);
      expect(copiedReview.userId, testReview.userId);
      expect(copiedReview.userName, testReview.userName);
      expect(copiedReview.rating, testReview.rating);
      expect(copiedReview.title, testReview.title);
      expect(copiedReview.comment, testReview.comment);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testReview.toJson();
      final recreatedReview = Review.fromJson(json);

      expect(recreatedReview.id, testReview.id);
      expect(recreatedReview.productId, testReview.productId);
      expect(recreatedReview.userId, testReview.userId);
      expect(recreatedReview.userName, testReview.userName);
      expect(recreatedReview.userAvatar, testReview.userAvatar);
      expect(recreatedReview.rating, testReview.rating);
      expect(recreatedReview.title, testReview.title);
      expect(recreatedReview.comment, testReview.comment);
      expect(recreatedReview.images, testReview.images);
      expect(recreatedReview.createdAt.toIso8601String(), testReview.createdAt.toIso8601String());
      expect(recreatedReview.isVerifiedPurchase, testReview.isVerifiedPurchase);
      expect(recreatedReview.helpfulCount, testReview.helpfulCount);
      expect(recreatedReview.notHelpfulCount, testReview.notHelpfulCount);
    });

    test('should handle empty images array', () {
      final review = Review(
        id: 'review7',
        productId: 'prod7',
        userId: 'user7',
        userName: 'Test',
        rating: 4.0,
        title: 'Test',
        comment: 'Test',
        images: [],
        createdAt: DateTime.now(),
      );

      expect(review.images, isEmpty);

      final json = review.toJson();
      final recreatedReview = Review.fromJson(json);

      expect(recreatedReview.images, isEmpty);
    });

    test('should handle rating edge values', () {
      final review1 = Review(
        id: 'r1',
        productId: 'p1',
        userId: 'u1',
        userName: 'User',
        rating: 1.0,
        title: 'Poor',
        comment: 'Bad',
        createdAt: DateTime.now(),
      );

      expect(review1.rating, 1.0);

      final review5 = Review(
        id: 'r2',
        productId: 'p2',
        userId: 'u2',
        userName: 'User',
        rating: 5.0,
        title: 'Excellent',
        comment: 'Great',
        createdAt: DateTime.now(),
      );

      expect(review5.rating, 5.0);
    });

    test('should handle long comment text', () {
      final longComment = 'This is a very long comment. ' * 100;
      final review = Review(
        id: 'review8',
        productId: 'prod8',
        userId: 'user8',
        userName: 'Verbose User',
        rating: 4.0,
        title: 'Detailed Review',
        comment: longComment,
        createdAt: DateTime.now(),
      );

      expect(review.comment.length, longComment.length);

      final json = review.toJson();
      final recreatedReview = Review.fromJson(json);

      expect(recreatedReview.comment, longComment);
    });
  });
}
