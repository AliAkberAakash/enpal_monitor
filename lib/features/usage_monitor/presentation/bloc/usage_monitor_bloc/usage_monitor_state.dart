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
  final String errorMessage;

  UsageMonitorErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
