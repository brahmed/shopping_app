import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/database/app_database.dart';
import '../data/remote/api_client.dart';
import 'connectivity_service.dart';

/// Operation status enum
enum OperationStatus {
  pending,
  processing,
  completed,
  failed,
}

/// Pending operation model
class PendingOperationModel {
  final int? id;
  final String operationType; // 'CREATE', 'UPDATE', 'DELETE'
  final String entityType; // 'order', 'review', 'address', etc.
  final String entityId;
  final String endpoint;
  final String method; // 'POST', 'PUT', 'PATCH', 'DELETE'
  final Map<String, dynamic> payload;
  final OperationStatus status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final String? errorMessage;

  PendingOperationModel({
    this.id,
    required this.operationType,
    required this.entityType,
    required this.entityId,
    required this.endpoint,
    required this.method,
    required this.payload,
    this.status = OperationStatus.pending,
    this.retryCount = 0,
    required this.createdAt,
    this.lastAttemptAt,
    this.errorMessage,
  });

  PendingOperationModel copyWith({
    int? id,
    String? operationType,
    String? entityType,
    String? entityId,
    String? endpoint,
    String? method,
    Map<String, dynamic>? payload,
    OperationStatus? status,
    int? retryCount,
    DateTime? createdAt,
    DateTime? lastAttemptAt,
    String? errorMessage,
  }) {
    return PendingOperationModel(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Convert from database model
  factory PendingOperationModel.fromDb(PendingOperation dbModel) {
    return PendingOperationModel(
      id: dbModel.id,
      operationType: dbModel.operationType,
      entityType: dbModel.entityType,
      entityId: dbModel.entityId,
      endpoint: dbModel.endpoint,
      method: dbModel.method,
      payload: jsonDecode(dbModel.payload) as Map<String, dynamic>,
      status: OperationStatus.values.firstWhere(
        (e) => e.name == dbModel.status,
        orElse: () => OperationStatus.pending,
      ),
      retryCount: dbModel.retryCount,
      createdAt: dbModel.createdAt,
      lastAttemptAt: dbModel.lastAttemptAt,
      errorMessage: dbModel.errorMessage,
    );
  }

  // Convert to database companion
  PendingOperationsCompanion toDbCompanion() {
    return PendingOperationsCompanion.insert(
      operationType: operationType,
      entityType: entityType,
      entityId: entityId,
      endpoint: endpoint,
      method: method,
      payload: jsonEncode(payload),
      status: status.name,
      retryCount: Value(retryCount),
      createdAt: createdAt,
      lastAttemptAt: Value(lastAttemptAt),
      errorMessage: Value(errorMessage),
    );
  }
}

/// Offline queue service
class OfflineQueueService {
  final AppDatabase _db;
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;

  // Maximum retry attempts before marking as permanently failed
  static const int maxRetryAttempts = 3;

  // Delay between retries (exponential backoff)
  static const Duration initialRetryDelay = Duration(seconds: 2);

  bool _isProcessing = false;
  StreamSubscription<ConnectivityStatus>? _connectivitySubscription;

  OfflineQueueService(
    this._db,
    this._apiClient,
    this._connectivityService,
  ) {
    _initializeConnectivityListener();
  }

  /// Initialize connectivity listener to auto-sync when online
  void _initializeConnectivityListener() {
    _connectivitySubscription =
        _connectivityService.statusStream.listen((status) {
      if (status == ConnectivityStatus.online && !_isProcessing) {
        // Auto-sync when coming back online
        processQueue();
      }
    });
  }

  /// Add operation to queue
  Future<int> addOperation({
    required String operationType,
    required String entityType,
    required String entityId,
    required String endpoint,
    required String method,
    required Map<String, dynamic> payload,
  }) async {
    final operation = PendingOperationModel(
      operationType: operationType,
      entityType: entityType,
      entityId: entityId,
      endpoint: endpoint,
      method: method,
      payload: payload,
      createdAt: DateTime.now(),
    );

    final id = await _db.into(_db.pendingOperations).insert(
          operation.toDbCompanion(),
        );

    // Try to process immediately if online
    if (_connectivityService.isOnline) {
      processQueue();
    }

    return id;
  }

  /// Get all pending operations
  Future<List<PendingOperationModel>> getPendingOperations() async {
    final operations = await _db.getPendingOperations();
    return operations.map((op) => PendingOperationModel.fromDb(op)).toList();
  }

  /// Process the queue
  Future<void> processQueue() async {
    if (_isProcessing) return;
    if (!_connectivityService.isOnline) return;

    _isProcessing = true;

    try {
      final operations = await getPendingOperations();

      for (final operation in operations) {
        if (operation.retryCount >= maxRetryAttempts) {
          // Skip operations that have exceeded max retries
          continue;
        }

        await _processOperation(operation);

        // Small delay between operations to avoid overwhelming the server
        await Future.delayed(const Duration(milliseconds: 500));
      }
    } finally {
      _isProcessing = false;
    }
  }

  /// Process a single operation
  Future<void> _processOperation(PendingOperationModel operation) async {
    if (operation.id == null) return;

    try {
      // Mark as processing
      await _updateOperationStatus(
        operation.id!,
        OperationStatus.processing,
      );

      // Execute the API call based on method
      await _executeApiCall(operation);

      // Mark as completed
      await _db.markOperationCompleted(operation.id!);
    } catch (e) {
      // Mark as failed with error message
      await _db.markOperationFailed(
        operation.id!,
        e.toString(),
      );

      // Schedule retry with exponential backoff if not exceeded max attempts
      if (operation.retryCount < maxRetryAttempts - 1) {
        final delay = _calculateRetryDelay(operation.retryCount);
        Future.delayed(delay, () {
          if (_connectivityService.isOnline) {
            processQueue();
          }
        });
      }
    }
  }

  /// Execute API call based on operation
  Future<void> _executeApiCall(PendingOperationModel operation) async {
    switch (operation.method.toUpperCase()) {
      case 'POST':
        await _apiClient.post(
          operation.endpoint,
          data: operation.payload,
        );
        break;

      case 'PUT':
        await _apiClient.put(
          operation.endpoint,
          data: operation.payload,
        );
        break;

      case 'PATCH':
        await _apiClient.patch(
          operation.endpoint,
          data: operation.payload,
        );
        break;

      case 'DELETE':
        await _apiClient.delete(
          operation.endpoint,
          data: operation.payload,
        );
        break;

      default:
        throw Exception('Unsupported HTTP method: ${operation.method}');
    }
  }

  /// Update operation status
  Future<void> _updateOperationStatus(
    int operationId,
    OperationStatus status,
  ) async {
    await (_db.update(_db.pendingOperations)
          ..where((tbl) => tbl.id.equals(operationId)))
        .write(
      PendingOperationsCompanion(
        status: Value(status.name),
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  /// Calculate retry delay with exponential backoff
  Duration _calculateRetryDelay(int retryCount) {
    final multiplier = 1 << retryCount; // 2^retryCount
    return initialRetryDelay * multiplier;
  }

  /// Get pending operations count
  Future<int> getPendingCount() async {
    final operations = await getPendingOperations();
    return operations.length;
  }

  /// Get failed operations count
  Future<int> getFailedCount() async {
    final query = _db.select(_db.pendingOperations)
      ..where((tbl) => tbl.status.equals('failed'));
    final results = await query.get();
    return results.length;
  }

  /// Retry failed operations
  Future<void> retryFailedOperations() async {
    final query = _db.select(_db.pendingOperations)
      ..where((tbl) => tbl.status.equals('failed'));
    final failedOps = await query.get();

    for (final op in failedOps) {
      if (op.retryCount < maxRetryAttempts) {
        await (_db.update(_db.pendingOperations)
              ..where((tbl) => tbl.id.equals(op.id)))
            .write(
          const PendingOperationsCompanion(
            status: Value('pending'),
          ),
        );
      }
    }

    // Process queue
    if (_connectivityService.isOnline) {
      await processQueue();
    }
  }

  /// Clear completed operations
  Future<void> clearCompletedOperations() async {
    await (_db.delete(_db.pendingOperations)
          ..where((tbl) => tbl.status.equals('completed')))
        .go();
  }

  /// Clear all operations (use with caution)
  Future<void> clearAllOperations() async {
    await _db.delete(_db.pendingOperations).go();
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}

/// Provider for offline queue service
final offlineQueueServiceProvider = Provider<OfflineQueueService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final apiClient = ref.watch(apiClientProvider);
  final connectivityService = ref.watch(connectivityServiceProvider);

  final service = OfflineQueueService(db, apiClient, connectivityService);
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for pending operations count
final pendingOperationsCountProvider = StreamProvider<int>((ref) async* {
  final service = ref.watch(offlineQueueServiceProvider);
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  // Yield initial count
  yield await service.getPendingCount();

  // Re-check on connectivity changes
  await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
    yield await service.getPendingCount();
  }
});

/// Database provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
