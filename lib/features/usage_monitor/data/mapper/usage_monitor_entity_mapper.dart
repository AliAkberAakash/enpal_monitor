import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';

abstract class UsageMonitorMapper {
  UsageMonitorEntity entityFromUsageMonitorNetworkResponse(
    final UsageMonitorResponse usageMonitorResponse,
  );
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
}
