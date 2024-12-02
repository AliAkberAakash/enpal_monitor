import 'package:dio/dio.dart';
import 'package:enpal_monitor/core/network/dio_configuration.dart';
import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/e2e/fake_network_client_impl.dart';
import 'package:enpal_monitor/features/common/error/error_message_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_local_dao.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/usage_monitor_local_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/data/local/usage_monitor_local_data_source_impl.dart';
import 'package:enpal_monitor/features/usage_monitor/data/mapper/usage_monitor_mapper.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source.dart';
import 'package:enpal_monitor/features/usage_monitor/data/network/usage_monitor_network_data_source_impl.dart';
import 'package:enpal_monitor/features/usage_monitor/data/repository/usage_monitor_repository_impl.dart';
import 'package:enpal_monitor/features/usage_monitor/domain/repository/usage_monitor_repository.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/date_selector_cubit/date_selector_cubit.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/bloc/usage_monitor_bloc/usage_monitor_bloc.dart';
import 'package:enpal_monitor/features/usage_monitor/util/usage_type.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

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
    // () => DioNetworkClient(
    //   getIt.get(),
    //   interceptors: [PrettyDioLogger()],
    // ),
    () => FakeNetworkClientImpl(),
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

  getIt.registerLazySingleton<UsageMonitorDataLocalDao>(
    () => UsageMonitorDataLocalDao.instance,
  );

  getIt.registerLazySingleton<UsageMonitorLocalDataSource>(
    () => UsageMonitorLocalDataSourceImpl(getIt.get()),
  );

  getIt.registerLazySingleton<UsageMonitorRepository>(
    () => UsageMonitorRepositoryImpl(
      getIt.get(),
      getIt.get(),
      getIt.get(),
    ),
  );

  getIt.registerLazySingleton<ErrorMessageMapper>(
    () => ErrorMessageMapperImpl(),
  );

  getIt.registerFactoryParam<UsageMonitorBloc, UsageType, void>(
    (type, _) => UsageMonitorBloc(
      getIt.get(),
      getIt.get(),
      type,
    ),
  );

  getIt.registerFactory<DateSelectorCubit>(
    () => DateSelectorCubit(DateTime.now()),
  );
}
