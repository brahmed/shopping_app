import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/connectivity_service.dart';
import '../../services/sync_manager.dart';

/// Connectivity banner widget that shows network status
class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    final syncState = ref.watch(syncManagerStateProvider);

    // Don't show banner if online and nothing is syncing
    if (connectivityStatus == ConnectivityStatus.online &&
        syncState.pendingCount == 0 &&
        syncState.status != SyncStatus.syncing) {
      return const SizedBox.shrink();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: _buildBannerContent(context, ref, connectivityStatus, syncState),
    );
  }

  Widget _buildBannerContent(
    BuildContext context,
    WidgetRef ref,
    ConnectivityStatus status,
    SyncState syncState,
  ) {
    // Show sync status if syncing
    if (syncState.status == SyncStatus.syncing) {
      return _buildSyncingBanner(context);
    }

    // Show sync success briefly
    if (syncState.status == SyncStatus.success) {
      return _buildSuccessBanner(context);
    }

    // Show sync failed
    if (syncState.status == SyncStatus.failed) {
      return _buildFailedBanner(context, ref, syncState.message);
    }

    // Show offline banner
    if (status == ConnectivityStatus.offline) {
      return _buildOfflineBanner(context, syncState.pendingCount);
    }

    // Show pending sync count if online but has pending
    if (syncState.pendingCount > 0) {
      return _buildPendingSyncBanner(context, ref, syncState.pendingCount);
    }

    return const SizedBox.shrink();
  }

  Widget _buildOfflineBanner(BuildContext context, int pendingCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.orange[700],
      child: Row(
        children: [
          const Icon(
            Icons.cloud_off,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Working Offline',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (pendingCount > 0)
                  Text(
                    '$pendingCount change${pendingCount > 1 ? 's' : ''} will sync when online',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  )
                else
                  const Text(
                    'Some data may be outdated',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncingBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue[700],
      child: const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Syncing data...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.green[700],
      child: const Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Sync completed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedBanner(
    BuildContext context,
    WidgetRef ref,
    String? message,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.red[700],
      child: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sync failed',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (message != null)
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(syncManagerStateProvider.notifier).retryFailed();
            },
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingSyncBanner(
    BuildContext context,
    WidgetRef ref,
    int pendingCount,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.amber[700],
      child: Row(
        children: [
          const Icon(
            Icons.sync,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$pendingCount change${pendingCount > 1 ? 's' : ''} pending sync',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(syncManagerStateProvider.notifier).syncNow();
            },
            child: const Text(
              'Sync Now',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sync button for manual sync trigger
class SyncButton extends ConsumerWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncManagerStateProvider);
    final isOnline = ref.watch(isOnlineProvider);

    if (!isOnline) {
      return IconButton(
        icon: const Icon(Icons.cloud_off),
        onPressed: null,
        tooltip: 'Offline',
      );
    }

    if (syncState.status == SyncStatus.syncing) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return IconButton(
      icon: Badge(
        label: syncState.pendingCount > 0
            ? Text('${syncState.pendingCount}')
            : null,
        isLabelVisible: syncState.pendingCount > 0,
        child: const Icon(Icons.sync),
      ),
      onPressed: () {
        ref.read(syncManagerStateProvider.notifier).syncNow();
      },
      tooltip: 'Sync data',
    );
  }
}

/// Offline indicator icon
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    if (isOnline) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange[700],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(
            'Offline',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
