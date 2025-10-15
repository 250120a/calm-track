import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum PracticeKind {
  breathing,
  timer,
  game,
  custom,
}

extension PracticeKindX on PracticeKind {
  IconData get icon {
    switch (this) {
      case PracticeKind.breathing:
        return Icons.self_improvement;
      case PracticeKind.timer:
        return Icons.hourglass_bottom;
      case PracticeKind.game:
        return Icons.sports_esports;
      case PracticeKind.custom:
        return Icons.add;
    }
  }
}

class PracticeKindAdapter extends TypeAdapter<PracticeKind> {
  @override
  final int typeId = 1;

  @override
  PracticeKind read(BinaryReader reader) {
    final index = reader.readInt();
    return PracticeKind.values[index];
  }

  @override
  void write(BinaryWriter writer, PracticeKind obj) {
    writer.writeInt(obj.index);
  }
}
