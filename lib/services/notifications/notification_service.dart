import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import '../../config/app_config.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool _available = false;
  static const _channel = AndroidNotificationChannel(
    'emotion_reminder',
    'Emotion Reminder',
    description: 'Daily reminders to log emotions',
    importance: Importance.max,
  );
  
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    _initialized = true;
    try {
      await _configureLocalTimeZone();
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const ios = DarwinInitializationSettings();
      const settings = InitializationSettings(android: android, iOS: ios);
      await _plugin.initialize(settings);
      if (Platform.isIOS) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      }
      _available = true;
      if (Platform.isAndroid) {
        final androidPlugin = _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        await androidPlugin?.createNotificationChannel(_channel);
      }
    } catch (_) {
      _available = false;
    }
  }

  Future<void> scheduleDailyEmotionReminders(List<TimeOfDay> times) async {
    if (!_available || !AppConfig.instance.features.pushNotificationsEnabled) {
      return;
    }
    await _plugin.cancelAll();
    if (times.isEmpty) {
      return;
    }
    var id = 0;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
      ),
      iOS: const DarwinNotificationDetails(),
    );
    for (final time in times) {
      final scheduledDate = _nextInstanceOfTime(time);
      await _plugin.zonedSchedule(
        id++,
        AppConfig.instance.gameName,
        'Time to check in with your emotions',
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelAll() async {
    if (!_available || !AppConfig.instance.features.pushNotificationsEnabled) {
      return;
    }
    await _plugin.cancelAll();
  }

  Future<void> _configureLocalTimeZone() async {
    try {
      tz.initializeTimeZones();
      final name = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
