// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      id: json['_id'] as String,
      question: json['question'] as String,
      correct: $enumDecode(_$KeyModelEnumMap, json['correct']),
      subject: json['subject'],
      exam: ExamModel.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'type': instance.type,
      '_id': instance.id,
      'question': instance.question,
      'correct': _$KeyModelEnumMap[instance.correct]!,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$KeyModelEnumMap = {
  KeyModel.a1: 'A1',
  KeyModel.a2: 'A2',
  KeyModel.a3: 'A3',
  KeyModel.a4: 'A4',
};

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
  answer: json['answer'] as String,
  key: $enumDecode(_$KeyModelEnumMap, json['key']),
);

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'key': _$KeyModelEnumMap[instance.key]!,
    };
