import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';

abstract class UsageMonitorEntityMapper {
  UsageMonitorEntity fromUsageMonitorNetworkResponse(
      final UsageMonitorResponse usageMonitorResponse);
}

class UsageMonitorEntityMapperImpl implements UsageMonitorEntityMapper {
  @override
  UsageMonitorEntity fromUsageMonitorNetworkResponse(
      UsageMonitorResponse usageMonitorResponse) {
    return UsageMonitorEntity(
      usageMonitorResponse.timestamp,
      usageMonitorResponse.value,
    );
  }
}
