import 'package:equatable/equatable.dart';

class UsageMonitorEntity extends Equatable {
  final DateTime timestamp;
  final int value;

  const UsageMonitorEntity(this.timestamp, this.value);

  @override
  List<Object?> get props => [timestamp, value];
}
