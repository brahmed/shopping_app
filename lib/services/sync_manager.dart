import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/database/app_database.dart';
import 'connectivity_service.dart';
import 'offline_queue_service.dart';

/// Sync status enum
enum SyncStatus {
  idle,
  syncing,
  success,
  failed,
}

/// Sync state model
class SyncState {
  final SyncStatus status;
  final String? message;
  final DateTime? lastSyncTime;
  final int pendingCount;
  final int failedCount;

  const SyncState({
    this.status = SyncStatus.idle,
    this.message,
    this.lastSyncTime,
    this.pendingCount = 0,
    this.failedCount = 0,
  });

  SyncState copyWith({
    SyncStatus? status,
    String? message,
    DateTime? lastSyncTime,
    int? pendingCount,
    int? failedCount,
  }) {
    return SyncState(
      status: status ?? this.status,
      message: message ?? this.message,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      pendingCount: pendingCount ?? this.pendingCount,
      failedCount: failedCount ?? this.failedCount,
    );
  }
}

/// Sync manager for coordinating all sync operations
class SyncManager {
  final AppDatabase _db;
  final ConnectivityService _connectivityService;
  final OfflineQueueService _offlineQueueService;

  StreamSubscription<ConnectivityStatus>? _connectivitySubscription;
  Timer? _periodicSyncTimer;

  // Callbacks for specific entity syncs
  final List<Future<void> Function()> _syncCallbacks = [];

  SyncManager(
    this._db,
    this._connectivityService,
    this._offlineQueueService,
  ) {
    _initializeAutoSync();
  }

  /// Initialize automatic sync on connectivity changes
  void _initializeAutoSync() {
    // Listen to connectivity changes
    _connectivitySubscription =
        _connectivityService.statusStream.listen((status) {
      if (status == ConnectivityStatus.online) {
        // Auto-sync when coming back online
        syncAll();
      }
    });

    // Periodic sync every 15 minutes when online
    _periodicSyncTimer = Timer.periodic(
      const Duration(minutes: 15),
      (timer) {
        if (_connectivityService.isOnline) {
          syncAll();
        }
      },
    );
  }

  /// Register a sync callback for a specific entity
  void registerSyncCallback(Future<void> Function() callback) {
    _syncCallbacks.add(callback);
  }

  /// Sync all data
  Future<void> syncAll() async {
    if (!_connectivityService.isOnline) {
      throw OfflineException('Cannot sync while offline');
    }

    try {
      // 1. Process offline queue first (write operations)
      await _offlineQueueService.processQueue();

      // 2. Sync all entities (read operations)
      for (final callback in _syncCallbacks) {
        await callback();
      }

      // 3. Update sync metadata
      await _db.updateSyncMetadata('all', 'success');
    } catch (e) {
      await _db.updateSyncMetadata(
        'all',
        'failed',
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Sync specific entity type
  Future<void> syncEntity(
    String entityType,
    Future<void> Function() syncCallback,
  ) async {
    if (!_connectivityService.isOnline) {
      throw OfflineException('Cannot sync while offline');
    }

    try {
      await syncCallback();
      await _db.updateSyncMetadata(entityType, 'success');
    } catch (e) {
      await _db.updateSyncMetadata(
        entityType,
        'failed',
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Force sync (manual trigger)
  Future<void> forceSync() async {
    return syncAll();
  }

  /// Get last sync time for entity
  Future<DateTime?> getLastSyncTime(String entityType) async {
    return _db.getLastSyncTime(entityType);
  }

  /// Check if entity needs sync (based on cache age)
  Future<bool> needsSync(String entityType, Duration maxAge) async {
    final lastSync = await getLastSyncTime(entityType);
    if (lastSync == null) return true;

    final now = DateTime.now();
    final age = now.difference(lastSync);
    return age > maxAge;
  }

  /// Get pending operations count
  Future<int> getPendingCount() async {
    return _offlineQueueService.getPendingCount();
  }

  /// Get failed operations count
  Future<int> getFailedCount() async {
    return _offlineQueueService.getFailedCount();
  }

  /// Retry failed operations
  Future<void> retryFailedOperations() async {
    return _offlineQueueService.retryFailedOperations();
  }

  /// Clear completed operations
  Future<void> clearCompletedOperations() async {
    return _offlineQueueService.clearCompletedOperations();
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _periodicSyncTimer?.cancel();
  }
}

/// Sync manager state notifier
class SyncManagerNotifier extends StateNotifier<SyncState> {
  final SyncManager _syncManager;
  Timer? _statusUpdateTimer;

  SyncManagerNotifier(this._syncManager) : super(const SyncState()) {
    _initializeStatusUpdates();
  }

  /// Initialize periodic status updates
  void _initializeStatusUpdates() {
    _updateCounts();

    // Update counts every 5 seconds
    _statusUpdateTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => _updateCounts(),
    );
  }

  /// Update pending and failed counts
  Future<void> _updateCounts() async {
    final pendingCount = await _syncManager.getPendingCount();
    final failedCount = await _syncManager.getFailedCount();

    state = state.copyWith(
      pendingCount: pendingCount,
      failedCount: failedCount,
    );
  }

  /// Trigger manual sync
  Future<void> syncNow() async {
    state = state.copyWith(
      status: SyncStatus.syncing,
      message: 'Syncing data...',
    );

    try {
      await _syncManager.forceSync();

      state = state.copyWith(
        status: SyncStatus.success,
        message: 'Sync completed successfully',
        lastSyncTime: DateTime.now(),
      );

      // Update counts
      await _updateCounts();

      // Reset to idle after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(
            status: SyncStatus.idle,
            message: null,
          );
        }
      });
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.failed,
        message: e.toString(),
      );

      // Reset to idle after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          state = state.copyWith(
            status: SyncStatus.idle,
            message: null,
          );
        }
      });
    }
  }

  /// Retry failed operations
  Future<void> retryFailed() async {
    state = state.copyWith(
      status: SyncStatus.syncing,
      message: 'Retrying failed operations...',
    );

    try {
      await _syncManager.retryFailedOperations();

      state = state.copyWith(
        status: SyncStatus.success,
        message: 'Retry completed',
      );

      await _updateCounts();

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(
            status: SyncStatus.idle,
            message: null,
          );
        }
      });
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.failed,
        message: e.toString(),
      );

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          state = state.copyWith(
            status: SyncStatus.idle,
            message: null,
          );
        }
      });
    }
  }

  /// Clear completed operations
  Future<void> clearCompleted() async {
    await _syncManager.clearCompletedOperations();
    await _updateCounts();
  }

  @override
  void dispose() {
    _statusUpdateTimer?.cancel();
    super.dispose();
  }
}

/// Provider for sync manager
final syncManagerProvider = Provider<SyncManager>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);
  final offlineQueueService = ref.watch(offlineQueueServiceProvider);

  final manager = SyncManager(db, connectivityService, offlineQueueService);
  ref.onDispose(() => manager.dispose());
  return manager;
});

/// Provider for sync manager state
final syncManagerStateProvider =
    StateNotifierProvider<SyncManagerNotifier, SyncState>((ref) {
  final syncManager = ref.watch(syncManagerProvider);
  return SyncManagerNotifier(syncManager);
});
