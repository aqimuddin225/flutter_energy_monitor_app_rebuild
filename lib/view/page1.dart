import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({super.key});

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final ratePerKWh = 1500;
  late double totalEnergyConsumption;
  late double totalCost;
  int sensorData = 0;
  String? showEnergyConsumption;
  String? showTotalCost;

  @override
  void initState() {
    super.initState();
    // Initialize notifications
    const settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings =
        InitializationSettings(android: settingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _loadTotalConsumption();
    _loadTotalCost();
    generateRandomNumber();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      _showNotification();
    });
  }

  Future<void> _showNotification() async {
    const androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name');
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Penggunaan listrik mencapai $showEnergyConsumption Watt-hour',
      'Klik untuk detail.',
      platformChannelSpecifics,
    );
  }

  void generateRandomNumber() {
    // ignore: unused_local_variable
    Timer? timer;

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        // Check if the widget is still in the widget tree
        timer.cancel(); // Cancel the timer if the widget is disposed
        return;
      }

      final random = Random();
      int randomNumber = random.nextInt(10) + 1;
      setState(() {
        sensorData = randomNumber;
        _calculateTotalCost();
        _calculateConsumption();
      });
    });
  }

  _calculateConsumption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalEnergyConsumption += sensorData.toDouble() * 5 / 3600;
      prefs.setDouble('totalEnergy', totalEnergyConsumption);
      showEnergyConsumption = totalEnergyConsumption.toStringAsFixed(2);
    });
  }

  _loadTotalConsumption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalEnergyConsumption = (prefs.getDouble('totalEnergy') ?? 0);
    });
  }

  _calculateTotalCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final cost = sensorData * ratePerKWh;
      totalCost += cost.toDouble() * 5 / 3600000;
      prefs.setDouble('totalCost', totalCost);
      showTotalCost = totalCost.toStringAsFixed(2);
    });
  }

  _loadTotalCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalCost = (prefs.getDouble('totalCost') ?? 0);
    });
  }

  //UI

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rp $showTotalCost,-',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
                const Text('So far this month bill amount'),
              ],
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 180, // Width of the narrow text
                child: Text(
                  'Power Used for',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '$sensorData Watt',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '$showEnergyConsumption Wh',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
