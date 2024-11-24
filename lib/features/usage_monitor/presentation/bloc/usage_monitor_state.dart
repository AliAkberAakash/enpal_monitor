import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error_keys.dart';
import 'package:equatable/equatable.dart';

sealed class UsageMonitorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsageMonitorLoadingState extends UsageMonitorState {}

class UsageMonitorLoadedState extends UsageMonitorState {
  final List<UsageMonitorEntity> usageData;

  UsageMonitorLoadedState({required this.usageData});

  @override
  List<Object?> get props => [usageData];
}

class UsageMonitorErrorState extends UsageMonitorState {
  final ErrorKey errorKey;

  UsageMonitorErrorState({required this.errorKey});

  @override
  List<Object?> get props => [errorKey];
}
