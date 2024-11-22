import 'package:flutter/material.dart';
import 'dart:async'; // For periodic data updates
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class DeviceListScreen extends StatefulWidget {
  final String connectionType;

  DeviceListScreen({required this.connectionType});

  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late Timer _timer; // Timer to simulate real-time data fetching
  List<BluetoothDevice> _devicesList = []; // List for BLE devices
  String mockData = "Fetching data...";

  @override
  void initState() {
    super.initState();
    // Start periodic data fetch
    _startPeriodicDataFetch();
    if (widget.connectionType == 'Bluetooth') {
      _startBluetoothScan();
    } else {
      _getWiFiInfo();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Simulate BLE device discovery
  void _startBluetoothScan() {
    flutterBlue.scan().listen((scanResult) {
      setState(() {
        _devicesList.add(scanResult.device);
      });
    });
  }

  // Simulate Wi-Fi device information fetch
  Future<void> _getWiFiInfo() async {
    String? wifiName = await WifiInfo().getWifiName();
    String? wifiBSSID = await WifiInfo().getWifiBSSID();
    setState(() {
      mockData = "Connected to Wi-Fi: $wifiName, BSSID: $wifiBSSID";
    });
  }

  // Periodic function to simulate real-time data fetch
  void _startPeriodicDataFetch() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        mockData = "Updated Data: ${DateTime.now().toString()}"; // Mock data
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device List - ${widget.connectionType}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Connected Device - Mock Data',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (widget.connectionType == 'Bluetooth') ...[
              // Display found Bluetooth devices
              Expanded(
                child: ListView.builder(
                  itemCount: _devicesList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(_devicesList[index].name),
                        subtitle: Text('Address: ${_devicesList[index].id}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Simulate connecting to a BLE device
                            setState(() {
                              mockData = "Connected to BLE device: ${_devicesList[index].name}";
                            });
                          },
                          child: Text('Connect'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              // Display Wi-Fi info
              Text(mockData),
            ],
            SizedBox(height: 20),
            // Display real-time data updates
            Text('Real-Time Data: $mockData'),
          ],
        ),
      ),
    );
  }
}
