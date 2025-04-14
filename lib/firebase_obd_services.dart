import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOBDService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateOBDData(String vehicleId, Map<String, dynamic> obdData) async {
    await _firestore.collection('vehicles').doc(vehicleId).update({
      'obd_data': {
        'last_update': FieldValue.serverTimestamp(),
        'live_data': obdData,
      }
    });
  }

  Future<Map<String, dynamic>> getVehicleOBDData(String vehicleId) async {
    DocumentSnapshot doc = await _firestore.collection('vehicles').doc(vehicleId).get();
    return doc['obd_data'] ?? {};
  }

  Future<void> linkUserToVehicle(String userId, String vehicleId) async {
    await _firestore.collection('vehicles').doc(vehicleId).update({
      'user_id': userId,
    });
  }

  Stream<DocumentSnapshot> getLiveOBDUpdates(String vehicleId) {
    return _firestore.collection('vehicles').doc(vehicleId).snapshots();
  }
}