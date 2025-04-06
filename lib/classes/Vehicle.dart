import 'package:flutter_application_10/classes/Alert.dart';
import 'package:flutter_application_10/classes/GPS.dart';
import 'package:flutter_application_10/classes/OBD2.dart';
import 'package:flutter_application_10/classes/REPORT.dart';

class Vehicle {
  String vehicleName;
  String chassisNumber;
  String plateNumber;
  String color;
  String vehicleType;
  int coverdDistance;
  OBD2 device;
  GPS gps;
  List<Report> reports;
  List<Alert> alerts;

  Vehicle({
    required this.vehicleName,
    required this.chassisNumber,
    required this.plateNumber,
    required this.color,
    required this.vehicleType,
    required this.coverdDistance,
    required this.device,
    required this.gps,
    required this.reports,
    required this.alerts,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleName': vehicleName,
      'chassisNumber': chassisNumber,
      'plateNumber': plateNumber,
      'color': color,
      'vehicleType': vehicleType,
      'coverdDistance': coverdDistance,
      'device': device.toMap(),
      'gps': gps.toMap(),
      'reports': reports.map((r) => r.toMap()).toList(),
      'alerts': alerts.map((a) => a.toMap()).toList(),
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicleName: map['vehicleName'],
      chassisNumber: map['chassisNumber'],
      plateNumber: map['plateNumber'],
      color: map['color'],
      vehicleType: map['vehicleType'],
      coverdDistance: map['coverdDistance'],
      device: OBD2.fromMap(map['device']),
      gps: GPS.fromMap(map['gps']),
      reports: List<Report>.from(
          map['reports']?.map((r) => Report.fromMap(r)) ?? []),
      alerts: List<Alert>.from(
          map['alerts']?.map((a) => Alert.fromMap(a)) ?? []),
    );
  }
}