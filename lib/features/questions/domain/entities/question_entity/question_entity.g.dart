// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionEntityAdapter extends TypeAdapter<QuestionEntity> {
  @override
  final int typeId = 6;

  @override
  QuestionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionEntity(
      answers: (fields[0] as List).cast<AnswerEntity>(),
      question: fields[1] as String,
      correct: fields[2] as KeyEntity,
      id: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.answers)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.correct)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnswerEntityAdapter extends TypeAdapter<AnswerEntity> {
  @override
  final int typeId = 7;

  @override
  AnswerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerEntity(
      answer: fields[0] as String,
      key: fields[1] as KeyEntity,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.answer)
      ..writeByte(1)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KeyEntityAdapter extends TypeAdapter<KeyEntity> {
  @override
  final int typeId = 8;

  @override
  KeyEntity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KeyEntity.a1;
      case 1:
        return KeyEntity.a2;
      case 2:
        return KeyEntity.a3;
      case 3:
        return KeyEntity.a4;
      default:
        return KeyEntity.a1;
    }
  }

  @override
  void write(BinaryWriter writer, KeyEntity obj) {
    switch (obj) {
      case KeyEntity.a1:
        writer.writeByte(0);
        break;
      case KeyEntity.a2:
        writer.writeByte(1);
        break;
      case KeyEntity.a3:
        writer.writeByte(2);
        break;
      case KeyEntity.a4:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}