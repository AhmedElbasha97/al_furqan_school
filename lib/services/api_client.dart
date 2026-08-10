import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../globals/CommonSetting.dart';

/// Singleton Dio HTTP client shared by all service classes.
///
/// Features:
/// - Configured base URL, connection and receive timeouts.
/// - Request / Response / Error logging in debug mode.
/// - Centralised [DioException] handling that converts network errors
///   into clean [ApiException] objects so individual services don't
///   need repetitive try-catch boilerplate.
class ApiClient {
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  /// The single shared [ApiClient] instance.
  static ApiClient get instance => _instance;

  late final Dio _dio = _buildDio();

  /// The configured [Dio] instance to use for all HTTP calls.
  Dio get dio => _dio;

  Dio _buildDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        logPrint: (obj) => debugPrint('[ApiClient] $obj'),
      ));
    }

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) {
        debugPrint('[ApiClient] Error: ${e.type} — ${e.message}');
        handler.next(e);
      },
    ));

    return dio;
  }
}

/// A structured exception thrown by service helpers when an API call fails.
class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
