import 'package:hive/hive.dart';

import 'emotion_type.dart';

class EmotionEntry {
  EmotionEntry({
    required this.id,
    required this.type,
    required this.timestamp,
    this.note,
  });

  final String id;
  final EmotionType type;
  final DateTime timestamp;
  final String? note;

  EmotionEntry copyWith({
    String? id,
    EmotionType? type,
    DateTime? timestamp,
    String? note,
  }) {
    return EmotionEntry(
      id: id ?? this.id,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
    );
  }

  bool get hasNote => (note ?? '').isNotEmpty;
}

class EmotionEntryAdapter extends TypeAdapter<EmotionEntry> {
  @override
  final int typeId = 2;

  @override
  EmotionEntry read(BinaryReader reader) {
    final id = reader.readString();
    final type = reader.read() as EmotionType;
    final timestamp = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final hasNote = reader.readBool();
    final note = hasNote ? reader.readString() : null;
    return EmotionEntry(
      id: id,
      type: type,
      timestamp: timestamp,
      note: note,
    );
  }

  @override
  void write(BinaryWriter writer, EmotionEntry obj) {
    writer
      ..writeString(obj.id)
      ..write(obj.type)
      ..writeInt(obj.timestamp.millisecondsSinceEpoch)
      ..writeBool(obj.hasNote);
    if (obj.hasNote) {
      writer.writeString(obj.note!);
    }
  }
}
