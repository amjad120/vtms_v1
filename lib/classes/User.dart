import 'package:flutter_application_10/classes/Vehicle.dart';

class User {
  String userID;
  String firstName;
  String lastName;
  String email;
  String password;
  List<String> phones;
  List<Vehicle> vehicles;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phones,
    required this.vehicles,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phones': phones,
      'vehicles': vehicles.map((v) => v.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      phones: List<String>.from(map['phones']),
      vehicles: List<Vehicle>.from(
          map['vehicles']?.map((v) => Vehicle.fromMap(v)) ?? []),
    );
  }
}