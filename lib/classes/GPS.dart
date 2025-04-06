class GPS {
  double latitude;
  double longitude;
  String status;

  GPS({required this.latitude, required this.longitude, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  factory GPS.fromMap(Map<String, dynamic> map) {
    return GPS(
      latitude: map['latitude'],
      longitude: map['longitude'],
      status: map['status'],
    );
  }
}
