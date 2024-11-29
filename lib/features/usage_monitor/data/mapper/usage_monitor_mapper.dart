import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';

abstract class UsageMonitorMapper {
  UsageMonitorEntity entityFromUsageMonitorNetworkResponse(
    final UsageMonitorResponse usageMonitorResponse,
  );

  List<UsageMonitorEntity> entityListFromUsageMonitorNetworkResponse(
    final List<UsageMonitorResponse> responseList,
  );

  BaseError errorFromException(final dynamic e);
}

class UsageMonitorEntityMapperImpl implements UsageMonitorMapper {
  @override
  UsageMonitorEntity entityFromUsageMonitorNetworkResponse(
      UsageMonitorResponse usageMonitorResponse) {
    return UsageMonitorEntity(
      usageMonitorResponse.timestamp.millisecondsSinceEpoch.toDouble(),
      usageMonitorResponse.value.toDouble(),
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

  @override
  List<UsageMonitorEntity> entityListFromUsageMonitorNetworkResponse(
    List<UsageMonitorResponse> responseList,
  ) {
    return _aggregateData(responseList);
  }

  List<UsageMonitorEntity> _aggregateData(List<UsageMonitorResponse> points) {
    const int interval = 12;
    return List.generate((points.length / interval).ceil(), (index) {
      final sublist = points.skip(index * interval).take(interval);
      final avgValue =
          sublist.map((p) => p.value).reduce((a, b) => a + b) / sublist.length;
      return UsageMonitorEntity(
        sublist.first.timestamp.millisecondsSinceEpoch.toDouble(),
        // Use the timestamp of the first point in the interval
        avgValue.floorToDouble(),
      );
    });
  }
}
