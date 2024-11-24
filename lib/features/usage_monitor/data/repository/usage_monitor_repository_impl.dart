import 'package:enpal_monitor/features/usage_monitor/data/mapper/usage_monitor_entity_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';

class UsageMonitorRepositoryImpl implements UsageMonitorRepository {
  final UsageMonitorNetworkDataSource _networkDataSource;
  final UsageMonitorMapper _usageMonitorEntityMapper;

  UsageMonitorRepositoryImpl(
    this._networkDataSource,
    this._usageMonitorEntityMapper,
  );

  @override
  Future<List<UsageMonitorEntity>> getUsageMonitorData({
    required final String date,
    required final String type,
  }) async {
    final responseList = await _networkDataSource.getUsageMonitorResponse(
      date: date,
      type: type,
    );

    // TODO: save data in local and always return from cache

    final entityList = responseList
        .map((response) => _usageMonitorEntityMapper
            .entityFromUsageMonitorNetworkResponse(response))
        .toList();

    return entityList;
  }
}
