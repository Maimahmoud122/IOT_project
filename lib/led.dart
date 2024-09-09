import 'package:a/mqtt_m.dart';
import 'package:flutter/material.dart';

class LedControlPage extends StatefulWidget {
  const LedControlPage({super.key});

  @override
  _LedControlPage createState() => _LedControlPage();
}

class _LedControlPage extends State<LedControlPage> {
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
    mqttClientWrapper.publishMessage('ESP32/led', message);
    print('Published message: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('LED Control'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                publishMessage('1');
              },
              child: const Text('Turn LED On'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                publishMessage('0');
              },
              child: const Text('Turn LED Off'),
            ),
          ],
        ),
      ),
    );
  }
}
