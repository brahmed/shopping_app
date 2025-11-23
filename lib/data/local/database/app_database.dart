import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// Products Table
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  RealColumn get originalPrice => real().nullable()();
  TextColumn get imageUrl => text()();
  TextColumn get images => text()(); // JSON array
  TextColumn get category => text()();
  RealColumn get rating => real()();
  IntColumn get reviewCount => integer()();
  BoolColumn get inStock => boolean()();
  TextColumn get sizes => text()(); // JSON array
  TextColumn get colors => text()(); // JSON array
  TextColumn get brand => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Categories Table
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconName => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Orders Table
class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get items => text()(); // JSON array
  RealColumn get subtotal => real()();
  RealColumn get discount => real()();
  RealColumn get shippingCost => real()();
  RealColumn get tax => real()();
  RealColumn get totalAmount => real()();
  TextColumn get status => text()();
  TextColumn get paymentStatus => text()();
  TextColumn get paymentMethod => text()();
  DateTimeColumn get orderDate => dateTime()();
  DateTimeColumn get deliveryDate => dateTime().nullable()();
  DateTimeColumn get estimatedDelivery => dateTime().nullable()();
  TextColumn get shippingAddress => text()(); // JSON
  TextColumn get billingAddress => text().nullable()(); // JSON
  TextColumn get trackingNumber => text().nullable()();
  TextColumn get couponCode => text().nullable()();
  TextColumn get orderNotes => text().nullable()();
  BoolColumn get isGift => boolean()();
  TextColumn get giftMessage => text().nullable()();
  TextColumn get statusUpdates => text()(); // JSON array
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Addresses Table
class Addresses extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get addressLine1 => text()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get country => text()();
  TextColumn get zipCode => text()();
  TextColumn get landmark => text().nullable()();
  BoolColumn get isDefault => boolean()();
  TextColumn get type => text()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Reviews Table
class Reviews extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text()();
  TextColumn get userId => text()();
  RealColumn get rating => real()();
  TextColumn get title => text().nullable()();
  TextColumn get comment => text()();
  BoolColumn get isVerified => boolean()();
  IntColumn get helpfulCount => integer()();
  DateTimeColumn get timestamp => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Wishlists Table
class Wishlists extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get products => text()(); // JSON array of product IDs
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isPrivate => boolean()();
  TextColumn get description => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Notifications Table
class Notifications extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get type => text()();
  DateTimeColumn get timestamp => dateTime()();
  BoolColumn get isRead => boolean()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get actionUrl => text().nullable()();
  TextColumn get data => text().nullable()(); // JSON
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Subscriptions Table
class Subscriptions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get productId => text()();
  IntColumn get quantity => integer()();
  TextColumn get frequency => text()();
  RealColumn get price => real()();
  TextColumn get status => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get nextDeliveryDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get totalOrders => integer()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Coupons Table
class Coupons extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get discountType => text()();
  RealColumn get discountValue => real()();
  RealColumn get minPurchase => real().nullable()();
  RealColumn get maxDiscount => real().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  BoolColumn get isActive => boolean()();
  IntColumn get usageLimit => integer().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Pending Operations Table (for offline queue)
class PendingOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operationType => text()(); // 'CREATE', 'UPDATE', 'DELETE'
  TextColumn get entityType => text()(); // 'order', 'review', 'address', etc.
  TextColumn get entityId => text()();
  TextColumn get endpoint => text()();
  TextColumn get method => text()(); // 'POST', 'PUT', 'PATCH', 'DELETE'
  TextColumn get payload => text()(); // JSON
  TextColumn get status => text()(); // 'pending', 'processing', 'failed', 'completed'
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();
}

// Cart Items Table
class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text()();
  TextColumn get productData => text()(); // JSON - full product data
  IntColumn get quantity => integer()();
  TextColumn get selectedSize => text().nullable()();
  TextColumn get selectedColor => text().nullable()();
  DateTimeColumn get addedAt => dateTime()();
}

// Favorites Table
class Favorites extends Table {
  TextColumn get productId => text()();
  TextColumn get productData => text()(); // JSON - full product data
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {productId};
}

// Recently Viewed Products Table
class RecentlyViewed extends Table {
  TextColumn get productId => text()();
  TextColumn get productData => text()(); // JSON - full product data
  DateTimeColumn get viewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {productId};
}

// Save For Later Table
class SaveForLater extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text()();
  TextColumn get productData => text()(); // JSON - full product data
  IntColumn get quantity => integer()();
  TextColumn get selectedSize => text().nullable()();
  TextColumn get selectedColor => text().nullable()();
  DateTimeColumn get savedAt => dateTime()();
}

// Sync Metadata Table (tracks last sync times)
class SyncMetadata extends Table {
  TextColumn get entityType => text()();
  DateTimeColumn get lastSyncAt => dateTime()();
  TextColumn get syncStatus => text()(); // 'success', 'failed', 'in_progress'
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {entityType};
}

@DriftDatabase(tables: [
  Products,
  Categories,
  Orders,
  Addresses,
  Reviews,
  Wishlists,
  Notifications,
  Subscriptions,
  Coupons,
  PendingOperations,
  CartItems,
  Favorites,
  RecentlyViewed,
  SaveForLater,
  SyncMetadata,
])
class AppDatabase extends _$AppDatabase {
  // Private constructor
  AppDatabase._internal() : super(_openConnection());

  // Singleton instance
  static final AppDatabase _instance = AppDatabase._internal();

  // Factory constructor returns singleton
  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
        // Example:
        // if (from < 2) {
        //   await m.addColumn(products, products.newColumn);
        // }
      },
    );
  }

  // Clear all data (useful for logout)
  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(products).go();
      await delete(categories).go();
      await delete(orders).go();
      await delete(addresses).go();
      await delete(reviews).go();
      await delete(wishlists).go();
      await delete(notifications).go();
      await delete(subscriptions).go();
      await delete(coupons).go();
      await delete(pendingOperations).go();
      await delete(cartItems).go();
      await delete(favorites).go();
      await delete(recentlyViewed).go();
      await delete(saveForLater).go();
      await delete(syncMetadata).go();
    });
  }

  // Clear cache data (keep user data like cart, favorites)
  Future<void> clearCacheData() async {
    await transaction(() async {
      await delete(products).go();
      await delete(categories).go();
      await delete(coupons).go();
    });
  }

  // Get unsynced pending operations
  Future<List<PendingOperation>> getPendingOperations() async {
    return await (select(pendingOperations)
          ..where((tbl) => tbl.status.equals('pending'))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)]))
        .get();
  }

  // Mark operation as completed
  Future<void> markOperationCompleted(int operationId) async {
    await (update(pendingOperations)
          ..where((tbl) => tbl.id.equals(operationId)))
        .write(
      PendingOperationsCompanion(
        status: const Value('completed'),
      ),
    );
  }

  // Mark operation as failed
  Future<void> markOperationFailed(
    int operationId,
    String errorMessage,
  ) async {
    final operation = await (select(pendingOperations)
          ..where((tbl) => tbl.id.equals(operationId)))
        .getSingleOrNull();

    if (operation != null) {
      await (update(pendingOperations)
            ..where((tbl) => tbl.id.equals(operationId)))
          .write(
        PendingOperationsCompanion(
          status: const Value('failed'),
          errorMessage: Value(errorMessage),
          retryCount: Value(operation.retryCount + 1),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Update sync metadata
  Future<void> updateSyncMetadata(
    String entityType,
    String status, {
    String? errorMessage,
  }) async {
    await into(syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion.insert(
        entityType: entityType,
        lastSyncAt: DateTime.now(),
        syncStatus: status,
        errorMessage: Value(errorMessage),
      ),
    );
  }

  // Get last sync time for entity type
  Future<DateTime?> getLastSyncTime(String entityType) async {
    final metadata = await (select(syncMetadata)
          ..where((tbl) => tbl.entityType.equals(entityType)))
        .getSingleOrNull();
    return metadata?.lastSyncAt;
  }
}

// Database connection
QueryExecutor _openConnection() {
  return driftDatabase(name: 'shopping_app_db');
}
