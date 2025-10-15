import 'package:flutter/material.dart';

import '../services/notifications/notification_service.dart';
import '../services/storage/storage_service.dart';

class PrefsProvider extends ChangeNotifier {
  PrefsProvider(this._storage);

  final StorageService _storage;

  int _dailyGoalMinutes = 10;
  bool _remindersEnabled = false;
  List<TimeOfDay> _reminderTimes = [];
  ThemeMode _themeMode = ThemeMode.system;
  bool _onboardingComplete = false;
  String _userName = '';
  String _localeCode = 'system';
  bool _loaded = false;
  bool _attPromptCompleted = false;

  int get dailyGoalMinutes => _dailyGoalMinutes;
  bool get remindersEnabled => _remindersEnabled;
  List<TimeOfDay> get reminderTimes => List.unmodifiable(_reminderTimes);
  ThemeMode get themeMode => _themeMode;
  bool get onboardingComplete => _onboardingComplete;
  String get userName => _userName;
  String get localeCode => _localeCode;
  Locale? get locale => _localeCode == 'system' ? null : Locale(_localeCode);
  bool get isLoaded => _loaded;
  bool get attPromptCompleted => _attPromptCompleted;

  Future<void> load() async {
    _dailyGoalMinutes = _storage.readPref<int>('dailyGoal') ?? 10;
    _remindersEnabled = _storage.readPref<bool>('remindersEnabled') ?? false;
    final timeStrings = _storage.readPref<List<dynamic>>('reminderTimes') ?? [];
    _reminderTimes = timeStrings
        .map((e) => _timeFromString(e as String))
        .whereType<TimeOfDay>()
        .toList();
    _themeMode = _parseThemeMode(_storage.readPref<String>('themeMode'));
    _userName = (_storage.readPref<String>('userName') ?? '').trim();
    _localeCode = _storage.readPref<String>('localeCode') ?? 'system';
    _onboardingComplete = _storage.readPref<bool>('onboarded') ?? false;
    _attPromptCompleted = _storage.readPref<bool>('attPromptCompleted') ?? false;
    _loaded = true;
    if (_remindersEnabled) {
      await NotificationService.instance.scheduleDailyEmotionReminders(_reminderTimes);
    } else {
      await NotificationService.instance.cancelAll();
    }
    notifyListeners();
  }

  Future<void> setDailyGoal(int minutes) async {
    _dailyGoalMinutes = minutes;
    await _storage.savePref<int>('dailyGoal', minutes);
    notifyListeners();
  }

  Future<void> toggleReminders(bool enabled) async {
    _remindersEnabled = enabled;
    await _storage.savePref<bool>('remindersEnabled', enabled);
    if (enabled) {
      await NotificationService.instance.scheduleDailyEmotionReminders(_reminderTimes);
    } else {
      await NotificationService.instance.cancelAll();
    }
    notifyListeners();
  }

  Future<void> updateReminderTimes(List<TimeOfDay> times) async {
    _reminderTimes = times.take(3).toList();
    final payload = _reminderTimes.map(_timeToString).toList();
    await _storage.savePref<List<String>>('reminderTimes', payload);
    if (_remindersEnabled) {
      await NotificationService.instance.scheduleDailyEmotionReminders(_reminderTimes);
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storage.savePref<String>('themeMode', mode.name);
    notifyListeners();
  }

  Future<void> setUserName(String name) async {
    final trimmed = name.trim();
    if (_userName == trimmed) {
      return;
    }
    _userName = trimmed;
    await _storage.savePref<String>('userName', trimmed);
    notifyListeners();
  }

  Future<void> setLocaleCode(String code) async {
    _localeCode = code;
    await _storage.savePref<String>('localeCode', code);
    notifyListeners();
  }

  Future<void> setOnboardingComplete(bool value) async {
    _onboardingComplete = value;
    await _storage.savePref<bool>('onboarded', value);
    notifyListeners();
  }

  Future<void> setAttPromptCompleted(bool value) async {
    if (_attPromptCompleted == value) {
      return;
    }
    _attPromptCompleted = value;
    await _storage.savePref<bool>('attPromptCompleted', value);
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    await NotificationService.instance.cancelAll();
    await _storage.deleteAccountData();
    _dailyGoalMinutes = 10;
    _remindersEnabled = false;
    _reminderTimes = [];
    _themeMode = ThemeMode.system;
    _onboardingComplete = false;
    _userName = '';
    _localeCode = 'system';
    _attPromptCompleted = false;
    notifyListeners();
  }

  TimeOfDay? _timeFromString(String value) {
    final parts = value.split(':');
    if (parts.length != 2) {
      return null;
    }
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  String _timeToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
