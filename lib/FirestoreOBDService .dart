import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOBDService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getLiveOBDUpdates(String vehicleId) {
    return _firestore.collection('vehicles').doc(vehicleId).snapshots();
  }

  Future<void> saveOBDReport(String vehicleId, Map<String, dynamic> report) async {
    await _firestore.collection('vehicles').doc(vehicleId).update({
      'reports': FieldValue.arrayUnion([{
        ...report,
        'timestamp': FieldValue.serverTimestamp(),
      }])
    });
  }
}