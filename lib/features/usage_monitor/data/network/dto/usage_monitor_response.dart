import 'package:equatable/equatable.dart';

/// This class is used to get energy usage data from the server
class UsageMonitorResponse extends Equatable {
  final DateTime timestamp;
  final int value;

  const UsageMonitorResponse({required this.timestamp, required this.value});

  /// [UsageMonitorResponse.fromJson] method is used to convert a json response into
  /// [UsageMonitorResponse] object
  factory UsageMonitorResponse.fromJson(Map<String, dynamic> json) {
    return UsageMonitorResponse(
      timestamp: DateTime.parse(json['timestamp']),
      value: json['value'],
    );
  }

  /// [toJson] method is used to convert the [UsageMonitorResponse] class into a json map
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'value': value,
    };
  }

  @override
  List<Object?> get props => [timestamp, value];
}
