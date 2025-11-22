# Offline-First Architecture Documentation

## 📋 Overview

This shopping app has been transformed into a **robust offline-first application** that provides a seamless user experience regardless of network connectivity. The app can function completely offline, queue changes made while disconnected, and automatically synchronize data when connectivity returns.

---

## 🎯 Key Features

✅ **Offline-First Data Access** - App remains fully functional without network
✅ **Local Database Persistence** - Drift SQLite database for structured data
✅ **Automatic Caching** - Smart caching strategies with staleness detection
✅ **Offline Queue System** - Queue write operations when offline
✅ **Auto-Sync** - Automatically sync when connectivity returns
✅ **Conflict Resolution** - Predictable conflict handling strategies
✅ **Network Awareness** - Real-time connectivity monitoring
✅ **Error Resilience** - Graceful error handling with timeouts
✅ **UI Feedback** - Clear offline indicators and sync status

---

## 🏗️ Architecture Layers

### 1. Data Layer

#### **Local Data Sources** (`lib/data/local/`)
- `app_database.dart` - Drift database with 15 tables
- `products_local_data_source.dart` - Local product operations
- `orders_local_data_source.dart` - Local order operations
- **Responsibilities:**
  - Cache management
  - Local CRUD operations
  - Query optimization
  - Data persistence

#### **Remote Data Sources** (`lib/data/remote/`)
- `api_client.dart` - Dio HTTP client with interceptors
- `products_remote_data_source.dart` - Product API calls
- `orders_remote_data_source.dart` - Order API calls
- **Responsibilities:**
  - HTTP requests
  - Response parsing
  - Error handling
  - Timeout management

### 2. Repository Layer (`lib/repositories/`)

**Pattern:** Repository Pattern with Strategy-Based Caching

#### **ProductsRepository** - Offline-First Strategy
```
Strategy: Cache-First → Network → Fallback to Cache

1. Read from local cache immediately (if available)
2. Check cache freshness (1 hour TTL)
3. If stale and online → fetch from API
4. Update cache with fresh data
5. If offline or network fails → return cached data
6. If no cache and offline → throw OfflineException
```

#### **OrdersRepository** - Online-First Strategy
```
Strategy: Network-First → Fallback to Cache → Queue Writes

READS:
1. Try to fetch from API if online
2. Update cache with fresh data
3. If offline or network fails → return cached data
4. If no cache → throw OfflineException

WRITES:
1. Try to execute on server if online
2. If succeeds → update local cache
3. If fails or offline → queue operation + update cache optimistically
4. Mark as unsynced in database
5. Auto-retry when connectivity returns
```

### 3. Services Layer (`lib/services/`)

#### **ConnectivityService**
- Monitors network status using `connectivity_plus`
- Provides real-time status stream
- Detects WiFi, Mobile, Ethernet, VPN connections
- Used by repositories to decide online/offline strategy

#### **OfflineQueueService**
- Manages pending operations table
- Queues: CREATE, UPDATE, DELETE operations
- Retry logic with exponential backoff (2s, 4s, 8s, 16s)
- Max 3 retry attempts per operation
- Auto-processes queue when online
- **Operation Flow:**
  1. User action while offline
  2. Save to `pending_operations` table
  3. Update local cache optimistically
  4. When online → process queue in order
  5. On success → mark completed
  6. On failure → increment retry count

#### **SyncManager**
- Coordinates all sync operations
- Manual sync trigger (user initiated)
- Periodic sync every 15 minutes when online
- Registers entity-specific sync callbacks
- Tracks sync metadata and status
- **Sync Flow:**
  1. Process offline queue (writes)
  2. Sync all entities (reads)
  3. Update sync metadata
  4. Notify UI of status

### 4. Providers Layer (`lib/providers/`)

#### **ProductsProvider** (Offline-First)
```dart
State:
- products: List<Product>
- categories: List<Category>
- isLoading: bool
- error: String?
- isOfflineMode: bool  // NEW
- lastSync: DateTime?   // NEW

Methods:
- loadProducts({forceRefresh}) // Uses offline-first repo
- refresh()                     // Force refresh from server
```

#### **OrdersProvider** (Online-First)
```dart
State:
- orders: List<OrderEnhanced>
- isLoading: bool
- error: String?
- isOfflineMode: bool      // NEW
- pendingSyncCount: int    // NEW

Methods:
- addOrder(order)          // Queues if offline
- cancelOrder(orderId)     // Queues if offline
- updateOrderStatus(...)   // Queues if offline
- refresh()                // Manual sync
```

### 5. UI Layer (`lib/widgets/app/`)

#### **ConnectivityBanner**
- Shows network status at top of screen
- **States:**
  - Offline: Orange banner "Working Offline"
  - Syncing: Blue banner with progress indicator
  - Success: Green banner "Sync completed"
  - Failed: Red banner with "Retry" button
  - Pending: Amber banner "$N changes pending sync"
- Auto-hides when online and synced

#### **SyncButton**
- Manual sync trigger button
- Shows pending count badge
- Disabled when offline
- Shows spinner while syncing

#### **OfflineIndicator**
- Small badge showing "Offline" status
- Displays in app bar
- Hidden when online

---

## 💾 Database Schema

### **Drift Tables** (15 total)

#### **Core Entities**
1. `products` - Product catalog with cache timestamp
2. `categories` - Product categories
3. `orders` - Order history with sync status
4. `addresses` - Shipping/billing addresses
5. `reviews` - Product reviews
6. `wishlists` - Multiple wishlists
7. `notifications` - App notifications
8. `subscriptions` - Recurring orders
9. `coupons` - Discount coupons

#### **Offline Support Tables**
10. `pending_operations` - Queue for offline writes
11. `cart_items` - Shopping cart
12. `favorites` - Favorite products
13. `recently_viewed` - Recently viewed products
14. `save_for_later` - Saved items
15. `sync_metadata` - Last sync times per entity

#### **Key Fields for Offline Support**
- `cachedAt: DateTime` - When data was cached
- `isSynced: bool` - Whether changes are synced
- `retryCount: int` - Number of retry attempts
- `status: String` - 'pending', 'processing', 'failed', 'completed'

---

## 📊 Data Flow Diagrams

### **READ Operations (Products - Offline-First)**
```
User opens app
       ↓
ProductsProvider.loadProducts()
       ↓
ProductsRepository.getProducts()
       ↓
┌─────────────────────────────┐
│ 1. Read from Local Cache    │
└──────────┬──────────────────┘
           ↓
    Has cached data?
           ↓
     ┌────┴────┐
    YES       NO
     ↓         ↓
Return Cache  Check Online
     ↓         ↓
Check if     ┌──┴──┐
  stale     YES   NO
     ↓       ↓     ↓
    YES    Fetch  Throw
     ↓      API  Offline
If Online   ↓   Exception
     ↓    Cache
  Fetch     ↓
   API    Return
     ↓
  Cache
     ↓
  Return
```

### **WRITE Operations (Orders - Queue Approach)**
```
User creates order
       ↓
OrdersProvider.addOrder()
       ↓
OrdersRepository.createOrder()
       ↓
    Is Online?
       ↓
  ┌────┴────┐
 YES       NO
  ↓         ↓
Try API   Queue Operation
  ↓         ↓
Success?  Save to DB
  ↓         (isSynced=false)
┌─┴─┐       ↓
YES NO    Return temp order
 ↓   ↓       ↓
Cache Queue When Online
 ↓     ↓       ↓
Return  ↓   Process Queue
       ↓       ↓
    Return  Try API
               ↓
           Success?
               ↓
           ┌───┴───┐
          YES     NO
           ↓       ↓
        Update  Retry with
         Cache  Backoff
```

---

## 🔄 Caching Strategies

### **Strategy Selection Guide**

| Entity Type | Strategy | TTL | Rationale |
|------------|----------|-----|-----------|
| Products | Offline-First | 1 hour | Catalog data changes infrequently, prioritize speed |
| Categories | Offline-First | N/A | Static data, rarely changes |
| Orders | Online-First | N/A | Transactional data needs server confirmation |
| Reviews | Offline-First | 30 min | User-generated content, can be stale briefly |
| Addresses | Offline-First | N/A | Personal data, rarely changes |
| Coupons | Online-First | 5 min | Time-sensitive, must be validated server-side |

### **Cache Invalidation**

**Time-Based (TTL)**
- Products: 1 hour
- Reviews: 30 minutes
- Automatic refresh on app start if stale

**Event-Based**
- User creates/updates → invalidate relevant cache
- Manual refresh → force fetch from server
- Logout → clear all caches

**Manual**
- Pull-to-refresh on list screens
- Sync button → force sync all entities

---

## ⚡ Conflict Resolution

### **Strategy: Last-Write-Wins with Server Authority**

#### **Products & Categories**
- **Strategy:** Server-Wins
- Server data always takes precedence
- Local changes not allowed
- Cache is read-only

#### **Orders**
- **Strategy:** Last-Write-Wins
- Order created offline gets temporary ID (`temp_uuid`)
- When synced, server returns real ID
- Local order updated with server ID
- Status updates follow temporal order

#### **Reviews**
- **Strategy:** Client-Wins on Create
- Reviews created offline stay pending
- Synced to server when online
- Server may reject duplicates

#### **Cart & Favorites**
- **Strategy:** Client-Authoritative
- Local changes always kept
- Not synced to server in MVP
- Stored only in local database

### **Conflict Scenarios**

**Scenario 1: Order Created Offline, Then Synced**
```
1. User creates order offline → temp_abc123
2. Saved to local DB with isSynced=false
3. Added to pending_operations queue
4. Connectivity returns
5. Queue processor tries to POST order
6. Server responds with real ID: ORD-789
7. Local order temp_abc123 deleted
8. Server order ORD-789 cached
9. UI updated with real order
```

**Scenario 2: Order Status Updated Offline**
```
1. User cancels order offline
2. Local order updated: status=cancelled, isSynced=false
3. Added to pending_operations queue
4. UI shows "Pending sync" badge
5. Connectivity returns
6. Queue processor PATCHes cancellation
7. Server confirms cancellation
8. Local order marked isSynced=true
9. Badge removed
```

**Scenario 3: Network Timeout During Fetch**
```
1. User opens products page
2. Repository tries to fetch from API
3. Request times out (30s)
4. TimeoutException caught
5. Fallback to cached products
6. UI shows cached data + "Using offline data" message
7. Background refresh scheduled
```

---

## 🔧 Error Handling

### **Custom Exception Types**

#### `OfflineException`
- **When:** No network and no cache
- **User Message:** "No internet connection and no cached data available"
- **UI Action:** Show retry button, guide to check connection

#### `NetworkException`
- **When:** Request fails (DNS, connection refused, etc.)
- **User Message:** "Network error: [details]"
- **UI Action:** Fallback to cache if available, show error toast

#### `TimeoutException`
- **When:** Request exceeds 30s timeout
- **User Message:** "Request timeout. Please try again."
- **UI Action:** Fallback to cache, allow retry

#### `ServerException`
- **When:** Server returns 5xx status
- **User Message:** "Server error: [message]"
- **UI Action:** Fallback to cache, log error for debugging

### **Error Handling Flow**
```dart
try {
  final data = await repository.getData();
  return data;
} on OfflineException catch (e) {
  // Show offline message, return empty state
  showOfflineMessage();
} on TimeoutException catch (e) {
  // Fallback to cache if available
  return cachedData ?? throw e;
} on NetworkException catch (e) {
  // Log error, fallback to cache
  logError(e);
  return cachedData ?? throw e;
} on ServerException catch (e) {
  // Show server error, allow retry
  showServerError(e.message);
} catch (e) {
  // Generic error handling
  showGenericError();
}
```

### **Timeouts**

All HTTP requests have 30-second timeouts:
- `connectTimeout: 30s`
- `receiveTimeout: 30s`
- `sendTimeout: 30s`

---

## 🔄 Synchronization

### **Auto-Sync Triggers**

1. **Connectivity Returns**
   - App automatically syncs when network restored
   - Processes offline queue first (writes)
   - Then refreshes all entities (reads)

2. **Periodic Sync**
   - Every 15 minutes when online
   - Only syncs if app is in foreground
   - Skips if already syncing

3. **App Launch**
   - Checks if cached data is stale
   - Refreshes stale entities in background
   - User sees cached data immediately

### **Manual Sync**

Users can trigger manual sync via:
- Sync button in app bar
- Pull-to-refresh on list screens
- Retry button on failed sync banner

### **Sync Priority Order**

1. **High Priority** (Process first)
   - Order creations
   - Order cancellations
   - Payment confirmations

2. **Medium Priority**
   - Review submissions
   - Address updates
   - Profile changes

3. **Low Priority**
   - Favorites
   - Recently viewed
   - Wishlist updates

### **Sync State Machine**

```
         ┌─────────┐
         │  IDLE   │
         └────┬────┘
              ↓
    User triggers sync
              ↓
         ┌────────────┐
    ┌───►│  SYNCING   │
    │    └─────┬──────┘
    │          ↓
    │    All operations
    │      processed?
    │          ↓
    │    ┌────┴────┐
    │   YES       NO
    │    ↓         ↓
    │ ┌─────┐  Any errors?
    │ │SUCCESS│    ↓
    │ └──┬──┘  ┌──┴──┐
    │    │    YES   NO
    │    │     ↓     │
    │    │  ┌──────┐ │
    │    │  │FAILED│ │
    │    │  └──┬───┘ │
    │    │     │     │
    │    └─────┴─────┘
    │          ↓
    │    Wait 3-5s
    │          ↓
    └────  Back to IDLE
```

---

## 🧪 Testing Offline Features

### **Simulating Offline Mode**

1. **Using Device/Emulator**
   - Toggle Airplane mode
   - Disable WiFi + Mobile data
   - Use Charles Proxy with breakpoints

2. **Using Code**
   ```dart
   // Force offline for testing
   final connectivityService = ref.read(connectivityServiceProvider);
   connectivityService._updateStatus([ConnectivityResult.none]);
   ```

3. **Using Build Flags**
   ```dart
   // In main.dart
   const bool forceOfflineMode = bool.fromEnvironment('OFFLINE_MODE');
   ```

### **Test Scenarios**

#### ✅ **Scenario 1: Browse Products Offline**
1. Load app with network
2. Browse products (cached)
3. Disable network
4. Close app
5. Reopen app
6. **Expected:** Products load from cache, offline banner shown

#### ✅ **Scenario 2: Create Order Offline**
1. Disable network
2. Add items to cart
3. Proceed to checkout
4. Create order
5. **Expected:** Order saved locally with temp ID, shows "Pending sync"
6. Enable network
7. **Expected:** Auto-sync triggers, order gets real ID

#### ✅ **Scenario 3: Network Timeout**
1. Use proxy to delay responses (>30s)
2. Try to load products
3. **Expected:** Timeout occurs, fallback to cache, error message shown

#### ✅ **Scenario 4: Queue Processing**
1. Make 5 changes offline (create review, cancel order, etc.)
2. Enable network
3. **Expected:** Queue processes in order, UI shows sync progress

---

## 📱 UI/UX Considerations

### **Offline Indicators**

1. **Connectivity Banner** (Top of screen)
   - Orange: "Working Offline"
   - Blue: "Syncing data..."
   - Green: "Sync completed"
   - Red: "Sync failed" + Retry button
   - Amber: "N changes pending sync" + Sync Now button

2. **Offline Badge** (App bar)
   - Small "Offline" indicator
   - Only shown when disconnected

3. **Sync Button** (App bar)
   - Badge shows pending count
   - Spinner when syncing
   - Disabled when offline

### **User Messages**

✅ **Good Messages**
- "Working offline. Some data may be outdated."
- "Your changes will be synced when you're back online."
- "3 orders pending sync"
- "Sync completed successfully"

❌ **Avoid These**
- "No internet connection" (obvious, not helpful)
- "Error 500" (technical jargon)
- "Failed to fetch data" (what should user do?)

### **Loading States**

- **First load:** Show skeleton/shimmer
- **Cached load:** Show data immediately, refresh in background
- **Offline load:** Show cached data + offline indicator
- **No cache:** Show empty state with helpful message

---

## 🚀 Future Enhancements

### **Phase 1 Completed** ✅
- ✅ Local database with Drift
- ✅ Connectivity monitoring
- ✅ Offline queue system
- ✅ Auto-sync on reconnect
- ✅ Error handling with custom exceptions
- ✅ UI feedback (banners, indicators)
- ✅ Repository pattern with caching strategies

### **Phase 2 - Next Steps** 🔄

1. **Background Sync with Workmanager**
   - Periodic background sync
   - Process queue even when app closed
   - Battery-efficient scheduling

2. **Advanced Conflict Resolution**
   - CRDT (Conflict-free Replicated Data Types)
   - Operational transformation
   - User-guided conflict resolution UI

3. **Optimistic UI Updates**
   - Immediate UI feedback
   - Rollback on server rejection
   - Pending state indicators

4. **Delta Sync**
   - Only sync changed data
   - Reduce bandwidth usage
   - Faster sync times

5. **Offline Analytics**
   - Track offline usage patterns
   - Monitor queue sizes
   - Identify sync bottlenecks

6. **Image Caching**
   - Offline image storage
   - Progressive image loading
   - Storage management

7. **Search Offline**
   - Full-text search in local DB
   - Indexed search fields
   - Fuzzy matching

---

## 📦 Dependencies Added

```yaml
# Core offline-first packages
drift: ^2.14.0                 # SQLite ORM
drift_flutter: ^0.1.0          # Flutter integration for Drift
connectivity_plus: ^5.0.2      # Network connectivity monitoring
dio: ^5.4.0                    # HTTP client with interceptors

# Supporting packages
workmanager: ^0.5.1            # Background tasks
path_provider: ^2.1.1          # File system paths
path: ^1.8.3                   # Path manipulation
uuid: ^4.2.2                   # Generate unique IDs

# Dev dependencies
drift_dev: ^2.14.0             # Code generation for Drift
build_runner: ^2.4.0           # Build system (existing)
```

---

## 🎓 Key Learnings & Best Practices

### **Do's** ✅

1. **Always fallback to cache** when network fails
2. **Queue write operations** when offline
3. **Show clear UI feedback** for offline state
4. **Implement timeouts** on all network requests
5. **Use typed exceptions** for better error handling
6. **Cache aggressively** but with TTL
7. **Test offline scenarios** thoroughly
8. **Provide manual sync** option for users

### **Don'ts** ❌

1. **Don't block UI** while syncing
2. **Don't lose user data** on network errors
3. **Don't show technical errors** to users
4. **Don't retry indefinitely** (max 3 attempts)
5. **Don't sync in background** without user consent
6. **Don't cache sensitive data** without encryption
7. **Don't assume online** is always better
8. **Don't forget to handle timeouts**

---

## 🔍 Architecture Checklist

### ✅ Completed Features

- [x] Local database with Drift (15 tables)
- [x] Connectivity service with real-time monitoring
- [x] API client with Dio + offline interceptors
- [x] Repository pattern (LocalDataSource + RemoteDataSource)
- [x] Offline queue system with retry logic
- [x] Sync manager with auto-sync
- [x] Products repository (offline-first)
- [x] Orders repository (online-first)
- [x] Updated ProductsProvider with offline support
- [x] Updated OrdersProvider with queue support
- [x] Connectivity banner widget
- [x] Sync button widget
- [x] Offline indicator widget
- [x] Error handling (4 exception types)
- [x] Network timeouts (30s)
- [x] Typed error states
- [x] Cache TTL management
- [x] Conflict resolution strategy
- [x] Architecture documentation

---

## 📞 Support & Contact

For questions or issues with the offline-first implementation:

1. **Check this documentation** first
2. **Review code comments** in repository files
3. **Test offline scenarios** as described in Testing section
4. **Check Drift documentation** for database queries
5. **Review Riverpod docs** for state management

---

## 📝 Summary

This Flutter shopping app now provides a **production-ready offline-first architecture** with:

- **Seamless offline experience** - App works without network
- **Smart caching** - Offline-first for products, online-first for orders
- **Automatic synchronization** - Changes sync when connectivity returns
- **Error resilience** - Graceful handling of timeouts and failures
- **Clear user feedback** - Banners and indicators for offline states
- **Predictable conflicts** - Last-write-wins with server authority
- **Type-safe implementation** - Custom exceptions and error states
- **Scalable architecture** - Repository pattern ready for expansion

The implementation follows **Flutter best practices** and provides a **solid foundation** for building reliable offline-first mobile applications.

---

**Last Updated:** 2025-11-22
**Version:** 1.0.0
**Status:** Production-Ready ✅
