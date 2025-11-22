import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/user_profile_model.dart';

void main() {
  group('UserProfile Model Tests', () {
    late UserProfile testProfile;
    late UserPreferences testPreferences;
    late UserStats testStats;
    late DateTime testMemberSince;
    late DateTime testBirthDate;

    setUp(() {
      testMemberSince = DateTime(2023, 1, 1);
      testBirthDate = DateTime(1990, 5, 15);

      testPreferences = UserPreferences(
        emailNotifications: true,
        pushNotifications: true,
        smsNotifications: false,
        priceAlerts: true,
        promotionalEmails: false,
        orderUpdates: true,
      );

      testStats = UserStats(
        totalOrders: 25,
        totalSpent: 1250.50,
        productsReviewed: 10,
        wishlistItems: 5,
        averageOrderValue: 50.02,
      );

      testProfile = UserProfile(
        id: 'user1',
        email: 'john.doe@example.com',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        avatarUrl: 'https://example.com/avatar.jpg',
        bio: 'Love shopping online!',
        birthDate: testBirthDate,
        gender: 'Male',
        loyaltyPoints: 500,
        memberSince: testMemberSince,
        preferences: testPreferences,
        stats: testStats,
      );
    });

    test('should create UserProfile instance with all fields', () {
      expect(testProfile.id, 'user1');
      expect(testProfile.email, 'john.doe@example.com');
      expect(testProfile.fullName, 'John Doe');
      expect(testProfile.phoneNumber, '+1234567890');
      expect(testProfile.avatarUrl, 'https://example.com/avatar.jpg');
      expect(testProfile.bio, 'Love shopping online!');
      expect(testProfile.birthDate, testBirthDate);
      expect(testProfile.gender, 'Male');
      expect(testProfile.loyaltyPoints, 500);
      expect(testProfile.memberSince, testMemberSince);
      expect(testProfile.preferences, testPreferences);
      expect(testProfile.stats, testStats);
    });

    test('should have default values for optional fields', () {
      final profile = UserProfile(
        id: 'user2',
        email: 'minimal@example.com',
        memberSince: DateTime.now(),
        preferences: UserPreferences(),
        stats: UserStats(),
      );

      expect(profile.fullName, null);
      expect(profile.phoneNumber, null);
      expect(profile.avatarUrl, null);
      expect(profile.bio, null);
      expect(profile.birthDate, null);
      expect(profile.gender, null);
      expect(profile.loyaltyPoints, 0);
    });

    test('should serialize to JSON correctly', () {
      final json = testProfile.toJson();

      expect(json['id'], 'user1');
      expect(json['email'], 'john.doe@example.com');
      expect(json['fullName'], 'John Doe');
      expect(json['phoneNumber'], '+1234567890');
      expect(json['avatarUrl'], 'https://example.com/avatar.jpg');
      expect(json['bio'], 'Love shopping online!');
      expect(json['birthDate'], testBirthDate.toIso8601String());
      expect(json['gender'], 'Male');
      expect(json['loyaltyPoints'], 500);
      expect(json['memberSince'], testMemberSince.toIso8601String());
      expect(json['preferences'], isA<Map<String, dynamic>>());
      expect(json['stats'], isA<Map<String, dynamic>>());
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'user3',
        'email': 'jane@example.com',
        'fullName': 'Jane Smith',
        'phoneNumber': '+0987654321',
        'avatarUrl': 'https://example.com/jane.jpg',
        'bio': 'Tech enthusiast',
        'birthDate': '1995-08-20T00:00:00.000',
        'gender': 'Female',
        'loyaltyPoints': 1000,
        'memberSince': '2022-06-15T00:00:00.000',
        'preferences': {
          'emailNotifications': false,
          'pushNotifications': true,
          'smsNotifications': true,
          'priceAlerts': false,
          'promotionalEmails': true,
          'orderUpdates': true,
        },
        'stats': {
          'totalOrders': 50,
          'totalSpent': 2500.75,
          'productsReviewed': 20,
          'wishlistItems': 10,
          'averageOrderValue': 50.015,
        },
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, 'user3');
      expect(profile.email, 'jane@example.com');
      expect(profile.fullName, 'Jane Smith');
      expect(profile.phoneNumber, '+0987654321');
      expect(profile.avatarUrl, 'https://example.com/jane.jpg');
      expect(profile.bio, 'Tech enthusiast');
      expect(profile.gender, 'Female');
      expect(profile.loyaltyPoints, 1000);
      expect(profile.preferences.emailNotifications, false);
      expect(profile.stats.totalOrders, 50);
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'user4',
        'email': 'minimal@example.com',
        'memberSince': '2024-01-01T00:00:00.000',
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, 'user4');
      expect(profile.fullName, null);
      expect(profile.phoneNumber, null);
      expect(profile.avatarUrl, null);
      expect(profile.bio, null);
      expect(profile.birthDate, null);
      expect(profile.gender, null);
      expect(profile.loyaltyPoints, 0);
      expect(profile.preferences, isNotNull);
      expect(profile.stats, isNotNull);
    });

    test('should handle null preferences in JSON', () {
      final json = {
        'id': 'user5',
        'email': 'test@example.com',
        'memberSince': '2024-01-01T00:00:00.000',
        'preferences': null,
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.preferences, isNotNull);
      expect(profile.preferences.emailNotifications, true);
    });

    test('should handle null stats in JSON', () {
      final json = {
        'id': 'user6',
        'email': 'test@example.com',
        'memberSince': '2024-01-01T00:00:00.000',
        'stats': null,
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.stats, isNotNull);
      expect(profile.stats.totalOrders, 0);
    });

    test('should copyWith correctly - updating single field', () {
      final updated = testProfile.copyWith(fullName: 'John Smith');

      expect(updated.fullName, 'John Smith');
      expect(updated.id, testProfile.id);
      expect(updated.email, testProfile.email);
      expect(updated.loyaltyPoints, testProfile.loyaltyPoints);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final updated = testProfile.copyWith(
        fullName: 'Updated Name',
        bio: 'Updated bio',
        loyaltyPoints: 1000,
      );

      expect(updated.fullName, 'Updated Name');
      expect(updated.bio, 'Updated bio');
      expect(updated.loyaltyPoints, 1000);
      expect(updated.id, testProfile.id);
    });

    test('should copyWith correctly - no changes', () {
      final copied = testProfile.copyWith();

      expect(copied.id, testProfile.id);
      expect(copied.email, testProfile.email);
      expect(copied.fullName, testProfile.fullName);
      expect(copied.loyaltyPoints, testProfile.loyaltyPoints);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testProfile.toJson();
      final recreated = UserProfile.fromJson(json);

      expect(recreated.id, testProfile.id);
      expect(recreated.email, testProfile.email);
      expect(recreated.fullName, testProfile.fullName);
      expect(recreated.phoneNumber, testProfile.phoneNumber);
      expect(recreated.avatarUrl, testProfile.avatarUrl);
      expect(recreated.bio, testProfile.bio);
      expect(recreated.birthDate?.toIso8601String(),
          testProfile.birthDate?.toIso8601String());
      expect(recreated.gender, testProfile.gender);
      expect(recreated.loyaltyPoints, testProfile.loyaltyPoints);
      expect(recreated.memberSince.toIso8601String(),
          testProfile.memberSince.toIso8601String());
    });

    test('should handle numeric type conversion in JSON', () {
      final json = {
        'id': 'user7',
        'email': 'test@example.com',
        'loyaltyPoints': null,
        'memberSince': '2024-01-01T00:00:00.000',
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.loyaltyPoints, 0);
    });
  });

  group('UserPreferences Model Tests', () {
    test('should create UserPreferences with all fields', () {
      final prefs = UserPreferences(
        emailNotifications: false,
        pushNotifications: false,
        smsNotifications: true,
        priceAlerts: false,
        promotionalEmails: false,
        orderUpdates: false,
      );

      expect(prefs.emailNotifications, false);
      expect(prefs.pushNotifications, false);
      expect(prefs.smsNotifications, true);
      expect(prefs.priceAlerts, false);
      expect(prefs.promotionalEmails, false);
      expect(prefs.orderUpdates, false);
    });

    test('should have default values', () {
      final prefs = UserPreferences();

      expect(prefs.emailNotifications, true);
      expect(prefs.pushNotifications, true);
      expect(prefs.smsNotifications, false);
      expect(prefs.priceAlerts, true);
      expect(prefs.promotionalEmails, true);
      expect(prefs.orderUpdates, true);
    });

    test('should serialize to JSON correctly', () {
      final prefs = UserPreferences(
        emailNotifications: false,
        pushNotifications: true,
        smsNotifications: false,
        priceAlerts: true,
        promotionalEmails: false,
        orderUpdates: true,
      );

      final json = prefs.toJson();

      expect(json['emailNotifications'], false);
      expect(json['pushNotifications'], true);
      expect(json['smsNotifications'], false);
      expect(json['priceAlerts'], true);
      expect(json['promotionalEmails'], false);
      expect(json['orderUpdates'], true);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'emailNotifications': true,
        'pushNotifications': false,
        'smsNotifications': true,
        'priceAlerts': false,
        'promotionalEmails': true,
        'orderUpdates': false,
      };

      final prefs = UserPreferences.fromJson(json);

      expect(prefs.emailNotifications, true);
      expect(prefs.pushNotifications, false);
      expect(prefs.smsNotifications, true);
      expect(prefs.priceAlerts, false);
      expect(prefs.promotionalEmails, true);
      expect(prefs.orderUpdates, false);
    });

    test('should handle missing fields in JSON with defaults', () {
      final json = <String, dynamic>{};

      final prefs = UserPreferences.fromJson(json);

      expect(prefs.emailNotifications, true);
      expect(prefs.pushNotifications, true);
      expect(prefs.smsNotifications, false);
      expect(prefs.priceAlerts, true);
      expect(prefs.promotionalEmails, true);
      expect(prefs.orderUpdates, true);
    });

    test('should handle null values in JSON with defaults', () {
      final json = {
        'emailNotifications': null,
        'pushNotifications': null,
        'smsNotifications': null,
        'priceAlerts': null,
        'promotionalEmails': null,
        'orderUpdates': null,
      };

      final prefs = UserPreferences.fromJson(json);

      expect(prefs.emailNotifications, true);
      expect(prefs.pushNotifications, true);
      expect(prefs.smsNotifications, false);
      expect(prefs.priceAlerts, true);
      expect(prefs.promotionalEmails, true);
      expect(prefs.orderUpdates, true);
    });

    test('should copyWith correctly - updating single field', () {
      final prefs = UserPreferences();
      final updated = prefs.copyWith(emailNotifications: false);

      expect(updated.emailNotifications, false);
      expect(updated.pushNotifications, prefs.pushNotifications);
      expect(updated.smsNotifications, prefs.smsNotifications);
    });

    test('should copyWith correctly - updating multiple fields', () {
      final prefs = UserPreferences();
      final updated = prefs.copyWith(
        emailNotifications: false,
        smsNotifications: true,
        priceAlerts: false,
      );

      expect(updated.emailNotifications, false);
      expect(updated.smsNotifications, true);
      expect(updated.priceAlerts, false);
      expect(updated.pushNotifications, prefs.pushNotifications);
    });

    test('should copyWith correctly - no changes', () {
      final prefs = UserPreferences();
      final copied = prefs.copyWith();

      expect(copied.emailNotifications, prefs.emailNotifications);
      expect(copied.pushNotifications, prefs.pushNotifications);
      expect(copied.smsNotifications, prefs.smsNotifications);
      expect(copied.priceAlerts, prefs.priceAlerts);
      expect(copied.promotionalEmails, prefs.promotionalEmails);
      expect(copied.orderUpdates, prefs.orderUpdates);
    });

    test('should preserve data through JSON round-trip', () {
      final prefs = UserPreferences(
        emailNotifications: false,
        pushNotifications: true,
        smsNotifications: true,
        priceAlerts: false,
        promotionalEmails: false,
        orderUpdates: true,
      );

      final json = prefs.toJson();
      final recreated = UserPreferences.fromJson(json);

      expect(recreated.emailNotifications, prefs.emailNotifications);
      expect(recreated.pushNotifications, prefs.pushNotifications);
      expect(recreated.smsNotifications, prefs.smsNotifications);
      expect(recreated.priceAlerts, prefs.priceAlerts);
      expect(recreated.promotionalEmails, prefs.promotionalEmails);
      expect(recreated.orderUpdates, prefs.orderUpdates);
    });
  });

  group('UserStats Model Tests', () {
    test('should create UserStats with all fields', () {
      final stats = UserStats(
        totalOrders: 100,
        totalSpent: 5000.99,
        productsReviewed: 50,
        wishlistItems: 20,
        averageOrderValue: 50.0099,
      );

      expect(stats.totalOrders, 100);
      expect(stats.totalSpent, 5000.99);
      expect(stats.productsReviewed, 50);
      expect(stats.wishlistItems, 20);
      expect(stats.averageOrderValue, 50.0099);
    });

    test('should have default values', () {
      final stats = UserStats();

      expect(stats.totalOrders, 0);
      expect(stats.totalSpent, 0.0);
      expect(stats.productsReviewed, 0);
      expect(stats.wishlistItems, 0);
      expect(stats.averageOrderValue, 0.0);
    });

    test('should serialize to JSON correctly', () {
      final stats = UserStats(
        totalOrders: 75,
        totalSpent: 3750.50,
        productsReviewed: 30,
        wishlistItems: 15,
        averageOrderValue: 50.007,
      );

      final json = stats.toJson();

      expect(json['totalOrders'], 75);
      expect(json['totalSpent'], 3750.50);
      expect(json['productsReviewed'], 30);
      expect(json['wishlistItems'], 15);
      expect(json['averageOrderValue'], 50.007);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'totalOrders': 60,
        'totalSpent': 3000.25,
        'productsReviewed': 25,
        'wishlistItems': 12,
        'averageOrderValue': 50.00416,
      };

      final stats = UserStats.fromJson(json);

      expect(stats.totalOrders, 60);
      expect(stats.totalSpent, 3000.25);
      expect(stats.productsReviewed, 25);
      expect(stats.wishlistItems, 12);
      expect(stats.averageOrderValue, 50.00416);
    });

    test('should handle missing fields in JSON with defaults', () {
      final json = <String, dynamic>{};

      final stats = UserStats.fromJson(json);

      expect(stats.totalOrders, 0);
      expect(stats.totalSpent, 0.0);
      expect(stats.productsReviewed, 0);
      expect(stats.wishlistItems, 0);
      expect(stats.averageOrderValue, 0.0);
    });

    test('should handle null values in JSON with defaults', () {
      final json = {
        'totalOrders': null,
        'totalSpent': null,
        'productsReviewed': null,
        'wishlistItems': null,
        'averageOrderValue': null,
      };

      final stats = UserStats.fromJson(json);

      expect(stats.totalOrders, 0);
      expect(stats.totalSpent, 0.0);
      expect(stats.productsReviewed, 0);
      expect(stats.wishlistItems, 0);
      expect(stats.averageOrderValue, 0.0);
    });

    test('should handle numeric type conversion in JSON', () {
      final json = {
        'totalOrders': 50,
        'totalSpent': 2500,
        'productsReviewed': 20,
        'wishlistItems': 10,
        'averageOrderValue': 50,
      };

      final stats = UserStats.fromJson(json);

      expect(stats.totalOrders, 50);
      expect(stats.totalSpent, 2500.0);
      expect(stats.productsReviewed, 20);
      expect(stats.wishlistItems, 10);
      expect(stats.averageOrderValue, 50.0);
    });

    test('should preserve data through JSON round-trip', () {
      final stats = UserStats(
        totalOrders: 88,
        totalSpent: 4400.88,
        productsReviewed: 44,
        wishlistItems: 22,
        averageOrderValue: 50.01,
      );

      final json = stats.toJson();
      final recreated = UserStats.fromJson(json);

      expect(recreated.totalOrders, stats.totalOrders);
      expect(recreated.totalSpent, stats.totalSpent);
      expect(recreated.productsReviewed, stats.productsReviewed);
      expect(recreated.wishlistItems, stats.wishlistItems);
      expect(recreated.averageOrderValue, stats.averageOrderValue);
    });

    test('should handle large numbers', () {
      final stats = UserStats(
        totalOrders: 999999,
        totalSpent: 9999999.99,
        productsReviewed: 999999,
        wishlistItems: 999999,
        averageOrderValue: 99999.99,
      );

      final json = stats.toJson();
      final recreated = UserStats.fromJson(json);

      expect(recreated.totalOrders, stats.totalOrders);
      expect(recreated.totalSpent, stats.totalSpent);
      expect(recreated.averageOrderValue, stats.averageOrderValue);
    });

    test('should handle decimal precision', () {
      final stats = UserStats(
        totalOrders: 10,
        totalSpent: 123.456789,
        productsReviewed: 5,
        wishlistItems: 3,
        averageOrderValue: 12.3456789,
      );

      final json = stats.toJson();
      final recreated = UserStats.fromJson(json);

      expect(recreated.totalSpent, 123.456789);
      expect(recreated.averageOrderValue, 12.3456789);
    });
  });
}
