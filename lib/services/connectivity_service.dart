import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Connectivity status enum
enum ConnectivityStatus {
  online,
  offline,
  unknown,
}

/// Connectivity service to monitor network status
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream controller for connectivity status
  final StreamController<ConnectivityStatus> _statusController =
      StreamController<ConnectivityStatus>.broadcast();

  // Current connectivity status
  ConnectivityStatus _currentStatus = ConnectivityStatus.unknown;

  // Stream subscription
  StreamSubscription<ConnectivityResult>? _subscription;

  ConnectivityService() {
    _initialize();
  }

  /// Initialize connectivity monitoring
  Future<void> _initialize() async {
    // Get initial status
    final result = await _connectivity.checkConnectivity();
    _updateStatus([result]);

    // Listen to connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateStatus([result]);
      },
    );
  }

  /// Update connectivity status based on results
  void _updateStatus(List<ConnectivityResult> results) {
    // Check if any connection is available
    final hasConnection = results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn);

    final newStatus = hasConnection
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;

    if (_currentStatus != newStatus) {
      _currentStatus = newStatus;
      _statusController.add(_currentStatus);
    }
  }

  /// Get current connectivity status
  ConnectivityStatus get currentStatus => _currentStatus;

  /// Stream of connectivity status changes
  Stream<ConnectivityStatus> get statusStream => _statusController.stream;

  /// Check if currently online
  bool get isOnline => _currentStatus == ConnectivityStatus.online;

  /// Check if currently offline
  bool get isOffline => _currentStatus == ConnectivityStatus.offline;

  /// Check connectivity (returns future)
  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus([result]);
    return isOnline;
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }
}

/// Connectivity state notifier for Riverpod
class ConnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  final ConnectivityService _connectivityService;
  StreamSubscription<ConnectivityStatus>? _subscription;

  ConnectivityNotifier(this._connectivityService)
      : super(_connectivityService.currentStatus) {
    _initialize();
  }

  void _initialize() {
    // Set initial state
    state = _connectivityService.currentStatus;

    // Listen to changes
    _subscription = _connectivityService.statusStream.listen((status) {
      state = status;
    });
  }

  bool get isOnline => state == ConnectivityStatus.online;
  bool get isOffline => state == ConnectivityStatus.offline;

  Future<void> checkConnection() async {
    await _connectivityService.checkConnection();
    state = _connectivityService.currentStatus;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// Provider for connectivity service (singleton)
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for connectivity status
final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return ConnectivityNotifier(service);
});

/// Simple provider to check if online
final isOnlineProvider = Provider<bool>((ref) {
  final status = ref.watch(connectivityStatusProvider);
  return status == ConnectivityStatus.online;
});
