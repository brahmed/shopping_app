import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/coupon_model.dart';
import 'package:shopping_app/models/notification_model.dart';
import 'package:shopping_app/models/order_model_enhanced.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/question_model.dart';
import 'package:shopping_app/models/review_model.dart';
import 'package:shopping_app/models/subscription_model.dart';
import 'package:shopping_app/models/user_profile_model.dart';
import 'package:shopping_app/models/wishlist_model.dart';

/// Mock data for testing
class MockData {
  // ========================================================================
  // PRODUCTS
  // ========================================================================

  static Product get mockProduct1 => Product(
        id: 'product_1',
        name: 'Wireless Headphones',
        description: 'Premium noise-cancelling wireless headphones',
        price: 299.99,
        imageUrl: 'https://example.com/headphones.jpg',
        category: 'Electronics',
        brand: 'AudioTech',
        rating: 4.5,
        reviewCount: 128,
        inStock: true,
        colors: ['Black', 'Silver', 'Blue'],
        sizes: ['One Size'],
      );

  static Product get mockProduct2 => Product(
        id: 'product_2',
        name: 'Running Shoes',
        description: 'Comfortable running shoes for all terrains',
        price: 129.99,
        imageUrl: 'https://example.com/shoes.jpg',
        category: 'Sports',
        brand: 'SportMax',
        rating: 4.8,
        reviewCount: 256,
        inStock: true,
        colors: ['Red', 'Black', 'White'],
        sizes: ['8', '9', '10', '11', '12'],
      );

  static Product get mockProduct3 => Product(
        id: 'product_3',
        name: 'Smart Watch',
        description: 'Feature-packed smartwatch with fitness tracking',
        price: 399.99,
        imageUrl: 'https://example.com/watch.jpg',
        category: 'Electronics',
        brand: 'TechWear',
        rating: 4.7,
        reviewCount: 89,
        inStock: false,
        colors: ['Black', 'Gold'],
        sizes: ['Small', 'Medium', 'Large'],
      );

  static List<Product> get mockProductList => [
        mockProduct1,
        mockProduct2,
        mockProduct3,
      ];

  // ========================================================================
  // REVIEWS
  // ========================================================================

  static Review get mockReview1 => Review(
        id: 'review_1',
        productId: 'product_1',
        userId: 'user_1',
        userName: 'John Doe',
        userAvatar: 'https://example.com/avatar1.jpg',
        rating: 5.0,
        title: 'Amazing sound quality!',
        comment: 'These headphones exceeded my expectations. Great bass and noise cancellation.',
        images: ['https://example.com/review1.jpg'],
        createdAt: DateTime(2024, 1, 15),
        isVerifiedPurchase: true,
        helpfulCount: 24,
        notHelpfulCount: 2,
      );

  static Review get mockReview2 => Review(
        id: 'review_2',
        productId: 'product_1',
        userId: 'user_2',
        userName: 'Jane Smith',
        rating: 4.0,
        title: 'Good but pricey',
        comment: 'Quality is great but I think the price is a bit high.',
        images: [],
        createdAt: DateTime(2024, 2, 1),
        isVerifiedPurchase: true,
        helpfulCount: 12,
        notHelpfulCount: 5,
      );

  static List<Review> get mockReviewList => [mockReview1, mockReview2];

  // ========================================================================
  // ADDRESSES
  // ========================================================================

  static Address get mockAddress1 => Address(
        id: 'address_1',
        userId: 'user_1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '123 Main Street',
        addressLine2: 'Apt 4B',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
        landmark: 'Near Central Park',
        isDefault: true,
        type: AddressType.home,
      );

  static Address get mockAddress2 => Address(
        id: 'address_2',
        userId: 'user_1',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        addressLine1: '456 Business Ave',
        city: 'New York',
        state: 'NY',
        country: 'USA',
        zipCode: '10002',
        isDefault: false,
        type: AddressType.work,
      );

  static List<Address> get mockAddressList => [mockAddress1, mockAddress2];

  // ========================================================================
  // COUPONS
  // ========================================================================

  static Coupon get mockCoupon1 => Coupon(
        id: 'coupon_1',
        code: 'SAVE10',
        title: '10% Off',
        description: 'Save 10% on your order',
        type: CouponType.percentage,
        value: 10.0,
        minPurchaseAmount: 50.0,
        maxDiscountAmount: 20.0,
        validFrom: DateTime.now().subtract(const Duration(days: 7)),
        validUntil: DateTime.now().add(const Duration(days: 30)),
        isActive: true,
        usageLimit: 100,
        usedCount: 25,
      );

  static Coupon get mockCoupon2 => Coupon(
        id: 'coupon_2',
        code: 'FREESHIP',
        title: 'Free Shipping',
        description: 'Free shipping on all orders',
        type: CouponType.fixed,
        value: 10.0,
        minPurchaseAmount: 30.0,
        validFrom: DateTime.now().subtract(const Duration(days: 1)),
        validUntil: DateTime.now().add(const Duration(days: 60)),
        isActive: true,
        usageLimit: 500,
        usedCount: 150,
      );

  static List<Coupon> get mockCouponList => [mockCoupon1, mockCoupon2];

  // ========================================================================
  // CART ITEMS
  // ========================================================================

  static CartItem get mockCartItem1 => CartItem(
        id: 'cart_1',
        product: mockProduct1,
        quantity: 2,
        selectedColor: 'Black',
        selectedSize: 'One Size',
      );

  static CartItem get mockCartItem2 => CartItem(
        id: 'cart_2',
        product: mockProduct2,
        quantity: 1,
        selectedColor: 'Red',
        selectedSize: '10',
      );

  static List<CartItem> get mockCartItemList => [mockCartItem1, mockCartItem2];

  // ========================================================================
  // ORDERS
  // ========================================================================

  static OrderEnhanced get mockOrder1 => OrderEnhanced(
        id: 'order_1',
        userId: 'user_1',
        items: mockCartItemList,
        subtotal: 729.97,
        discount: 73.00,
        shippingCost: 10.00,
        tax: 66.70,
        totalAmount: 733.67,
        status: OrderStatus.processing,
        paymentStatus: PaymentStatus.completed,
        paymentMethod: PaymentMethod.creditCard,
        orderDate: DateTime(2024, 3, 1, 10, 30),
        estimatedDelivery: DateTime(2024, 3, 5),
        shippingAddress: mockAddress1,
        trackingNumber: 'TRACK123456',
        couponCode: 'SAVE10',
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.pending,
            timestamp: DateTime(2024, 3, 1, 10, 30),
            notes: 'Order placed',
          ),
          OrderStatusUpdate(
            status: OrderStatus.confirmed,
            timestamp: DateTime(2024, 3, 1, 11, 0),
            notes: 'Payment confirmed',
          ),
          OrderStatusUpdate(
            status: OrderStatus.processing,
            timestamp: DateTime(2024, 3, 2, 9, 0),
            notes: 'Order is being prepared',
          ),
        ],
      );

  static OrderEnhanced get mockOrder2 => OrderEnhanced(
        id: 'order_2',
        userId: 'user_1',
        items: [mockCartItem1],
        subtotal: 599.98,
        discount: 0.0,
        shippingCost: 0.0,
        tax: 54.00,
        totalAmount: 653.98,
        status: OrderStatus.delivered,
        paymentStatus: PaymentStatus.completed,
        paymentMethod: PaymentMethod.paypal,
        orderDate: DateTime(2024, 2, 15, 14, 20),
        deliveryDate: DateTime(2024, 2, 18, 16, 45),
        shippingAddress: mockAddress1,
        trackingNumber: 'TRACK789012',
        statusUpdates: [
          OrderStatusUpdate(
            status: OrderStatus.delivered,
            timestamp: DateTime(2024, 2, 18, 16, 45),
            notes: 'Package delivered',
          ),
        ],
      );

  static List<OrderEnhanced> get mockOrderList => [mockOrder1, mockOrder2];

  // ========================================================================
  // NOTIFICATIONS
  // ========================================================================

  static AppNotification get mockNotification1 => AppNotification(
        id: 'notif_1',
        title: 'Order Shipped',
        message: 'Your order #order_1 has been shipped',
        type: NotificationType.delivery,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        actionUrl: '/order-details?id=order_1',
        data: {'orderId': 'order_1'},
      );

  static AppNotification get mockNotification2 => AppNotification(
        id: 'notif_2',
        title: 'Price Drop!',
        message: 'Smart Watch is now 20% off!',
        type: NotificationType.priceAlert,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        actionUrl: '/product?id=product_3',
      );

  static List<AppNotification> get mockNotificationList => [
        mockNotification1,
        mockNotification2,
      ];

  // ========================================================================
  // WISHLISTS
  // ========================================================================

  static Wishlist get mockWishlist1 => Wishlist(
        id: 'wishlist_1',
        userId: 'user_1',
        name: 'My Favorites',
        type: WishlistType.general,
        products: [mockProduct1, mockProduct3],
        createdAt: DateTime(2024, 1, 1),
        isPrivate: false,
      );

  static Wishlist get mockWishlist2 => Wishlist(
        id: 'wishlist_2',
        userId: 'user_1',
        name: 'Birthday Wishlist',
        type: WishlistType.birthday,
        products: [mockProduct2],
        createdAt: DateTime(2024, 2, 1),
        isPrivate: true,
        description: 'Things I want for my birthday',
      );

  static List<Wishlist> get mockWishlistList => [mockWishlist1, mockWishlist2];

  // ========================================================================
  // SUBSCRIPTIONS
  // ========================================================================

  static Subscription get mockSubscription1 => Subscription(
        id: 'sub_1',
        userId: 'user_1',
        product: mockProduct1,
        quantity: 1,
        frequency: SubscriptionFrequency.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime(2024, 1, 1),
        nextDeliveryDate: DateTime(2024, 4, 1),
        discountPercentage: 10.0,
        selectedColor: 'Black',
        selectedSize: 'One Size',
      );

  static List<Subscription> get mockSubscriptionList => [mockSubscription1];

  // ========================================================================
  // QUESTIONS & ANSWERS
  // ========================================================================

  static ProductQuestion get mockQuestion1 => ProductQuestion(
        id: 'question_1',
        productId: 'product_1',
        userId: 'user_1',
        userName: 'John Doe',
        question: 'Is this compatible with iPhone 15?',
        askedAt: DateTime(2024, 2, 10),
        answers: [
          Answer(
            id: 'answer_1',
            userId: 'vendor_1',
            userName: 'AudioTech Official',
            answer: 'Yes, it is fully compatible with iPhone 15 and all iOS devices.',
            answeredAt: DateTime(2024, 2, 11),
            isOfficial: true,
            helpfulCount: 15,
          ),
        ],
        helpfulCount: 8,
      );

  static List<ProductQuestion> get mockQuestionList => [mockQuestion1];

  // ========================================================================
  // USER PROFILE
  // ========================================================================

  static UserProfile get mockUserProfile => UserProfile(
        id: 'user_1',
        email: 'john.doe@example.com',
        fullName: 'John Doe',
        phoneNumber: '+1234567890',
        avatarUrl: 'https://example.com/avatar.jpg',
        bio: 'Tech enthusiast and fitness lover',
        birthDate: DateTime(1990, 5, 15),
        gender: 'Male',
        loyaltyPoints: 1250,
        memberSince: DateTime(2023, 1, 1),
        preferences: UserPreferences(
          emailNotifications: true,
          pushNotifications: true,
          smsNotifications: false,
          priceAlerts: true,
          promotionalEmails: true,
          orderUpdates: true,
        ),
        stats: UserStats(
          totalOrders: 15,
          totalSpent: 2549.87,
          productsReviewed: 8,
          wishlistItems: 12,
          averageOrderValue: 169.99,
        ),
      );
}
