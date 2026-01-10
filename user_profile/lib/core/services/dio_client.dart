import 'dart:io';
import 'package:dio/dio.dart';
import 'package:user_profile/core/constants/app_constants.dart';

// Custom exceptions for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException({String? message})
    : super(message: message ?? 'No internet connection');
}

class TimeoutException extends ApiException {
  TimeoutException({String? message})
    : super(message: message ?? 'Request timed out');
}

class ServerException extends ApiException {
  ServerException({String? message, super.statusCode})
    : super(message: message ?? 'Server error');
}

// Dio Client Service
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(seconds: AppConstants.connectionTimeout),
        receiveTimeout: Duration(seconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          return handler.next(response);
        },
        onError: (error, handler) {
          _logError(error);
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Handle Dio errors and convert to custom exceptions
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return NetworkException();
        }
        return NetworkException(message: 'Connection error');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        String message = 'Server error';

        if (statusCode != null) {
          if (statusCode >= 500) {
            message = 'Server error. Please try again later.';
          } else if (statusCode == 404) {
            message = 'Resource not found';
          } else if (statusCode == 401) {
            message = 'Unauthorized';
          } else if (statusCode == 403) {
            message = 'Forbidden';
          } else if (statusCode >= 400) {
            message = 'Bad request';
          }
        }

        return ServerException(message: message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled');

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkException();
        }
        return ApiException(message: 'Something went wrong');

      default:
        return ApiException(message: 'Something went wrong');
    }
  }

  // Log request details
  void _logRequest(RequestOptions options) {
    print('REQUEST: ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    if (options.data != null) {
      print('Data: ${options.data}');
    }
  }

  // Log response details
  void _logResponse(Response response) {
    print(
      'RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
    );
  }

  // Log error details
  void _logError(DioException error) {
    print('ERROR: ${error.type} ${error.message}');
    print('URL: ${error.requestOptions.uri}');
    if (error.response != null) {
      print('Status: ${error.response?.statusCode}');
      print('Data: ${error.response?.data}');
    }
  }
}
