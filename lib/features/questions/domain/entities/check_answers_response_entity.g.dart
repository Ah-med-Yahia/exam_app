// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_answers_response_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckAnswersResponseEntityAdapter
    extends TypeAdapter<CheckAnswersResponseEntity> {
  @override
  final int typeId = 1;

  @override
  CheckAnswersResponseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckAnswersResponseEntity(
      message: fields[0] as String,
      correct: fields[1] as int,
      wrong: fields[2] as int,
      total: fields[3] as String,
      wrongQuestions: (fields[4] as List).cast<WrongQuestionEntity>(),
      correctQuestions: (fields[5] as List).cast<CorrectQuestionEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, CheckAnswersResponseEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.correct)
      ..writeByte(2)
      ..write(obj.wrong)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.wrongQuestions)
      ..writeByte(5)
      ..write(obj.correctQuestions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckAnswersResponseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CorrectQuestionEntityAdapter extends TypeAdapter<CorrectQuestionEntity> {
  @override
  final int typeId = 2;

  @override
  CorrectQuestionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CorrectQuestionEntity(
      qid: fields[0] as String,
      question: fields[1] as String,
      correctAnswer: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CorrectQuestionEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.qid)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.correctAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectQuestionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WrongQuestionEntityAdapter extends TypeAdapter<WrongQuestionEntity> {
  @override
  final int typeId = 3;

  @override
  WrongQuestionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WrongQuestionEntity(
      qid: fields[0] as String,
      question: fields[1] as String,
      inCorrectAnswer: fields[2] as String,
      correctAnswer: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WrongQuestionEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.qid)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.inCorrectAnswer)
      ..writeByte(3)
      ..write(obj.correctAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WrongQuestionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
