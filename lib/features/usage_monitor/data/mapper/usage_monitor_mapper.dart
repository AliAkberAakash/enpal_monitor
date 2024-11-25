import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';

abstract class UsageMonitorMapper {
  UsageMonitorEntity entityFromUsageMonitorNetworkResponse(
    final UsageMonitorResponse usageMonitorResponse,
  );

  BaseError errorFromException(final dynamic e);
}

class UsageMonitorEntityMapperImpl implements UsageMonitorMapper {
  @override
  UsageMonitorEntity entityFromUsageMonitorNetworkResponse(
      UsageMonitorResponse usageMonitorResponse) {
    return UsageMonitorEntity(
      usageMonitorResponse.timestamp,
      usageMonitorResponse.value,
    );
  }

  @override
  BaseError errorFromException(final dynamic e) {
    switch (e.runtimeType) {
      case const (ServerException):
        e as ServerException;
        return ServerError(
            statusCode: e.statusCode, statusMessage: e.statusMessage);
      case const (NetworkException):
        return NetworkError();
      case const (NetworkTimeoutException):
        return NetworkTimeoutError();
      default:
        return CommonError();
    }
  }
}
