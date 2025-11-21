class UserProfile {
  final String id;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? bio;
  final DateTime? birthDate;
  final String? gender;
  final int loyaltyPoints;
  final DateTime memberSince;
  final UserPreferences preferences;
  final UserStats stats;

  UserProfile({
    required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.avatarUrl,
    this.bio,
    this.birthDate,
    this.gender,
    this.loyaltyPoints = 0,
    required this.memberSince,
    required this.preferences,
    required this.stats,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      gender: json['gender'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as int? ?? 0,
      memberSince: DateTime.parse(json['memberSince'] as String),
      preferences: UserPreferences.fromJson(json['preferences'] ?? {}),
      stats: UserStats.fromJson(json['stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'loyaltyPoints': loyaltyPoints,
      'memberSince': memberSince.toIso8601String(),
      'preferences': preferences.toJson(),
      'stats': stats.toJson(),
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    String? bio,
    DateTime? birthDate,
    String? gender,
    int? loyaltyPoints,
    DateTime? memberSince,
    UserPreferences? preferences,
    UserStats? stats,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      memberSince: memberSince ?? this.memberSince,
      preferences: preferences ?? this.preferences,
      stats: stats ?? this.stats,
    );
  }
}

class UserPreferences {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool smsNotifications;
  final bool priceAlerts;
  final bool promotionalEmails;
  final bool orderUpdates;

  UserPreferences({
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.smsNotifications = false,
    this.priceAlerts = true,
    this.promotionalEmails = true,
    this.orderUpdates = true,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      smsNotifications: json['smsNotifications'] as bool? ?? false,
      priceAlerts: json['priceAlerts'] as bool? ?? true,
      promotionalEmails: json['promotionalEmails'] as bool? ?? true,
      orderUpdates: json['orderUpdates'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'smsNotifications': smsNotifications,
      'priceAlerts': priceAlerts,
      'promotionalEmails': promotionalEmails,
      'orderUpdates': orderUpdates,
    };
  }

  UserPreferences copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? smsNotifications,
    bool? priceAlerts,
    bool? promotionalEmails,
    bool? orderUpdates,
  }) {
    return UserPreferences(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      priceAlerts: priceAlerts ?? this.priceAlerts,
      promotionalEmails: promotionalEmails ?? this.promotionalEmails,
      orderUpdates: orderUpdates ?? this.orderUpdates,
    );
  }
}

class UserStats {
  final int totalOrders;
  final double totalSpent;
  final int productsReviewed;
  final int wishlistItems;
  final double averageOrderValue;

  UserStats({
    this.totalOrders = 0,
    this.totalSpent = 0.0,
    this.productsReviewed = 0,
    this.wishlistItems = 0,
    this.averageOrderValue = 0.0,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalOrders: json['totalOrders'] as int? ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      productsReviewed: json['productsReviewed'] as int? ?? 0,
      wishlistItems: json['wishlistItems'] as int? ?? 0,
      averageOrderValue: (json['averageOrderValue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalOrders': totalOrders,
      'totalSpent': totalSpent,
      'productsReviewed': productsReviewed,
      'wishlistItems': wishlistItems,
      'averageOrderValue': averageOrderValue,
    };
  }
}
