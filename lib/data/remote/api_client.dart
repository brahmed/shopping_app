import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/connectivity_service.dart';

/// Custom exceptions for API errors
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  NetworkException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}

class OfflineException implements Exception {
  final String message;

  OfflineException([this.message = 'No internet connection available']);

  @override
  String toString() => 'OfflineException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException([this.message = 'Request timeout']);

  @override
  String toString() => 'TimeoutException: $message';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// API Client using Dio with offline support
class ApiClient {
  late final Dio _dio;
  final ConnectivityService _connectivityService;

  // Base URL - replace with your actual API base URL
  static const String baseUrl = 'https://api.yourshop.com/v1';

  ApiClient(this._connectivityService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_createInterceptor());
  }

  /// Create custom interceptor for offline detection and error handling
  Interceptor _createInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check connectivity before making request
        if (!_connectivityService.isOnline) {
          return handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.connectionError,
              error: OfflineException(),
            ),
          );
        }

        // Add authorization token if available
        final token = await _getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle successful response
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        // Handle errors and convert to custom exceptions
        final customError = _handleError(error);

        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            type: error.type,
            error: customError,
            response: error.response,
          ),
        );
      },
    );
  }

  /// Get authentication token from storage
  Future<String?> _getAuthToken() async {
    // TODO: Implement token retrieval from secure storage
    // For now, return null or mock token
    return null;
  }

  /// Handle Dio errors and convert to custom exceptions
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.connectionError:
        if (error.error is OfflineException) {
          return error.error as OfflineException;
        }
        return NetworkException(
          'Connection failed. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ??
            error.response?.statusMessage ??
            'Unknown error occurred';

        if (statusCode != null && statusCode >= 500) {
          return ServerException(message, statusCode: statusCode);
        }
        return NetworkException(message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled');

      default:
        return NetworkException(
          'An unexpected error occurred: ${error.message}',
        );
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw e.error ?? e;
    }
  }
}

/// Provider for API client
final apiClientProvider = Provider<ApiClient>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return ApiClient(connectivityService);
});
