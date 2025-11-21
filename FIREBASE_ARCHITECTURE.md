# Firebase Backend Architecture for Shopping App

**Architect**: Solution Architecture Design
**Date**: 2025-11-21
**Version**: 1.0

---

## Executive Summary

This document outlines a comprehensive, production-ready Firebase backend architecture for the Shopping App. The architecture is designed for scalability, security, real-time capabilities, and seamless integration with the existing Flutter frontend.

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Firebase Services](#firebase-services)
3. [Firestore Database Structure](#firestore-database-structure)
4. [Authentication Strategy](#authentication-strategy)
5. [Cloud Functions](#cloud-functions)
6. [Security Rules](#security-rules)
7. [Storage Architecture](#storage-architecture)
8. [Real-time Features](#real-time-features)
9. [API Service Layer](#api-service-layer)
10. [Scalability & Performance](#scalability--performance)
11. [Deployment Strategy](#deployment-strategy)

---

## 1. Architecture Overview

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Flutter Mobile App                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ UI Layer │  │ Providers│  │  Models  │  │  Widgets │   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └──────────┘   │
│       │             │              │                         │
│       └─────────────┴──────────────┴─────────────┐          │
│                                                   │          │
└───────────────────────────────────────────────────┼──────────┘
                                                    │
                          ┌─────────────────────────┼──────────┐
                          │   Firebase Services     │          │
                          │  (Service Layer)        │          │
                          └─────────────────────────┼──────────┘
                                                    │
        ┌───────────────────────┬───────────────────┼───────────────────┐
        │                       │                   │                   │
┌───────▼────────┐   ┌─────────▼────────┐   ┌─────▼──────┐   ┌───────▼────────┐
│ Authentication │   │    Firestore     │   │  Storage   │   │ Cloud Functions│
│   (Auth)       │   │   (Database)     │   │  (Images)  │   │  (Server Logic)│
└────────────────┘   └──────────────────┘   └────────────┘   └────────────────┘
        │                       │                   │                   │
        │            ┌──────────▼──────────┐        │                   │
        │            │  Cloud Messaging    │        │                   │
        │            │  (Notifications)    │        │                   │
        │            └─────────────────────┘        │                   │
        │                       │                   │                   │
        └───────────────────────┴───────────────────┴───────────────────┘
                                │
                     ┌──────────▼──────────┐
                     │  Analytics &        │
                     │  Crashlytics        │
                     └─────────────────────┘
```

### Technology Stack

- **Frontend**: Flutter 3.x with Riverpod
- **Backend**: Firebase (BaaS - Backend as a Service)
- **Authentication**: Firebase Authentication
- **Database**: Cloud Firestore (NoSQL)
- **Storage**: Firebase Cloud Storage
- **Functions**: Cloud Functions for Firebase (Node.js/TypeScript)
- **Messaging**: Firebase Cloud Messaging (FCM)
- **Analytics**: Firebase Analytics & Crashlytics
- **Hosting**: Firebase Hosting (for admin panel)

---

## 2. Firebase Services

### 2.1 Firebase Authentication

**Purpose**: User authentication and authorization

**Features**:
- Email/Password authentication
- Google Sign-In
- Apple Sign-In
- Phone Authentication (optional)
- Anonymous authentication for guest checkout
- Custom claims for admin roles

**User Properties**:
```dart
{
  uid: String,
  email: String,
  displayName: String?,
  photoURL: String?,
  emailVerified: bool,
  customClaims: {
    role: 'user' | 'admin' | 'vendor',
    loyaltyTier: 'bronze' | 'silver' | 'gold',
  }
}
```

### 2.2 Cloud Firestore

**Purpose**: Primary database for all app data

**Features**:
- Real-time synchronization
- Offline persistence
- Automatic scaling
- Powerful querying
- Compound indexes
- Security rules

### 2.3 Cloud Storage

**Purpose**: Store user-uploaded images

**Buckets**:
- `product-images/` - Product images
- `user-avatars/` - User profile pictures
- `review-images/` - Review photos
- `category-images/` - Category images

### 2.4 Cloud Functions

**Purpose**: Server-side business logic

**Use Cases**:
- Order processing
- Payment integration
- Email notifications
- Inventory management
- Analytics aggregation
- Scheduled tasks

### 2.5 Cloud Messaging (FCM)

**Purpose**: Push notifications

**Notification Types**:
- Order status updates
- Price drop alerts
- Back in stock notifications
- Promotional offers
- Delivery updates

### 2.6 Firebase Analytics & Crashlytics

**Purpose**: App analytics and crash reporting

**Tracked Events**:
- User engagement
- E-commerce events
- Conversion tracking
- App crashes and errors

---

## 3. Firestore Database Structure

### Database Architecture

```
firestore/
├── users/                          # User profiles
│   └── {userId}/
│       ├── profile: {...}
│       ├── addresses/              # Subcollection
│       │   └── {addressId}: {...}
│       ├── wishlists/              # Subcollection
│       │   └── {wishlistId}: {...}
│       ├── subscriptions/          # Subcollection
│       │   └── {subscriptionId}: {...}
│       └── recentlyViewed/         # Subcollection
│           └── {productId}: {timestamp}
│
├── products/                       # Product catalog
│   └── {productId}/
│       ├── details: {...}
│       ├── reviews/                # Subcollection
│       │   └── {reviewId}: {...}
│       ├── questions/              # Subcollection
│       │   └── {questionId}/
│       │       └── answers/        # Nested collection
│       │           └── {answerId}: {...}
│       └── inventory: {stock, variants}
│
├── categories/                     # Product categories
│   └── {categoryId}: {...}
│
├── orders/                         # All orders
│   └── {orderId}/
│       ├── details: {...}
│       ├── statusUpdates: [...]    # Array
│       └── items: [...]            # Array
│
├── coupons/                        # Promotional coupons
│   └── {couponId}: {...}
│
├── notifications/                  # User notifications
│   └── {userId}/
│       └── {notificationId}: {...}
│
├── cart/                           # Shopping carts
│   └── {userId}/
│       └── items: [...]
│
├── admin/                          # Admin data
│   ├── analytics/
│   │   └── {date}: {metrics}
│   └── config/
│       └── settings: {...}
│
└── metadata/                       # App metadata
    ├── version: {...}
    └── features: {...}
```

### Detailed Collection Schemas

#### 3.1 Users Collection

**Path**: `/users/{userId}`

```typescript
interface UserDocument {
  uid: string;
  email: string;
  profile: {
    fullName: string;
    phoneNumber?: string;
    avatarUrl?: string;
    bio?: string;
    birthDate?: Timestamp;
    gender?: string;
  };
  loyaltyPoints: number;
  memberSince: Timestamp;
  preferences: {
    emailNotifications: boolean;
    pushNotifications: boolean;
    smsNotifications: boolean;
    priceAlerts: boolean;
    promotionalEmails: boolean;
    orderUpdates: boolean;
  };
  stats: {
    totalOrders: number;
    totalSpent: number;
    productsReviewed: number;
    wishlistItems: number;
    averageOrderValue: number;
  };
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Subcollections**:

**`/users/{userId}/addresses/{addressId}`**
```typescript
interface Address {
  id: string;
  fullName: string;
  phoneNumber: string;
  addressLine1: string;
  addressLine2?: string;
  city: string;
  state: string;
  country: string;
  zipCode: string;
  landmark?: string;
  type: 'home' | 'work' | 'other';
  isDefault: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**`/users/{userId}/wishlists/{wishlistId}`**
```typescript
interface Wishlist {
  id: string;
  name: string;
  type: 'general' | 'birthday' | 'wedding' | 'christmas' | 'custom';
  description?: string;
  isPrivate: boolean;
  productIds: string[];  // Array of product IDs
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### 3.2 Products Collection

**Path**: `/products/{productId}`

```typescript
interface ProductDocument {
  id: string;
  name: string;
  description: string;
  price: number;
  originalPrice?: number;
  currency: string;  // 'USD'
  imageUrl: string;
  images: string[];
  category: string;
  categoryRef: DocumentReference;  // Reference to category
  brand: string;
  rating: number;
  reviewCount: number;
  inStock: boolean;
  inventory: {
    quantity: number;
    lowStockThreshold: number;
    trackInventory: boolean;
  };
  variants: {
    sizes: string[];
    colors: string[];
  };
  tags: string[];
  featured: boolean;
  trending: boolean;
  newArrival: boolean;
  metadata: {
    views: number;
    purchases: number;
    addedToCartCount: number;
    wishlistCount: number;
  };
  seo: {
    metaTitle: string;
    metaDescription: string;
    keywords: string[];
  };
  createdAt: Timestamp;
  updatedAt: Timestamp;
  publishedAt?: Timestamp;
  status: 'draft' | 'published' | 'archived';
}
```

**Subcollections**:

**`/products/{productId}/reviews/{reviewId}`**
```typescript
interface Review {
  id: string;
  userId: string;
  userRef: DocumentReference;
  userName: string;
  userAvatar?: string;
  rating: number;
  title: string;
  comment: string;
  images: string[];
  isVerifiedPurchase: boolean;
  helpfulCount: number;
  notHelpfulCount: number;
  helpfulBy: string[];  // Array of user IDs
  createdAt: Timestamp;
  updatedAt: Timestamp;
  moderationStatus: 'pending' | 'approved' | 'rejected';
}
```

**`/products/{productId}/questions/{questionId}`**
```typescript
interface Question {
  id: string;
  userId: string;
  userRef: DocumentReference;
  userName: string;
  question: string;
  helpfulCount: number;
  answerCount: number;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**`/products/{productId}/questions/{questionId}/answers/{answerId}`**
```typescript
interface Answer {
  id: string;
  userId: string;
  userRef: DocumentReference;
  userName: string;
  answer: string;
  isVerifiedPurchase: boolean;
  isOfficial: boolean;
  helpfulCount: number;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### 3.3 Orders Collection

**Path**: `/orders/{orderId}`

```typescript
interface OrderDocument {
  id: string;
  orderNumber: string;  // Human-readable: ORD-20251121-0001
  userId: string;
  userRef: DocumentReference;

  items: Array<{
    productId: string;
    productRef: DocumentReference;
    name: string;
    imageUrl: string;
    price: number;
    quantity: number;
    selectedSize?: string;
    selectedColor?: string;
    subtotal: number;
  }>;

  pricing: {
    subtotal: number;
    discount: number;
    shippingCost: number;
    tax: number;
    total: number;
  };

  couponCode?: string;
  couponRef?: DocumentReference;

  status: 'pending' | 'confirmed' | 'processing' | 'shipped' |
          'outForDelivery' | 'delivered' | 'cancelled' | 'returned' | 'refunded';

  paymentMethod: 'creditCard' | 'debitCard' | 'paypal' |
                  'applePay' | 'googlePay' | 'cashOnDelivery';

  paymentStatus: 'pending' | 'processing' | 'completed' | 'failed' | 'refunded';

  paymentDetails: {
    transactionId?: string;
    paymentProvider?: string;
    last4Digits?: string;
  };

  shippingAddress: {
    fullName: string;
    phoneNumber: string;
    addressLine1: string;
    addressLine2?: string;
    city: string;
    state: string;
    country: string;
    zipCode: string;
    landmark?: string;
  };

  billingAddress?: {/* same as shipping */};

  trackingNumber?: string;
  trackingUrl?: string;

  orderDate: Timestamp;
  estimatedDelivery?: Timestamp;
  deliveryDate?: Timestamp;

  statusUpdates: Array<{
    status: string;
    timestamp: Timestamp;
    notes?: string;
  }>;

  isGift: boolean;
  giftMessage?: string;

  orderNotes?: string;

  metadata: {
    deviceInfo?: string;
    ipAddress?: string;
    userAgent?: string;
  };

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### 3.4 Coupons Collection

**Path**: `/coupons/{couponId}`

```typescript
interface CouponDocument {
  id: string;
  code: string;  // Unique, uppercase
  title: string;
  description: string;
  type: 'percentage' | 'fixed';
  value: number;
  minPurchaseAmount?: number;
  maxDiscountAmount?: number;
  validFrom: Timestamp;
  validUntil: Timestamp;
  isActive: boolean;
  usageLimit: number;
  usedCount: number;
  usagePerUser: number;
  applicableCategories?: string[];
  applicableProducts?: string[];
  excludedProducts?: string[];
  requiresMinItems?: number;
  firstTimeUserOnly: boolean;
  createdBy: string;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### 3.5 Categories Collection

**Path**: `/categories/{categoryId}`

```typescript
interface CategoryDocument {
  id: string;
  name: string;
  slug: string;
  description: string;
  iconName: string;
  imageUrl: string;
  parentCategory?: string;
  subcategories: string[];
  productCount: number;
  order: number;
  isActive: boolean;
  featured: boolean;
  seo: {
    metaTitle: string;
    metaDescription: string;
  };
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

#### 3.6 Notifications Collection

**Path**: `/notifications/{userId}/messages/{notificationId}`

```typescript
interface NotificationDocument {
  id: string;
  userId: string;
  title: string;
  message: string;
  type: 'order' | 'priceAlert' | 'backInStock' | 'promotion' |
        'delivery' | 'review' | 'general';
  imageUrl?: string;
  actionUrl?: string;
  data?: Record<string, any>;
  isRead: boolean;
  readAt?: Timestamp;
  createdAt: Timestamp;
  expiresAt?: Timestamp;
}
```

#### 3.7 Cart Collection

**Path**: `/cart/{userId}`

```typescript
interface CartDocument {
  userId: string;
  items: Array<{
    productId: string;
    productRef: DocumentReference;
    quantity: number;
    selectedSize?: string;
    selectedColor?: string;
    addedAt: Timestamp;
  }>;
  saveForLater: Array<{/* same as items */}>;
  lastUpdated: Timestamp;
  expiresAt: Timestamp;  // Auto-delete after 30 days
}
```

---

## 4. Authentication Strategy

### 4.1 Authentication Flow

```
User Sign Up/Login
       │
       ├─→ Email/Password ──→ Create Auth User
       ├─→ Google Sign-In ──→ OAuth Flow
       ├─→ Apple Sign-In ──→ OAuth Flow
       └─→ Guest Checkout ──→ Anonymous Auth
       │
       ├─→ Create/Update User Document in Firestore
       ├─→ Set Custom Claims (if admin/vendor)
       ├─→ Generate FCM Token
       └─→ Navigate to Home
```

### 4.2 Custom Claims

Used for role-based access control:

```typescript
{
  role: 'user' | 'admin' | 'vendor',
  loyaltyTier: 'bronze' | 'silver' | 'gold' | 'platinum',
  emailVerified: boolean,
  accountStatus: 'active' | 'suspended' | 'banned'
}
```

Set via Cloud Functions:
```typescript
admin.auth().setCustomUserClaims(uid, {
  role: 'admin',
  loyaltyTier: 'gold'
});
```

### 4.3 Security

- **Password Requirements**: Min 8 chars, 1 uppercase, 1 number
- **Email Verification**: Required for certain actions
- **Rate Limiting**: Prevent brute force attacks
- **Session Management**: Automatic token refresh
- **Multi-factor Authentication**: Optional for users

---

## 5. Cloud Functions

### 5.1 Function Categories

#### A. Order Functions

**`onOrderCreated`** - Trigger: onCreate
```typescript
export const onOrderCreated = functions.firestore
  .document('orders/{orderId}')
  .onCreate(async (snap, context) => {
    const order = snap.data();

    // 1. Update inventory
    await updateInventory(order.items);

    // 2. Process payment
    await processPayment(order);

    // 3. Send confirmation email
    await sendOrderConfirmationEmail(order);

    // 4. Send push notification
    await sendOrderNotification(order.userId, order.id);

    // 5. Update user stats
    await updateUserStats(order.userId, order.pricing.total);

    // 6. Add loyalty points
    await addLoyaltyPoints(order.userId, order.pricing.total);
  });
```

**`onOrderStatusUpdate`** - Trigger: onUpdate
```typescript
export const onOrderStatusUpdate = functions.firestore
  .document('orders/{orderId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.status !== after.status) {
      // Send status update notification
      await sendStatusUpdateNotification(after);

      // If delivered, request review
      if (after.status === 'delivered') {
        await scheduleReviewRequest(after.userId, after.id);
      }
    }
  });
```

#### B. User Functions

**`onUserCreated`** - Trigger: onCreate (Auth)
```typescript
export const onUserCreated = functions.auth
  .user()
  .onCreate(async (user) => {
    // Create user document in Firestore
    await admin.firestore().collection('users').doc(user.uid).set({
      uid: user.uid,
      email: user.email,
      profile: {
        fullName: user.displayName || '',
        avatarUrl: user.photoURL || '',
      },
      loyaltyPoints: 0,
      memberSince: admin.firestore.FieldValue.serverTimestamp(),
      preferences: {
        emailNotifications: true,
        pushNotifications: true,
        smsNotifications: false,
        priceAlerts: true,
        promotionalEmails: true,
        orderUpdates: true,
      },
      stats: {
        totalOrders: 0,
        totalSpent: 0,
        productsReviewed: 0,
        wishlistItems: 0,
        averageOrderValue: 0,
      },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Send welcome email
    await sendWelcomeEmail(user.email);
  });
```

#### C. Product Functions

**`onReviewCreated`** - Trigger: onCreate
```typescript
export const onReviewCreated = functions.firestore
  .document('products/{productId}/reviews/{reviewId}')
  .onCreate(async (snap, context) => {
    const { productId } = context.params;
    const review = snap.data();

    // Update product rating
    await updateProductRating(productId);

    // Award loyalty points
    await addLoyaltyPoints(review.userId, 10); // 10 points for review

    // Notify product watchers
    await notifyProductWatchers(productId, 'New review added');
  });
```

**`updateInventory`** - Callable function
```typescript
export const updateInventory = functions.https.onCall(async (data, context) => {
  // Verify admin
  if (!context.auth?.token.role === 'admin') {
    throw new functions.https.HttpsError('permission-denied', 'Admin only');
  }

  const { productId, quantity } = data;

  await admin.firestore().collection('products').doc(productId).update({
    'inventory.quantity': admin.firestore.FieldValue.increment(quantity),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});
```

#### D. Notification Functions

**`sendPriceDropAlert`** - Scheduled function
```typescript
export const sendPriceDropAlert = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async (context) => {
    // Get products with price drops
    const priceDrops = await detectPriceDrops();

    // Get users watching these products
    for (const drop of priceDrops) {
      const watchers = await getProductWatchers(drop.productId);

      for (const userId of watchers) {
        await sendNotification(userId, {
          title: 'Price Drop Alert!',
          message: `${drop.productName} is now ${drop.discount}% off!`,
          type: 'priceAlert',
          data: { productId: drop.productId },
        });
      }
    }
  });
```

#### E. Analytics Functions

**`aggregateDailyStats`** - Scheduled function
```typescript
export const aggregateDailyStats = functions.pubsub
  .schedule('every day 00:00')
  .timeZone('America/New_York')
  .onRun(async (context) => {
    const yesterday = getYesterdayDate();

    const stats = {
      orders: await getOrderStats(yesterday),
      revenue: await getRevenueStats(yesterday),
      users: await getUserStats(yesterday),
      products: await getProductStats(yesterday),
    };

    await admin.firestore()
      .collection('admin')
      .doc('analytics')
      .collection('daily')
      .doc(yesterday)
      .set(stats);
  });
```

#### F. Coupon Functions

**`validateCoupon`** - Callable function
```typescript
export const validateCoupon = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be logged in');
  }

  const { code, cartTotal, userId } = data;

  const coupon = await getCouponByCode(code);

  if (!coupon) {
    return { valid: false, error: 'Invalid coupon code' };
  }

  // Check validity
  const now = admin.firestore.Timestamp.now();
  if (coupon.validUntil < now) {
    return { valid: false, error: 'Coupon expired' };
  }

  // Check usage limit
  if (coupon.usedCount >= coupon.usageLimit) {
    return { valid: false, error: 'Coupon usage limit reached' };
  }

  // Check user usage
  const userUsage = await getUserCouponUsage(userId, coupon.id);
  if (userUsage >= coupon.usagePerUser) {
    return { valid: false, error: 'You have already used this coupon' };
  }

  // Check min purchase
  if (coupon.minPurchaseAmount && cartTotal < coupon.minPurchaseAmount) {
    return {
      valid: false,
      error: `Minimum purchase of $${coupon.minPurchaseAmount} required`
    };
  }

  // Calculate discount
  let discount = 0;
  if (coupon.type === 'percentage') {
    discount = cartTotal * (coupon.value / 100);
  } else {
    discount = coupon.value;
  }

  if (coupon.maxDiscountAmount && discount > coupon.maxDiscountAmount) {
    discount = coupon.maxDiscountAmount;
  }

  return {
    valid: true,
    discount,
    couponId: coupon.id
  };
});
```

---

## 6. Security Rules

### 6.1 Firestore Security Rules

**`firestore.rules`**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper functions
    function isSignedIn() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }

    function isAdmin() {
      return isSignedIn() &&
             request.auth.token.role == 'admin';
    }

    function isVerified() {
      return isSignedIn() &&
             request.auth.token.email_verified == true;
    }

    // Users collection
    match /users/{userId} {
      allow read: if isOwner(userId) || isAdmin();
      allow create: if isOwner(userId);
      allow update: if isOwner(userId) || isAdmin();
      allow delete: if isAdmin();

      // Addresses subcollection
      match /addresses/{addressId} {
        allow read, write: if isOwner(userId);
      }

      // Wishlists subcollection
      match /wishlists/{wishlistId} {
        allow read: if isOwner(userId) ||
                      (!resource.data.isPrivate);
        allow write: if isOwner(userId);
      }

      // Subscriptions subcollection
      match /subscriptions/{subscriptionId} {
        allow read, write: if isOwner(userId);
      }

      // Recently viewed subcollection
      match /recentlyViewed/{productId} {
        allow read, write: if isOwner(userId);
      }
    }

    // Products collection
    match /products/{productId} {
      allow read: if true;  // Public read
      allow create, update, delete: if isAdmin();

      // Reviews subcollection
      match /reviews/{reviewId} {
        allow read: if true;  // Public read
        allow create: if isSignedIn() && isVerified();
        allow update: if isOwner(resource.data.userId) || isAdmin();
        allow delete: if isOwner(resource.data.userId) || isAdmin();
      }

      // Questions subcollection
      match /questions/{questionId} {
        allow read: if true;  // Public read
        allow create: if isSignedIn();
        allow update, delete: if isOwner(resource.data.userId) || isAdmin();

        // Answers nested collection
        match /answers/{answerId} {
          allow read: if true;  // Public read
          allow create: if isSignedIn();
          allow update, delete: if isOwner(resource.data.userId) || isAdmin();
        }
      }
    }

    // Categories collection
    match /categories/{categoryId} {
      allow read: if true;  // Public read
      allow write: if isAdmin();
    }

    // Orders collection
    match /orders/{orderId} {
      allow read: if isOwner(resource.data.userId) || isAdmin();
      allow create: if isSignedIn() &&
                      isOwner(request.resource.data.userId);
      allow update: if isAdmin();  // Only admins can update orders
      allow delete: if isAdmin();
    }

    // Coupons collection
    match /coupons/{couponId} {
      allow read: if isSignedIn();  // Users can view available coupons
      allow write: if isAdmin();
    }

    // Notifications collection
    match /notifications/{userId}/messages/{notificationId} {
      allow read: if isOwner(userId);
      allow update: if isOwner(userId);  // For marking as read
      allow create, delete: if isAdmin();
    }

    // Cart collection
    match /cart/{userId} {
      allow read, write: if isOwner(userId);
    }

    // Admin collection
    match /admin/{document=**} {
      allow read, write: if isAdmin();
    }

    // Metadata collection
    match /metadata/{document} {
      allow read: if true;  // Public read for app config
      allow write: if isAdmin();
    }
  }
}
```

### 6.2 Storage Security Rules

**`storage.rules`**

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    function isSignedIn() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    function isAdmin() {
      return request.auth.token.role == 'admin';
    }

    function isImage() {
      return request.resource.contentType.matches('image/.*');
    }

    function isSizeValid() {
      return request.resource.size < 5 * 1024 * 1024;  // 5MB
    }

    // Product images
    match /product-images/{productId}/{fileName} {
      allow read: if true;  // Public read
      allow write: if isAdmin() && isImage() && isSizeValid();
    }

    // User avatars
    match /user-avatars/{userId}/{fileName} {
      allow read: if true;  // Public read
      allow write: if isOwner(userId) && isImage() && isSizeValid();
    }

    // Review images
    match /review-images/{userId}/{fileName} {
      allow read: if true;  // Public read
      allow write: if isOwner(userId) && isImage() && isSizeValid();
    }

    // Category images
    match /category-images/{fileName} {
      allow read: if true;  // Public read
      allow write: if isAdmin() && isImage() && isSizeValid();
    }
  }
}
```

---

## 7. Storage Architecture

### 7.1 Folder Structure

```
gs://[project-id].appspot.com/
├── product-images/
│   └── {productId}/
│       ├── main.jpg
│       ├── image-1.jpg
│       ├── image-2.jpg
│       └── thumbnails/
│           ├── main_thumb.jpg
│           └── image-1_thumb.jpg
│
├── user-avatars/
│   └── {userId}/
│       ├── avatar.jpg
│       └── avatar_thumb.jpg
│
├── review-images/
│   └── {userId}/
│       └── {reviewId}/
│           ├── image-1.jpg
│           └── image-2.jpg
│
└── category-images/
    └── {categoryId}/
        ├── banner.jpg
        └── icon.jpg
```

### 7.2 Image Optimization

Use Cloud Functions to automatically generate thumbnails:

```typescript
export const generateThumbnail = functions.storage
  .object()
  .onFinalize(async (object) => {
    const filePath = object.name;
    const bucket = admin.storage().bucket(object.bucket);

    // Skip if already a thumbnail
    if (filePath.includes('thumb')) {
      return null;
    }

    // Generate thumbnail using Sharp
    const thumbnail = await sharp(bucket.file(filePath))
      .resize(200, 200)
      .toBuffer();

    const thumbPath = filePath.replace(/(\.[\w\d_-]+)$/i, '_thumb$1');

    await bucket.file(thumbPath).save(thumbnail);
  });
```

---

## 8. Real-time Features

### 8.1 Real-time Order Tracking

```dart
// In Flutter app
Stream<OrderEnhanced> watchOrder(String orderId) {
  return FirebaseFirestore.instance
    .collection('orders')
    .doc(orderId)
    .snapshots()
    .map((doc) => OrderEnhanced.fromFirestore(doc));
}
```

### 8.2 Real-time Cart Sync

```dart
Stream<List<CartItem>> watchCart(String userId) {
  return FirebaseFirestore.instance
    .collection('cart')
    .doc(userId)
    .snapshots()
    .map((doc) => parseCartItems(doc));
}
```

### 8.3 Real-time Notifications

```dart
Stream<List<AppNotification>> watchNotifications(String userId) {
  return FirebaseFirestore.instance
    .collection('notifications')
    .doc(userId)
    .collection('messages')
    .orderBy('createdAt', descending: true)
    .limit(50)
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => AppNotification.fromFirestore(doc))
        .toList());
}
```

---

## 9. API Service Layer

### Flutter Service Architecture

```
lib/
└── services/
    ├── firebase/
    │   ├── auth_service.dart
    │   ├── firestore_service.dart
    │   ├── storage_service.dart
    │   └── messaging_service.dart
    ├── api/
    │   ├── products_api.dart
    │   ├── orders_api.dart
    │   ├── user_api.dart
    │   └── reviews_api.dart
    └── repositories/
        ├── product_repository.dart
        ├── order_repository.dart
        └── user_repository.dart
```

---

## 10. Scalability & Performance

### 10.1 Firestore Indexes

**Composite Indexes Required**:

```yaml
# firestore.indexes.json
{
  "indexes": [
    {
      "collectionGroup": "products",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "price", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "products",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "featured", "order": "DESCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "orders",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "orderDate", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "reviews",
      "queryScope": "COLLECTION_GROUP",
      "fields": [
        { "fieldPath": "rating", "order": "DESCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

### 10.2 Caching Strategy

- **Firestore Persistence**: Enable offline persistence
- **Memory Cache**: Cache frequently accessed data
- **CDN**: Use Firebase Hosting CDN for static assets
- **Image CDN**: Cloudflare/Imgix for image optimization

### 10.3 Query Optimization

- Limit query results (use pagination)
- Use collection group queries sparingly
- Avoid deep nesting
- Use cursors for pagination

---

## 11. Deployment Strategy

### 11.1 Environment Setup

```bash
# Development
firebase use development

# Staging
firebase use staging

# Production
firebase use production
```

### 11.2 Deployment Checklist

- [ ] Update security rules
- [ ] Deploy Cloud Functions
- [ ] Create indexes
- [ ] Set environment variables
- [ ] Test in staging
- [ ] Monitor after deployment
- [ ] Set up alerts

---

## Cost Estimation

### Monthly Cost (for 10,000 active users):

| Service | Estimated Cost |
|---------|---------------|
| Firestore (reads/writes) | $50-100 |
| Cloud Functions | $20-50 |
| Cloud Storage | $10-20 |
| Cloud Messaging | Free |
| Authentication | Free |
| Hosting | Free |
| **Total** | **$80-170/month** |

*Scales automatically with usage*

---

## Conclusion

This Firebase architecture provides:

✅ **Scalability** - Automatic scaling
✅ **Real-time** - Live updates across devices
✅ **Security** - Granular security rules
✅ **Performance** - Optimized queries and caching
✅ **Reliability** - 99.95% uptime SLA
✅ **Cost-effective** - Pay-as-you-go pricing
✅ **Developer-friendly** - Easy integration

---

**Next Steps**: Implementation of service layer and provider migration
