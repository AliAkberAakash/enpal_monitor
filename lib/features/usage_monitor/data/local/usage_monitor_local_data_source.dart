import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_data_local.dart';

abstract class UsageMonitorLocalDataSource {
  Future<List<UsageMonitorDataLocal>> getUsageMonitorResponse({
    required final String date,
    required final String type,
  });

  Future<void> insertUsageMonitorData({
    required final List<UsageMonitorDataLocal> data,
  });

  Future<void> deleteByCommonId({
    required final String commonId,
  });

  Future<void> deleteAllData();
}
