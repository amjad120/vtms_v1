import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BluetoothProvider with ChangeNotifier {
  BluetoothDevice? _obdDevice;
  bool _isConnected = false;
  bool _isScanning = false;
  String? _connectionError;

  // دالة البحث عن جهاز OBD (مصححة بالكامل)
 Future<BluetoothDevice?> _scanForOBDDevice() async {
  try {
    BluetoothDevice? foundDevice;
    
    // 1. بدء المسح
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
      androidUsesFineLocation: false,
    );

    // 2. الاستماع للنتائج
    var subscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.name.toLowerCase().contains('obd')) {
          foundDevice = result.device;
          FlutterBluePlus.stopScan();
        }
      }
    });

    // 3. انتظار النتائج
    await Future.delayed(const Duration(seconds: 15));
    await subscription.cancel();
    
    return foundDevice;
  } catch (e) {
    debugPrint('Scan error: $e');
    return null;
  }
}

  // دالة الاتصال بالجهاز (محدثة)
  Future<bool> connectToOBD() async {
    try {
      // 1. التحقق من اتصال موجود
      if (_isConnected) return true;

      // 2. البحث عن الجهاز
      final device = await _scanForOBDDevice();
      if (device == null) {
        setState(() => _connectionError = 'لم يتم العثور على جهاز OBD');
        return false;
      }

      // 3. محاولة الاتصال
      setState(() => _connectionError = 'جاري الاتصال...');
      await device.connect(autoConnect: false);
      
      // 4. اكتشاف الخدمات
      final services = await device.discoverServices();
      bool foundCharacteristics = false;
      
      for (final service in services) {
        for (final characteristic in service.characteristics) {
          if (characteristic.uuid.toString().toLowerCase().contains('fff1') || 
              characteristic.uuid.toString().toLowerCase().contains('fff2')) {
            foundCharacteristics = true;
          }
        }
      }

      if (!foundCharacteristics) {
        throw Exception('الجهاز لا يحتوي على خصائص OBD المطلوبة');
      }

      // 5. تحديث حالة الاتصال
      setState(() {
        _obdDevice = device;
        _isConnected = true;
        _connectionError = null;
      });
      
      return true;

    } catch (e) {
      setState(() {
        _isConnected = false;
        _connectionError = 'فشل الاتصال: ${e.toString()}';
      });
      debugPrint('Connection Error: $e');
      await disconnectOBD();
      return false;
    }
  }

  // دالة فصل الاتصال
  Future<void> disconnectOBD() async {
    if (_obdDevice != null) {
      await _obdDevice!.disconnect();
    }
    setState(() {
      _obdDevice = null;
      _isConnected = false;
      _connectionError = null;
    });
  }

  // دالة مساعدة لتحديث الحالة
  void setState(void Function() fn) {
    fn();
    notifyListeners();
  }

  // Getters
  bool get isConnected => _isConnected;
  bool get isScanning => _isScanning;
  String? get connectionError => _connectionError;
}