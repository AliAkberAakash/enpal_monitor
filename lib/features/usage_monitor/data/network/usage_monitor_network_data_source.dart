import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';

abstract class UsageMonitorNetworkDataSource {
  Future<List<UsageMonitorResponse>> getUsageMonitorResponse({
    required final String date,
    required final String type,
  });
}
