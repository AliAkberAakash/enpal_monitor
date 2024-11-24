import 'package:enpal_monitor/core/exceptions/base_exception.dart';

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
