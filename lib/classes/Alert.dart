class Alert {
  String alertID;
  String time;
  String type;
  String status;

  Alert({
    required this.alertID,
    required this.time,
    required this.type,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'alertID': alertID,
      'time': time,
      'type': type,
      'status': status,
    };
  }

  factory Alert.fromMap(Map<String, dynamic> map) {
    return Alert(
      alertID: map['alertID'],
      time: map['time'],
      type: map['type'],
      status: map['status'],
    );
  }
}
