import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum EmotionType {
  joyful,
  pleasant,
  neutral,
  uncertain,
  angry,
  sleepy,
  sad,
  excited,
  peaceful,
}

extension EmotionTypeX on EmotionType {
  String get asset {
    switch (this) {
      case EmotionType.joyful:
        return 'assets/emotions/joyful.png';
      case EmotionType.pleasant:
        return 'assets/emotions/pleasant.png';
      case EmotionType.neutral:
        return 'assets/emotions/neutral.png';
      case EmotionType.uncertain:
        return 'assets/emotions/uncertain.png';
      case EmotionType.angry:
        return 'assets/emotions/angry.png';
      case EmotionType.sleepy:
        return 'assets/emotions/sleepy.png';
      case EmotionType.sad:
        return 'assets/emotions/sad.png';
      case EmotionType.excited:
        return 'assets/emotions/excited.png';
      case EmotionType.peaceful:
        return 'assets/emotions/peaceful.png';
    }
  }

  Color get color {
    switch (this) {
      case EmotionType.joyful:
        return const Color(0xFF91F1C3);
      case EmotionType.pleasant:
        return const Color(0xFF82C0FF);
      case EmotionType.neutral:
        return const Color(0xFFA7A7B4);
      case EmotionType.uncertain:
        return const Color(0xFFF7B267);
      case EmotionType.angry:
        return const Color(0xFFFF6B6B);
      case EmotionType.sleepy:
        return const Color(0xFFB4C5F2);
      case EmotionType.sad:
        return const Color(0xFF6C91BF);
      case EmotionType.excited:
        return const Color(0xFFFFD166);
      case EmotionType.peaceful:
        return const Color(0xFF7EE3C8);
    }
  }

  double get moodScore {
    switch (this) {
      case EmotionType.joyful:
        return 2;
      case EmotionType.pleasant:
        return 1;
      case EmotionType.neutral:
        return 0;
      case EmotionType.uncertain:
        return -0.5;
      case EmotionType.angry:
        return -2;
      case EmotionType.sleepy:
        return -1;
      case EmotionType.sad:
        return -1.5;
      case EmotionType.excited:
        return 1.5;
      case EmotionType.peaceful:
        return 1.2;
    }
  }
}

class EmotionTypeAdapter extends TypeAdapter<EmotionType> {
  @override
  final int typeId = 0;

  @override
  EmotionType read(BinaryReader reader) {
    final index = reader.readInt();
    return EmotionType.values[index];
  }

  @override
  void write(BinaryWriter writer, EmotionType obj) {
    writer.writeInt(obj.index);
  }
}
