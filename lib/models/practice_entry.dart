import 'package:hive/hive.dart';

import 'practice_kind.dart';

class PracticeEntry {
  PracticeEntry({
    required this.id,
    required this.kind,
    required this.minutes,
    required this.timestamp,
  });

  final String id;
  final PracticeKind kind;
  final int minutes;
  final DateTime timestamp;
}

class PracticeEntryAdapter extends TypeAdapter<PracticeEntry> {
  @override
  final int typeId = 3;

  @override
  PracticeEntry read(BinaryReader reader) {
    final id = reader.readString();
    final kind = reader.read() as PracticeKind;
    final minutes = reader.readInt();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return PracticeEntry(
      id: id,
      kind: kind,
      minutes: minutes,
      timestamp: timestamp,
    );
  }

  @override
  void write(BinaryWriter writer, PracticeEntry obj) {
    writer
      ..writeString(obj.id)
      ..write(obj.kind)
      ..writeInt(obj.minutes)
      ..writeInt(obj.timestamp.millisecondsSinceEpoch);
  }
}
