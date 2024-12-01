import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';

abstract class UsageMonitorRepository {
  Future<List<UsageMonitorEntity>> getUsageMonitorData({
    required final String date,
    required final String type,
  });

  Future<void> deleteDeleteAllUsageMonitorData();
}
