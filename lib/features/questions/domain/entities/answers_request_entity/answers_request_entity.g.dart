// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswersRequestEntity _$AnswersRequestEntityFromJson(
  Map<String, dynamic> json,
) => AnswersRequestEntity(
  answers: (json['answers'] as List<dynamic>)
      .map((e) => AnswerCheckEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  time: (json['time'] as num).toInt(),
);

Map<String, dynamic> _$AnswersRequestEntityToJson(
  AnswersRequestEntity instance,
) => <String, dynamic>{'answers': instance.answers, 'time': instance.time};

AnswerCheckEntity _$AnswerCheckEntityFromJson(Map<String, dynamic> json) =>
    AnswerCheckEntity(
      questionId: json['questionId'] as String,
      correct: json['correct'] as String,
    );

Map<String, dynamic> _$AnswerCheckEntityToJson(AnswerCheckEntity instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'correct': instance.correct,
    };
