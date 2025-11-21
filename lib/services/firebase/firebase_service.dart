import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

/// Central Firebase initialization and configuration service
class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    _instance ??= FirebaseService._();
    return _instance!;
  }

  FirebaseService._();

  // Firebase instances
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
  FirebasePerformance get performance => FirebasePerformance.instance;

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Initialize all Firebase services
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Configure Firebase services
      await _configureAuth();
      await _configureCrashlytics();
      await _configureMessaging();
      await _configureAnalytics();
      await _configurePerformance();

      _initialized = true;
      debugPrint('✅ Firebase initialized successfully');
    } catch (e) {
      debugPrint('❌ Firebase initialization error: $e');
      rethrow;
    }
  }

  /// Configure Firebase Authentication
  Future<void> _configureAuth() async {
    // Set persistence
    await auth.setPersistence(Persistence.LOCAL);

    // Listen to auth state changes
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        debugPrint('🔐 User signed in: ${user.uid}');
        _setUserForAnalytics(user);
      } else {
        debugPrint('🔓 User signed out');
      }
    });
  }

  /// Configure Crashlytics
  Future<void> _configureCrashlytics() async {
    if (kDebugMode) {
      // Disable Crashlytics in debug mode
      await crashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await crashlytics.setCrashlyticsCollectionEnabled(true);

      // Pass all uncaught errors to Crashlytics
      FlutterError.onError = crashlytics.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        crashlytics.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  /// Configure Firebase Messaging
  Future<void> _configureMessaging() async {
    // Request notification permissions (iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('🔔 Notification permission: ${settings.authorizationStatus}');

    // Get FCM token
    String? token = await messaging.getToken();
    debugPrint('📱 FCM Token: $token');

    // Listen for token refresh
    messaging.onTokenRefresh.listen((newToken) {
      debugPrint('📱 FCM Token refreshed: $newToken');
      // TODO: Send token to backend
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📬 Foreground message: ${message.notification?.title}');
      // TODO: Show local notification
    });

    // Handle message opened from terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📬 Message opened app: ${message.notification?.title}');
      // TODO: Navigate to relevant screen
    });
  }

  /// Configure Firebase Analytics
  Future<void> _configureAnalytics() async {
    await analytics.setAnalyticsCollectionEnabled(!kDebugMode);

    if (auth.currentUser != null) {
      _setUserForAnalytics(auth.currentUser!);
    }
  }

  /// Configure Firebase Performance
  Future<void> _configurePerformance() async {
    await performance.setPerformanceCollectionEnabled(!kDebugMode);
  }

  /// Set user properties for analytics
  void _setUserForAnalytics(User user) {
    analytics.setUserId(id: user.uid);
    analytics.setUserProperty(
      name: 'email',
      value: user.email,
    );
  }

  /// Log analytics event
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    await analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  /// Log screen view
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  /// Record error in Crashlytics
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    bool fatal = false,
  }) async {
    await crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Log message to Crashlytics
  void log(String message) {
    crashlytics.log(message);
  }

  /// Set custom key for crash reports
  Future<void> setCustomKey(String key, Object value) async {
    await crashlytics.setCustomKey(key, value);
  }

  /// Start performance trace
  Trace trace(String name) {
    return performance.newTrace(name);
  }

  /// Get FCM token
  Future<String?> getFCMToken() async {
    return await messaging.getToken();
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    debugPrint('📮 Subscribed to topic: $topic');
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    debugPrint('📭 Unsubscribed from topic: $topic');
  }
}
