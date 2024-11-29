import 'package:dio/dio.dart';
import 'package:enpal_monitor/core/network/dio_configuration.dart';
import 'package:enpal_monitor/core/network/dio_network_client.dart';
import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/features/usage_monitor/data/mapper/usage_monitor_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source_impl.dart';
import 'package:enpal_monitor/features/usage_monitor/data/repository/usage_monitor_repository_impl.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.I;

void setup() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      configureDio(),
    ),
  );
  getIt.registerLazySingleton<Logger>(
    () => Logger(),
  );
  getIt.registerLazySingleton<NetworkClient>(
    () => DioNetworkClient(
      getIt.get(),
      interceptors: [PrettyDioLogger()],
    ),
  );
  getIt.registerLazySingleton<UsageMonitorNetworkDataSource>(
    () => UsageMonitorNetworkDataSourceImpl(
      getIt.get(),
      getIt.get(),
    ),
  );
  getIt.registerLazySingleton<UsageMonitorMapper>(
    () => UsageMonitorEntityMapperImpl(),
  );
  getIt.registerLazySingleton<UsageMonitorRepository>(
    () => UsageMonitorRepositoryImpl(
      getIt.get(),
      getIt.get(),
    ),
  );
  getIt.registerFactory<UsageMonitorBloc>(
    () => UsageMonitorBloc(getIt.get()),
  );
}
