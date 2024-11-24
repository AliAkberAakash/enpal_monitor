import 'package:enpal_monitor/core/exceptions/base_exception.dart';

/// When the server returns a response, but it's not successful response
/// The [statusCode] is passed here so that upper layers can show a proper
/// message based on the [statusCode]
class ServerException extends BaseException {
  final int? statusCode;
  final String? statusMessage;

  const ServerException({
    this.statusCode,
    this.statusMessage,
  });

  @override
  List<Object?> get props => [
        statusCode,
        statusMessage,
      ];
}
