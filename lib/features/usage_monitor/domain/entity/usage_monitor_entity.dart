import 'package:equatable/equatable.dart';

class UsageMonitorEntity extends Equatable {
  final int timestamp;
  final double value;

  const UsageMonitorEntity(this.timestamp, this.value);

  @override
  List<Object?> get props => [timestamp, value];
}
