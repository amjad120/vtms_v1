import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_10/firebase_obd_services.dart';

class VehicleReportPage extends StatefulWidget {
  final String vehicleId;

  const VehicleReportPage({
    Key? key,
    required this.vehicleId,
  }) : super(key: key);

  @override
  _VehicleReportPageState createState() => _VehicleReportPageState();
}

class _VehicleReportPageState extends State<VehicleReportPage> {
  late FirestoreOBDService _obdService;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _obdService = FirestoreOBDService();
    _setupLiveData();
  }

  void _setupLiveData() {
    // الاستماع للتحديثات الحية من Firestore
    _obdService.getLiveOBDUpdates(widget.vehicleId).listen((snapshot) {
      if (snapshot.exists && mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _createNewReport() async {
    setState(() => _isLoading = true);
    // يمكنك إضافة منطق لحفظ تقرير جديد في Firestore هنا
    await Future.delayed(Duration(seconds: 1)); // محاكاة للانتظار
    setState(() => _isLoading = false);
  }

  Widget _buildDataCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقرير المركبة'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _isLoading ? null : _createNewReport,
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _obdService.getLiveOBDUpdates(widget.vehicleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('لا توجد بيانات متاحة'));
          }

          final obdData = snapshot.data!['obd_data']['live_data'] ?? {};

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDataCard('الوقود', [
                  _buildDataRow('المستوى', obdData['FUEL_LEVEL']?.toString() ?? 'N/A'),
                  _buildDataRow('الحالة', obdData['FUEL_STATUS']?.toString() ?? 'N/A'),
                  _buildDataRow('المعدل', obdData['FUEL_RATE']?.toString() ?? 'N/A'),
                ]),
                _buildDataCard('الأداء', [
                  _buildDataRow('السرعة', '${obdData['SPEED'] ?? '0'} km/h'),
                  _buildDataRow('لفات المحرك', '${obdData['RPM'] ?? '0'} rpm'),
                  _buildDataRow('وضعية الدواسة', '${obdData['THROTTLE_POS'] ?? '0'} %'),
                ]),
                if (obdData['ERRORS'] != null && obdData['ERRORS'].isNotEmpty)
                  _buildDataCard('الأعطال', [
                    ...(obdData['ERRORS'] as List).map((error) => 
                      _buildDataRow('خطأ', error.toString())).toList(),
                  ]),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _createNewReport,
        child: _isLoading 
            ? CircularProgressIndicator(color: Colors.white) 
            : Icon(Icons.add),
      ),
    );
  }
}