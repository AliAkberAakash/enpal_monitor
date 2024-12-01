import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_data_local.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_local_dao.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/usage_monitor_local_data_source.dart';

class UsageMonitorLocalDataSourceImpl implements UsageMonitorLocalDataSource {
  final UsageMonitorDataLocalDao dao;

  UsageMonitorLocalDataSourceImpl(this.dao);

  @override
  Future<List<UsageMonitorDataLocal>> getUsageMonitorResponse({
    required final String date,
    required final String type,
  }) async {
    final commonId = "$date-$type";
    final response = dao.getDataByCommonId(commonId);

    return response;
  }

  @override
  Future<void> insertUsageMonitorData(List<UsageMonitorDataLocal> data) async {
    await dao.insertBatch(data);
  }

  @override
  Future<void> deleteAllData() async {
    await dao.deleteAll();
  }
}
