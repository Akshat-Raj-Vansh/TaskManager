//@dart=2.9

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taskmanager/constants/strings.dart';
import 'package:taskmanager/data/models/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
  }

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(ICON_LOCATION);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: scheduleNotification);
  }

  Future<void> scheduleNotification(String payload) async {
    await initializeTimeZone();
    Task task = Task.fromJson(jsonDecode(payload));
    DateTime currentDate = DateTime.now();
    if (currentDate.compareTo(task.date) > 0 || task.completed) return;
    final scheduleNotificationDateTime = tz.TZDateTime.from(
      DateTime(task.date.year, task.date.month, task.date.day, 0, 0),
      tz.local,
    );
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'reminder',
      'taskmanager',
      'event_reminder',
      icon: ICON_LOCATION,
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap(ICON_LOCATION),
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id.hashCode,
      task.title,
      task.description,
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void cancelNotificationForTask(Task task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id.hashCode);
  }

  void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
