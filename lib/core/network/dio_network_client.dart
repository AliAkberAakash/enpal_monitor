import 'package:dio/dio.dart';
import 'package:enpal_monitor/core/exceptions/base_exception.dart';
import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/core/network/network_response.dart';

/// Implementation of the [NetworkClient] interface using [Dio]
class DioNetworkClient implements NetworkClient {
  final Dio _dio;
  final List<Interceptor> interceptors;

  /// Creates a new instance of [DioNetworkClient]
  /// It's better to have a singleton [dio] object and pass it here via
  /// dependency injection.
  /// Sets any interceptors passed to it
  DioNetworkClient(
    this._dio, {
    this.interceptors = const [],
  }) {
    if (interceptors.isNotEmpty == true) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  /// Method to execute [GET] requests
  /// If the response is success it wraps the response into a [NetworkResponse] and returns it
  /// In case of failure it throws appropriate exceptions
  /// Check each of the exception classes to know more about them
  @override
  Future<NetworkResponse> get({required final NetworkRequest request}) async {
    try {
      final response = await _dio.get(
        request.url,
        options: _createDioOptions(request),
        queryParameters: request.queryParams,
      );
      return _handleResponse(response);
    } on DioException catch (error) {
      throw _handleDioExceptions(error);
    } on ServerException {
      rethrow;
    } catch (error) {
      throw const NetworkException();
    }
  }

  /// Creates dio options with headers sent via the [NetworkRequest]
  Options _createDioOptions(final NetworkRequest request) => Options(
        headers: request.headers ?? {},
      );

  /// Check if the response is valid
  /// If the response code is not in allowed range then throw [ServerException]
  /// Here any response code other than [200-299] is considered invalid
  NetworkResponse _handleResponse(final Response<dynamic> response) {
    if (_isInvalidStatusCode(response.statusCode)) {
      throw ServerException(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    }

    return NetworkResponse(
      body: response.data,
      headers: response.headers.map,
    );
  }

  /// Method to check if statusCode returned by the server is valid or not.
  bool _isInvalidStatusCode(final int? statusCode) {
    return statusCode == null || statusCode < 200 || statusCode >= 300;
  }

  /// handle the exception types to throw a proper exception
  BaseException _handleDioExceptions(final DioException error) {
    if (error.response != null) {
      throw ServerException(
        statusCode: error.response?.statusCode,
        statusMessage: error.response?.statusMessage,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkTimeoutException();
      default:
        throw const NetworkException();
    }
  }
}
