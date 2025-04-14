class OBDReport {
  final String vehicleId;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  OBDReport({
    required this.vehicleId,
    required this.data,
    required this.timestamp,
  });

  factory OBDReport.fromFirestore(Map<String, dynamic> data) {
    return OBDReport(
      vehicleId: data['vehicleId'],
      data: data['data'],
      timestamp: data['timestamp'].toDate(),
    );
  }
}