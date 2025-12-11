// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_results_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResultsHistoryResponseModel _$GetResultsHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => GetResultsHistoryResponseModel(
  message: json['message'] as String,
  history: HistoryModel.fromJson(json['history'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetResultsHistoryResponseModelToJson(
  GetResultsHistoryResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'history': instance.history,
};

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
  id: json['_id'] as String,
  checkAnswer: json['checkAnswer'] as String,
  qid: QuestionModel.fromJson(json['QID'] as Map<String, dynamic>),
  user: json['user'] as String,
  chosenAnswer: json['chosenAnswer'] as String,
  avgAnswerTime: json['avgAnswerTime'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'checkAnswer': instance.checkAnswer,
      'QID': instance.qid,
      'user': instance.user,
      'chosenAnswer': instance.chosenAnswer,
      'avgAnswerTime': instance.avgAnswerTime,
      'createdAt': instance.createdAt.toIso8601String(),
    };

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['_id'] as String,
      question: json['question'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      correct: json['correct'] as String,
      subject: json['subject'] as String,
      exam: json['exam'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'type': instance.type,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt.toIso8601String(),
    };

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) =>
    AnswerModel(answer: json['answer'] as String, key: json['key'] as String);

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{'answer': instance.answer, 'key': instance.key};
