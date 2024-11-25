import 'package:enpal_monitor/features/usage_monitor/domain/entity/usage_monitor_entity.dart';
import 'package:enpal_monitor/features/usage_monitor/presentation/error/error.dart';
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

class UsageMonitorDeletedState extends UsageMonitorState {
  final bool success;

  UsageMonitorDeletedState(this.success);

  @override
  List<Object?> get props => [success];
}

class UsageMonitorErrorState extends UsageMonitorState {
  final BaseError error;

  UsageMonitorErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
