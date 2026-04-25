import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_admin_instructor/core/errors/exceptions.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/api_interceptor.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<Either<String, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<String, T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<String, T>> getRaw<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleRawResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<String, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<String, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<String, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return Left(DioExceptionHandler.handleException(e));
    }
  }

  Either<String, T> _handleResponse<T>(
    Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    log("The Response: $response");
    try {
      final responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        final bool success = responseData['success'] ?? false;
        final int status = responseData['status'] ?? response.statusCode ?? 0;
        final String message = responseData['message'] ?? 'Unknown error';

        if (success && (status == 200 || status == 201)) {
          if (fromJson != null) {
            return Right(fromJson(responseData));
          } else {
            return Right(responseData as T);
          }
        } else {
          return Left(message);
        }
      }
      return const Left('Unexpected response format');
    } catch (e) {
      return Left('Error parsing response: ${e.toString()}');
    }
  }

  Either<String, T> _handleRawResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    log("The Response (Raw): $response");
    try {
      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (fromJson != null) {
          return Right(fromJson(responseData));
        } else {
          try {
            return Right(responseData as T);
          } catch (e) {
            return Left(
              'Type mismatch: expected $T, got ${responseData.runtimeType}',
            );
          }
        }
      } else {
        return Left('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error parsing raw response: ${e.toString()}');
    }
  }
}
