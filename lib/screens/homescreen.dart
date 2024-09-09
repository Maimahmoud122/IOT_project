import 'package:a/led.dart';
import 'package:a/mqtt_m.dart';
import 'package:a/servo.dart';
import 'package:flutter/material.dart';
import 'package:a/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MQTTClientWrapper mqttClient = MQTTClientWrapper();
  bool warningShown = false;

  @override
  void initState() {
    super.initState();
    _setupMqttClient();
  }

  Future<void> _setupMqttClient() async {
    await mqttClient.prepareMqttClient();
    mqttClient.subscribeToTopic('ESP32/notification'); // Subscribe to the new topic
    mqttClient.onMessageReceived = (message) {
      print('Received message: $message'); // Debug statement
      if (message == 'Too many incorrect attempts') {
        if (!warningShown) {
          showWarningDialog(context, 'Too many incorrect attempts! Alarm!!');
          setState(() {
            warningShown = true;
          });
        }
      } else {
        setState(() {
          warningShown = false;
        });
      }
    };
  }

  void showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Navigate to LED"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LedControlPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Navigate to Servo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServoControlPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("signed out");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
