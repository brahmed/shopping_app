import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/review_model.dart';

void main() {
  group('Review Model Tests', () {
    late Review testReview;

    setUp(() {
      testReview = Review(
        id: 'review_1',
        productId: 'product_1',
        userId: 'user_1',
        userName: 'John Doe',
        userAvatar: 'https://example.com/avatar.jpg',
        rating: 4.5,
        title: 'Great product!',
        comment: 'Really enjoyed this product. Highly recommend.',
        images: ['https://example.com/review1.jpg'],
        createdAt: DateTime(2024, 1, 15),
        isVerifiedPurchase: true,
        helpfulCount: 10,
        notHelpfulCount: 2,
      );
    });

    test('should create a Review instance', () {
      expect(testReview, isA<Review>());
      expect(testReview.id, equals('review_1'));
      expect(testReview.productId, equals('product_1'));
      expect(testReview.userId, equals('user_1'));
      expect(testReview.userName, equals('John Doe'));
      expect(testReview.rating, equals(4.5));
      expect(testReview.title, equals('Great product!'));
      expect(testReview.comment, equals('Really enjoyed this product. Highly recommend.'));
      expect(testReview.isVerifiedPurchase, isTrue);
      expect(testReview.helpfulCount, equals(10));
      expect(testReview.notHelpfulCount, equals(2));
    });

    test('should serialize to JSON correctly', () {
      final json = testReview.toJson();

      expect(json['id'], equals('review_1'));
      expect(json['productId'], equals('product_1'));
      expect(json['userId'], equals('user_1'));
      expect(json['userName'], equals('John Doe'));
      expect(json['userAvatar'], equals('https://example.com/avatar.jpg'));
      expect(json['rating'], equals(4.5));
      expect(json['title'], equals('Great product!'));
      expect(json['comment'], equals('Really enjoyed this product. Highly recommend.'));
      expect(json['images'], equals(['https://example.com/review1.jpg']));
      expect(json['isVerifiedPurchase'], isTrue);
      expect(json['helpfulCount'], equals(10));
      expect(json['notHelpfulCount'], equals(2));
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'review_2',
        'productId': 'product_2',
        'userId': 'user_2',
        'userName': 'Jane Smith',
        'userAvatar': null,
        'rating': 3.5,
        'title': 'Decent product',
        'comment': 'It works as expected.',
        'images': [],
        'createdAt': '2024-02-20T10:30:00.000',
        'isVerifiedPurchase': false,
        'helpfulCount': 5,
        'notHelpfulCount': 1,
      };

      final review = Review.fromJson(json);

      expect(review.id, equals('review_2'));
      expect(review.productId, equals('product_2'));
      expect(review.userId, equals('user_2'));
      expect(review.userName, equals('Jane Smith'));
      expect(review.userAvatar, isNull);
      expect(review.rating, equals(3.5));
      expect(review.title, equals('Decent product'));
      expect(review.comment, equals('It works as expected.'));
      expect(review.images, isEmpty);
      expect(review.isVerifiedPurchase, isFalse);
      expect(review.helpfulCount, equals(5));
      expect(review.notHelpfulCount, equals(1));
    });

    test('should handle default values when fromJson', () {
      final json = {
        'id': 'review_3',
        'productId': 'product_3',
        'userId': 'user_3',
        'userName': 'Bob Johnson',
        'rating': 5.0,
        'title': 'Excellent!',
        'comment': 'Perfect!',
        'createdAt': '2024-03-01T15:00:00.000',
      };

      final review = Review.fromJson(json);

      expect(review.images, isEmpty);
      expect(review.isVerifiedPurchase, isFalse);
      expect(review.helpfulCount, equals(0));
      expect(review.notHelpfulCount, equals(0));
    });

    test('should create a copy with updated values', () {
      final updatedReview = testReview.copyWith(
        title: 'Updated title',
        helpfulCount: 15,
      );

      expect(updatedReview.id, equals(testReview.id));
      expect(updatedReview.title, equals('Updated title'));
      expect(updatedReview.helpfulCount, equals(15));
      expect(updatedReview.comment, equals(testReview.comment));
    });

    test('should handle null userAvatar', () {
      final reviewWithoutAvatar = Review(
        id: 'review_4',
        productId: 'product_1',
        userId: 'user_4',
        userName: 'Alice Brown',
        rating: 4.0,
        title: 'Good',
        comment: 'Nice product',
        createdAt: DateTime.now(),
      );

      expect(reviewWithoutAvatar.userAvatar, isNull);

      final json = reviewWithoutAvatar.toJson();
      expect(json['userAvatar'], isNull);

      final fromJson = Review.fromJson(json);
      expect(fromJson.userAvatar, isNull);
    });

    test('should handle empty images list', () {
      final reviewWithoutImages = testReview.copyWith(images: []);
      expect(reviewWithoutImages.images, isEmpty);
    });

    test('should correctly round-trip JSON serialization', () {
      final json = testReview.toJson();
      final deserialized = Review.fromJson(json);

      expect(deserialized.id, equals(testReview.id));
      expect(deserialized.productId, equals(testReview.productId));
      expect(deserialized.userId, equals(testReview.userId));
      expect(deserialized.userName, equals(testReview.userName));
      expect(deserialized.userAvatar, equals(testReview.userAvatar));
      expect(deserialized.rating, equals(testReview.rating));
      expect(deserialized.title, equals(testReview.title));
      expect(deserialized.comment, equals(testReview.comment));
      expect(deserialized.images, equals(testReview.images));
      expect(deserialized.isVerifiedPurchase, equals(testReview.isVerifiedPurchase));
      expect(deserialized.helpfulCount, equals(testReview.helpfulCount));
      expect(deserialized.notHelpfulCount, equals(testReview.notHelpfulCount));
    });

    test('should handle rating edge cases', () {
      final minRating = testReview.copyWith(rating: 1.0);
      expect(minRating.rating, equals(1.0));

      final maxRating = testReview.copyWith(rating: 5.0);
      expect(maxRating.rating, equals(5.0));

      final decimalRating = testReview.copyWith(rating: 3.7);
      expect(decimalRating.rating, equals(3.7));
    });

    test('should handle large helpful counts', () {
      final popularReview = testReview.copyWith(
        helpfulCount: 10000,
        notHelpfulCount: 500,
      );

      expect(popularReview.helpfulCount, equals(10000));
      expect(popularReview.notHelpfulCount, equals(500));
    });

    test('should preserve createdAt timestamp', () {
      final specificDate = DateTime(2024, 6, 15, 14, 30, 45);
      final review = testReview.copyWith(createdAt: specificDate);

      final json = review.toJson();
      final deserialized = Review.fromJson(json);

      expect(deserialized.createdAt.year, equals(2024));
      expect(deserialized.createdAt.month, equals(6));
      expect(deserialized.createdAt.day, equals(15));
    });
  });
}
