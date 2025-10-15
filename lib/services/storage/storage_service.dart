import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/emotion_entry.dart';
import '../../models/emotion_type.dart';
import '../../models/practice_entry.dart';
import '../../models/practice_kind.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  static const _initialSeedKey = 'initialSeedDone';

  final _random = Random();
  bool _initialized = false;
  late Box<EmotionEntry> _emotionBox;
  late Box<PracticeEntry> _practiceBox;
  late Box<dynamic> _prefsBox;

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    try {
      await Hive.initFlutter();
    } on MissingPluginException {
      final tempDir = await Directory.systemTemp.createTemp('SoulTrack_hive');
      Hive.init(tempDir.path);
    }
    _registerAdapter(EmotionTypeAdapter());
    _registerAdapter(PracticeKindAdapter());
    _registerAdapter(EmotionEntryAdapter());
    _registerAdapter(PracticeEntryAdapter());
    _emotionBox = await Hive.openBox<EmotionEntry>('emotion_entries');
    _practiceBox = await Hive.openBox<PracticeEntry>('practice_entries');
    _prefsBox = await Hive.openBox<dynamic>('SoulTrack_prefs');
    final hasSeededSamples = _prefsBox.get(_initialSeedKey) as bool? ?? false;
    _initialized = true;
    if (!hasSeededSamples && _emotionBox.isEmpty && _practiceBox.isEmpty) {
      await _seedMockData();
    }
  }

  List<EmotionEntry> readEmotions() {
    final entries = _emotionBox.values.toList();
    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  Future<void> saveEmotion(EmotionEntry entry) async {
    await _emotionBox.put(entry.id, entry);
  }

  Future<void> removeEmotion(String id) async {
    await _emotionBox.delete(id);
  }

  List<PracticeEntry> readPractices() {
    final entries = _practiceBox.values.toList();
    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  Future<void> savePractice(PracticeEntry entry) async {
    await _practiceBox.put(entry.id, entry);
  }

  Future<void> removePractice(String id) async {
    await _practiceBox.delete(id);
  }

  T? readPref<T>(String key) {
    return _prefsBox.get(key) as T?;
  }

  Future<void> savePref<T>(String key, T value) async {
    await _prefsBox.put(key, value);
  }

  Future<void> deleteAccountData() async {
    await _emotionBox.clear();
    await _practiceBox.clear();
    await _prefsBox.clear();
    await _prefsBox.put(_initialSeedKey, true);
  }

  String createKey(String prefix) {
    final millis = DateTime.now().millisecondsSinceEpoch;
    final random = _random.nextInt(999999);
    return '$prefix-$millis-$random';
  }

  void _registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  Future<void> _seedMockData() async {
    final now = DateTime.now();
    final mockEmotions = [
      EmotionEntry(
        id: createKey('emotion'),
        type: EmotionType.joyful,
        timestamp: now.subtract(const Duration(hours: 1)),
        note: 'Won small victory at work',
      ),
      EmotionEntry(
        id: createKey('emotion'),
        type: EmotionType.neutral,
        timestamp: now.subtract(const Duration(hours: 4)),
      ),
      EmotionEntry(
        id: createKey('emotion'),
        type: EmotionType.sleepy,
        timestamp: now.subtract(const Duration(hours: 12)),
        note: 'Late night reading',
      ),
    ];
    final mockPractices = [
      PracticeEntry(
        id: createKey('practice'),
        kind: PracticeKind.breathing,
        minutes: 5,
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      PracticeEntry(
        id: createKey('practice'),
        kind: PracticeKind.game,
        minutes: 3,
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
      ),
      PracticeEntry(
        id: createKey('practice'),
        kind: PracticeKind.timer,
        minutes: 10,
        timestamp: now.subtract(const Duration(days: 2)),
      ),
    ];
    for (final entry in mockEmotions) {
      await saveEmotion(entry);
    }
    for (final entry in mockPractices) {
      await savePractice(entry);
    }
    await savePref<int>('dailyGoal', 10);
    await savePref<bool>('remindersEnabled', false);
    await savePref<List<String>>('reminderTimes', <String>[]);
    await savePref<String>('themeMode', 'system');
    await savePref<bool>('onboarded', false);
    await savePref<String>('userName', '');
    await savePref<String>('localeCode', 'system');
    await savePref<bool>('attPromptCompleted', false);
    await savePref<bool>(_initialSeedKey, true);
  }
}
