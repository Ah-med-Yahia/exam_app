// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswersRequestModel _$AnswersRequestModelFromJson(Map<String, dynamic> json) =>
    AnswersRequestModel(
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerCheckModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: (json['time'] as num).toInt(),
    );

Map<String, dynamic> _$AnswersRequestModelToJson(
  AnswersRequestModel instance,
) => <String, dynamic>{'answers': instance.answers, 'time': instance.time};

AnswerCheckModel _$AnswerCheckModelFromJson(Map<String, dynamic> json) =>
    AnswerCheckModel(
      questionId: json['questionId'] as String,
      correct: json['correct'] as String,
    );

Map<String, dynamic> _$AnswerCheckModelToJson(AnswerCheckModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'correct': instance.correct,
    };
