import 'package:flutter/material.dart';

import '../models/practice_entry.dart';
import '../models/practice_kind.dart';
import '../services/storage/storage_service.dart';

class PracticeProvider extends ChangeNotifier {
  PracticeProvider(this._storage);

  final StorageService _storage;
  final List<PracticeEntry> _entries = [];
  bool _loaded = false;

  List<PracticeEntry> get entries => List.unmodifiable(_entries);
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _entries
      ..clear()
      ..addAll(_storage.readPractices());
    _loaded = true;
    notifyListeners();
  }

  Future<PracticeEntry> addPractice({
    required PracticeKind kind,
    required int minutes,
    DateTime? timestamp,
  }) async {
    final entry = PracticeEntry(
      id: _storage.createKey('practice'),
      kind: kind,
      minutes: minutes,
      timestamp: timestamp ?? DateTime.now(),
    );
    await _storage.savePractice(entry);
    _entries.insert(0, entry);
    notifyListeners();
    return entry;
  }

  Future<void> removePractice(String id) async {
    await _storage.removePractice(id);
    _entries.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  int minutesForDay(DateTime day) {
    var total = 0;
    for (final entry in _entries) {
      if (_isSameDay(entry.timestamp, day)) {
        total += entry.minutes;
      }
    }
    return total;
  }

  Map<DateTime, int> minutesByDaySince(DateTime start) {
    final map = <DateTime, int>{};
    for (final entry in _entries) {
      if (entry.timestamp.isBefore(start)) {
        continue;
      }
      final key = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      map[key] = (map[key] ?? 0) + entry.minutes;
    }
    final sortedKeys = map.keys.toList()..sort((a, b) => a.compareTo(b));
    return {for (final key in sortedKeys) key: map[key]!};
  }

  int minutesSince(DateTime start) {
    var total = 0;
    for (final entry in _entries) {
      if (!entry.timestamp.isBefore(start)) {
        total += entry.minutes;
      }
    }
    return total;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
