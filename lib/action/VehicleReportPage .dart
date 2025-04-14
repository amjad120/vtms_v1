import 'package:flutter/material.dart';

class VehicleReportPage extends StatefulWidget {
  final String vehicleId;
  final Map<String, dynamic>? initialObdData;

  const VehicleReportPage({
    Key? key,
    required this.vehicleId,
    this.initialObdData,
  }) : super(key: key);

  @override
  _VehicleReportPageState createState() => _VehicleReportPageState();
}

class _VehicleReportPageState extends State<VehicleReportPage> {
  late Map<String, dynamic> _obdData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _obdData = widget.initialObdData ?? _getDefaultObdData();
    _fetchLiveObdData();
  }

  Map<String, dynamic> _getDefaultObdData() {
    return {
      'FUEL_LEVEL': '0 %',
      'FUEL_STATUS': 'جاري القراءة...',
      'FUEL_RATE': '0 L/h',
      'SPEED': '0 km/h',
      'RPM': '0 rpm',
      'THROTTLE_POS': '0 %',
      'ERRORS': [],
    };
  }

  Future<void> _fetchLiveObdData() async {
    // محاكاة جلب البيانات من OBD2 (استبدل بالاتصال الفعلي)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _obdData = {
        'FUEL_LEVEL': '62.5 %',
        'FUEL_STATUS': 'Closed loop',
        'FUEL_RATE': '3.2 L/h',
        'SPEED': '80 km/h',
        'RPM': '2100 rpm',
        'THROTTLE_POS': '25 %',
        'ERRORS': ['P0172: نظام وقود غني'],
      };
      _isLoading = false;
    });
  }

  Future<void> _createNewReport() async {
    setState(() {
      _isLoading = true;
      _obdData = _getDefaultObdData();
    });
    await _fetchLiveObdData();
  }

  Widget _buildDataCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            tooltip: 'إنشاء تقرير جديد',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _createNewReport,
        child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Icon(Icons.add),
        tooltip: 'تقرير جديد',
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDataCard('الوقود', [
                    _buildDataRow('المستوى', _obdData['FUEL_LEVEL']),
                    _buildDataRow('الحالة', _obdData['FUEL_STATUS']),
                    _buildDataRow('معدل الاستهلاك', _obdData['FUEL_RATE']),
                  ]),
                  _buildDataCard('الأداء', [
                    _buildDataRow('السرعة', _obdData['SPEED']),
                    _buildDataRow('لفات المحرك', _obdData['RPM']),
                    _buildDataRow('وضعية الدواسة', _obdData['THROTTLE_POS']),
                  ]),
                  if (_obdData['ERRORS'].isNotEmpty)
                    _buildDataCard('الأعطال', [
                      ..._obdData['ERRORS'].map((error) => _buildDataRow('خطأ', error)).toList(),
                    ]),
                ],
              ),
            ),
    );
  }
}