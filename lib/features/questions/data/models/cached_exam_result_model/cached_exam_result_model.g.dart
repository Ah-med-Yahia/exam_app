// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_exam_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedExamResultModelAdapter extends TypeAdapter<CachedExamResultModel> {
  @override
  final int typeId = 9;

  @override
  CachedExamResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedExamResultModel(
      answers: fields[2] as CheckAnswersResponseEntity,
      exam: fields[0] as ExamEntity,
      questions: (fields[1] as List).cast<QuestionEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, CachedExamResultModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exam)
      ..writeByte(1)
      ..write(obj.questions)
      ..writeByte(2)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedExamResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
