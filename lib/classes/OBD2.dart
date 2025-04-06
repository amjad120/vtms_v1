class OBD2 {
  String deviceID;
  String type;
  double fuelConsumption;
  String performance;
  double speed;
  String status;

  OBD2({
    required this.deviceID,
    required this.type,
    required this.fuelConsumption,
    required this.performance,
    required this.speed,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'deviceID': deviceID,
      'type': type,
      'fuelConsumption': fuelConsumption,
      'performance': performance,
      'speed': speed,
      'status': status,
    };
  }

  factory OBD2.fromMap(Map<String, dynamic> map) {
    return OBD2(
      deviceID: map['deviceID'],
      type: map['type'],
      fuelConsumption: map['fuelConsumption'],
      performance: map['performance'],
      speed: map['speed'],
      status: map['status'],
    );
  }
}