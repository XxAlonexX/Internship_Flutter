import 'package:flutter/material.dart';
import 'DeviceListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Device Connection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Set HomeScreen as the starting screen
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController deviceNameController = TextEditingController();
  String selectedConnectionType = 'Bluetooth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IoT Device Connection")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: deviceNameController,
              decoration: InputDecoration(labelText: 'Device Name'),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedConnectionType,
              items: <String>['Bluetooth', 'Wi-Fi']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedConnectionType = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Proceed to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeviceListScreen(
                      connectionType: selectedConnectionType,
                    ),
                  ),
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
