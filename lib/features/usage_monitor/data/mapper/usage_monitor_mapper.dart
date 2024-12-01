import 'package:enpal_monitor/core/exceptions/network_exceptions.dart';
import 'package:enpal_monitor/core/exceptions/server_exception.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_data_local.dart';
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

  UsageMonitorEntity entityFromUsageMonitorDataLocal(
    final UsageMonitorDataLocal usageMonitorDataLocal,
  );

  List<UsageMonitorEntity> entityListFromUsageMonitorDataLocal(
    final List<UsageMonitorDataLocal> usageMonitorLocalDataList,
  );

  UsageMonitorDataLocal usageMonitorDataLocalFromNetworkResponse(
    final UsageMonitorResponse usageMonitorResponse,
    final String commonId,
  );

  List<UsageMonitorDataLocal> usageMonitorDataLocalListFromNetworkResponse(
    final List<UsageMonitorResponse> usageMonitorResponseList,
    final String commonId,
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
  List<UsageMonitorEntity> entityListFromUsageMonitorNetworkResponse(
    List<UsageMonitorResponse> responseList,
  ) {
    final entityList = responseList
        .map(
          (response) => entityFromUsageMonitorNetworkResponse(response),
        )
        .toList();
    return entityList;
  }

  @override
  UsageMonitorEntity entityFromUsageMonitorDataLocal(
      UsageMonitorDataLocal usageMonitorDataLocal) {
    return UsageMonitorEntity(
      usageMonitorDataLocal.timestamp.millisecondsSinceEpoch.toDouble(),
      usageMonitorDataLocal.value.toDouble(),
    );
  }

  @override
  List<UsageMonitorEntity> entityListFromUsageMonitorDataLocal(
    List<UsageMonitorDataLocal> usageMonitorLocalDataList,
  ) {
    final entityList = usageMonitorLocalDataList
        .map(
          (localData) => entityFromUsageMonitorDataLocal(localData),
        )
        .toList();
    return entityList;
  }

  @override
  UsageMonitorDataLocal usageMonitorDataLocalFromNetworkResponse(
    final UsageMonitorResponse usageMonitorResponse,
    final String commonId,
  ) {
    return UsageMonitorDataLocal(
      usageMonitorResponse.timestamp,
      usageMonitorResponse.value,
      commonId,
    );
  }

  @override
  List<UsageMonitorDataLocal> usageMonitorDataLocalListFromNetworkResponse(
    final List<UsageMonitorResponse> usageMonitorResponseList,
    final String commonId,
  ) {
    return usageMonitorResponseList
        .map(
          (response) => usageMonitorDataLocalFromNetworkResponse(
            response,
            commonId,
          ),
        )
        .toList();
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
