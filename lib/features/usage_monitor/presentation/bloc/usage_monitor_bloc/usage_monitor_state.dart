import 'package:enpal_monitor/features/usage_monitor/domain/error/error.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

sealed class UsageMonitorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsageMonitorLoadingState extends UsageMonitorState {}

class UsageMonitorLoadedState extends UsageMonitorState {
  final List<FlSpot> usageData;

  UsageMonitorLoadedState({required this.usageData});

  @override
  List<Object?> get props => [usageData];
}

class UsageMonitorDeletedState extends UsageMonitorState {}

class UsageMonitorErrorState extends UsageMonitorState {
  final BaseError error;

  UsageMonitorErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
