import 'package:equatable/equatable.dart';

sealed class UsageMonitorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsageMonitorEvent extends UsageMonitorEvent {
  final DateTime date;
  final String type;

  LoadUsageMonitorEvent({
    required this.date,
    required this.type,
  });

  @override
  List<Object?> get props => [date, type];
}

class DeleteAllUsageMonitorEvent extends UsageMonitorEvent {}
