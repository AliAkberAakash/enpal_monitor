import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error_keys.dart';

abstract class ExceptionToErrorKeyMapper {
  ErrorKey map({required final dynamic e});
}

class ExceptionToErrorKeyMapperImpl implements ExceptionToErrorKeyMapper {
  @override
  ErrorKey map({required final dynamic e}) {
    switch (e.runtimeType) {
      case ServerException _:
        return ErrorKey.serverError;
      case NetworkException _:
        return ErrorKey.networkError;
      case NetworkTimeoutException _:
        return ErrorKey.networkTimeOutError;
      default:
        return ErrorKey.commonError;
    }
  }
}
