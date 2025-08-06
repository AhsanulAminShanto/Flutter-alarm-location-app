import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

class AlarmScreen extends StatefulWidget {
  final String location;

  const AlarmScreen({super.key, required this.location});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<Map<String, dynamic>> _alarms = [
    {'time': '7:10 pm', 'date': 'Fri 21 Aug 2025', 'isActive': true},
    {'time': '6:55 pm', 'date': 'Fri 28 Aug 2025', 'isActive': false},
    {'time': '5:00 am', 'date': 'Fri 04 Aug 2025', 'isActive': false},
  ];

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _saveInitialAlarms();
    _loadAlarms();
    print('Initial alarms: $_alarms'); // Debug initial state
  }

  Future<void> _initNotifications() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await notificationsPlugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> _saveInitialAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmList = _alarms.map((alarm) {
      return '${alarm['time']}|${alarm['date']}|${alarm['isActive']}';
    }).toList();
    await prefs.setStringList('alarms', alarmList);
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmList = prefs.getStringList('alarms') ?? [];
    setState(() {
      _alarms = alarmList.map((alarm) {
        final parts = alarm.split('|');
        return <String, dynamic>{ // Explicitly typed map
          'time': parts[0],
          'date': parts[1],
          'isActive': parts.length > 2 ? parts[2] == 'true' : true,
        };
      }).toList();
    });
    print('Loaded alarms: $_alarms'); // Debug loaded state
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmList = _alarms.map((alarm) {
      return '${alarm['time']}|${alarm['date']}|${alarm['isActive']}';
    }).toList();
    final success = await prefs.setStringList('alarms', alarmList);
    print('Save successful: $success, Alarms saved: $alarmList'); // Debug save
  }

  Future<void> _setAlarm() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    print('Selected time: $time');

    if (time == null) return;

    final now = DateTime.now();
    final alarmDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedDate = DateFormat('EEE dd MMM yyyy').format(alarmDate);
    print('Formatted date: $formattedDate');

    final tzDateTime = tz.TZDateTime.from(alarmDate, tz.local);
    final id = Random().nextInt(100000);

    try {
      await notificationsPlugin.zonedSchedule(
        id,
        'Alarm',
        'It\'s time! Location: ${widget.location}',
        tzDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_notif',
            'Alarm Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      print('Notification scheduled for: $tzDateTime');
    } catch (e) {
      debugPrint('Notification scheduling error: $e');
    }

    final newAlarm = <String, dynamic>{
      'time': time.format(context),
      'date': formattedDate,
      'isActive': true,
    };
    print('New alarm to add: $newAlarm');

    setState(() {
      _alarms.add(newAlarm);
      print('Alarms list after add: $_alarms'); // Debug after setState
    });

    await _saveAlarms();
  }

  void _toggleAlarm(int index) {
    setState(() {
      _alarms[index]['isActive'] = !_alarms[index]['isActive'];
    });
    _saveAlarms();
  }

  @override
  Widget build(BuildContext context) {
    print('Building with alarms: $_alarms'); // Debug build state
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected Location",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.location,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _setAlarm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Add Alarm",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Alarms",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _alarms.isEmpty
                    ? const Center(
                  child: Text(
                    "No alarms set",
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                )
                    : ListView.separated(
                  itemCount: _alarms.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final alarm = _alarms[index];
                    return Card(
                      color: Colors.grey[850],
                      child: ListTile(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: const Icon(Icons.alarm, color: Colors.white),
                        title: Text(
                          alarm['time']!,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        subtitle: Text(
                          alarm['date']!,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Switch(
                          value: alarm['isActive'] as bool,
                          onChanged: (_) => _toggleAlarm(index),
                          activeColor: Colors.purple,
                          activeTrackColor: Colors.purple[200],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}