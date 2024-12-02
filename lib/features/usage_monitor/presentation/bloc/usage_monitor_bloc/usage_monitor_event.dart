import 'package:equatable/equatable.dart';

sealed class UsageMonitorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsageMonitorEvent extends UsageMonitorEvent {
  final DateTime date;

  LoadUsageMonitorEvent({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}

class DeleteUsageMonitorEvent extends UsageMonitorEvent {
  final DateTime date;

  DeleteUsageMonitorEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeUsageUnitEvent extends UsageMonitorEvent {}
