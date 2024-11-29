import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const int _networkTimeoutDurationSeconds = 10;
const String _stagingUrl = "http://10.0.2.2:3000/";
const String _prodUrl = "http://10.0.2.2:3000/";
const String _contentTypeJson = 'application/json';

/// Here we could change the baseUrl based on the
/// BuildMode of the app or the Flavor
/// baseUrl: (kDebugMode) ? _stagingUrl : _prodUrl
/// For the sake of simplicity I'm using only the
/// Production url here
BaseOptions configureDio() {
  final options = BaseOptions(
    baseUrl: (kDebugMode) ? _stagingUrl : _prodUrl,
    contentType: _contentTypeJson,
    responseType: ResponseType.json,
    sendTimeout: const Duration(seconds: _networkTimeoutDurationSeconds),
    receiveTimeout: const Duration(seconds: _networkTimeoutDurationSeconds),
  );

  return options;
}
