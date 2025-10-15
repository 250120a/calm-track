import 'package:flutter/material.dart';

import '../models/emotion_entry.dart';
import '../models/emotion_type.dart';
import '../services/storage/storage_service.dart';

class DailyMoodPoint {
  DailyMoodPoint(this.date, this.score);

  final DateTime date;
  final double score;
}

class EmotionProvider extends ChangeNotifier {
  EmotionProvider(this._storage);

  final StorageService _storage;
  final List<EmotionEntry> _entries = [];
  bool _loaded = false;

  List<EmotionEntry> get entries => List.unmodifiable(_entries);
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _entries
      ..clear()
      ..addAll(_storage.readEmotions());
    _loaded = true;
    notifyListeners();
  }

  Future<EmotionEntry> addEmotion({
    required EmotionType type,
    String? note,
    DateTime? timestamp,
  }) async {
    final entry = EmotionEntry(
      id: _storage.createKey('emotion'),
      type: type,
      timestamp: timestamp ?? DateTime.now(),
      note: note,
    );
    await _storage.saveEmotion(entry);
    _entries.insert(0, entry);
    notifyListeners();
    return entry;
  }

  Future<void> removeEmotion(String id) async {
    await _storage.removeEmotion(id);
    _entries.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<EmotionEntry> entriesForDay(DateTime day) {
    return _entries
        .where((element) => _isSameDay(element.timestamp, day))
        .toList();
  }

  Map<EmotionType, int> distributionSince(DateTime start) {
    final result = <EmotionType, int>{};
    for (final type in EmotionType.values) {
      result[type] = 0;
    }
    for (final entry in _entries) {
      if (entry.timestamp.isAfter(start) || _isSameDay(entry.timestamp, start)) {
        result[entry.type] = (result[entry.type] ?? 0) + 1;
      }
    }
    return result;
  }

  List<DailyMoodPoint> moodTrendSince(DateTime start) {
    final buckets = <DateTime, List<double>>{};
    for (final entry in _entries) {
      if (entry.timestamp.isBefore(start)) {
        continue;
      }
      final key = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      final list = buckets.putIfAbsent(key, () => []);
      list.add(entry.type.moodScore);
    }
    final points = buckets.entries.map((e) {
      final score = e.value.isEmpty
          ? 0.0
          : e.value.reduce((a, b) => a + b) / e.value.length;
      return DailyMoodPoint(e.key, score);
    }).toList();
    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  double averageMoodForDay(DateTime day) {
    final list = entriesForDay(day);
    if (list.isEmpty) {
      return 0;
    }
    final total = list.fold<double>(0, (sum, element) => sum + element.type.moodScore);
    return total / list.length;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
