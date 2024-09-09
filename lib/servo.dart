import 'package:a/mqtt_m.dart';
import 'package:flutter/material.dart';

class ServoControlPage extends StatefulWidget {
  const ServoControlPage({super.key});

  @override
  _ServoControlPageState createState() => _ServoControlPageState();
}

class _ServoControlPageState extends State<ServoControlPage> {
  final MQTTClientWrapper mqttClientWrapper = MQTTClientWrapper();

  @override
  void initState() {
    super.initState();
    mqttClientWrapper.prepareMqttClient();
  }

  @override
  void dispose() {
    mqttClientWrapper.client.disconnect(); // Disconnect when the widget is disposed
    super.dispose();
  }

  void publishMessage(String message) {
    mqttClientWrapper.publishMessage('ESP32/servo', message);
    print('Published message: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Servo Control'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                publishMessage('open');
              },
              child: const Text('Open Servo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                publishMessage('close');
              },
              child: const Text('Close Servo'),
            ),
          ],
        ),
      ),
    );
  }
}
