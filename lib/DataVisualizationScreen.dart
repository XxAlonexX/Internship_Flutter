import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataVisualizationScreen extends StatelessWidget {
  final String deviceName;
  final String connectionType;

  DataVisualizationScreen({
    required this.deviceName,
    required this.connectionType,
  });

  // Simulate fetching mock sensor data
  List<charts.Series<SensorData, int>> _createMockData() {
    final data = [
      SensorData(0, 20),
      SensorData(1, 22),
      SensorData(2, 23),
      SensorData(3, 24),
      SensorData(4, 25),
    ];

    return [
      charts.Series<SensorData, int>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SensorData data, _) => data.time,
        measureFn: (SensorData data, _) => data.value,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Visualization")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Device: $deviceName\nConnection: $connectionType",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: charts.LineChart(
                _createMockData(),
                animate: true,
                behaviors: [
                  charts.ChartTitle('Time',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle('Temperature (°C)',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SensorData {
  final int time;
  final int value;

  SensorData(this.time, this.value);
}
