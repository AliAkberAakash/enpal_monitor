import 'package:enpal_monitor/features/usage_monitor/util/usage_unit.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

sealed class UsageMonitorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsageMonitorLoadingState extends UsageMonitorState {}

class UsageMonitorLoadedState extends UsageMonitorState {
  final List<FlSpot> usageData;
  final UsageUnit usageUnit;

  UsageMonitorLoadedState({required this.usageData, required this.usageUnit});

  @override
  List<Object?> get props => [usageData, usageUnit];
}

class UsageMonitorDeletedState extends UsageMonitorState {}

class UsageMonitorErrorState extends UsageMonitorState {
  final String errorMessage;

  UsageMonitorErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
