import 'package:enpal_monitor/features/usage_monitor/data/local/usage_monitor_local_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/data/mapper/usage_monitor_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/dto/usage_monitor_response.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:flutter/foundation.dart';

class UsageMonitorRepositoryImpl implements UsageMonitorRepository {
  final UsageMonitorNetworkDataSource _networkDataSource;
  final UsageMonitorMapper _usageMonitorEntityMapper;
  final UsageMonitorLocalDataSource _usageMonitorLocalDataSource;

  UsageMonitorRepositoryImpl(
    this._networkDataSource,
    this._usageMonitorEntityMapper,
    this._usageMonitorLocalDataSource,
  );

  @override
  Future<List<UsageMonitorEntity>> getUsageMonitorData({
    required final String date,
    required final String type,
  }) async {
    try {
      /// First, try to get data from local storage
      final localData =
          await _usageMonitorLocalDataSource.getUsageMonitorResponse(
        date: date,
        type: type,
      );

      /// If local data exists, convert and return it
      if (localData.isNotEmpty) {
        return _usageMonitorEntityMapper
            .entityListFromUsageMonitorDataLocal(localData);
      }

      /// If no local data, fetch from network
      final responseList = await _networkDataSource.getUsageMonitorResponse(
        date: date,
        type: type,
      );

      /// Convert network response to local data
      final commonId = "$date-$type";
      final localDataToSave = _usageMonitorEntityMapper
          .usageMonitorDataLocalListFromNetworkResponse(
        responseList,
        commonId,
      );

      /// Save network data to local storage
      await _usageMonitorLocalDataSource
          .insertUsageMonitorData(localDataToSave);

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
  Future<void> deleteDeleteAllUsageMonitorData() async {
    await _usageMonitorLocalDataSource.deleteAllData();
  }
}
