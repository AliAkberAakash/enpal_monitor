import 'package:enpal_monitor/features/usage_monitor/data/mapper/usage_monitor_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:flutter/foundation.dart';

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
    try {
      final responseList = await _networkDataSource.getUsageMonitorResponse(
        date: date,
        type: type,
      );

      // TODO: save data in local and always return from cache

      final entityList =
          compute<List<UsageMonitorResponse>, List<UsageMonitorEntity>>(
        _usageMonitorEntityMapper.entityListFromUsageMonitorNetworkResponse,
        responseList,
      );

      return entityList;
    } catch (e) {
      throw _usageMonitorEntityMapper.errorFromException(e);
    }
  }

  @override
  Future<bool> deleteDeleteAllUsageMonitorData() async {
    // TODO: delete all local cache
    return true;
  }
}
