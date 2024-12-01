class UsageMonitorDataLocal {
  final DateTime timestamp;
  final int value;
  final String commonId;

  UsageMonitorDataLocal(this.timestamp, this.value, this.commonId);

  /// Convert the object to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'value': value,
      'commonId': commonId,
    };
  }

  /// Create an object from a map (for database retrieval)
  factory UsageMonitorDataLocal.fromMap(Map<String, dynamic> map) {
    return UsageMonitorDataLocal(
      DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      map['value'],
      map['commonId'],
    );
  }
}
