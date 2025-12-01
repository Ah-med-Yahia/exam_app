// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_answers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAnswersResponseModel _$CheckAnswersResponseModelFromJson(
  Map<String, dynamic> json,
) => CheckAnswersResponseModel(
  message: json['message'] as String,
  correct: (json['correct'] as num).toInt(),
  wrong: (json['wrong'] as num).toInt(),
  total: json['total'] as String,
  wrongQuestions: (json['WrongQuestions'] as List<dynamic>)
      .map((e) => WrongQuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctQuestions: (json['correctQuestions'] as List<dynamic>)
      .map((e) => CorrectQuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CheckAnswersResponseModelToJson(
  CheckAnswersResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'correct': instance.correct,
  'wrong': instance.wrong,
  'total': instance.total,
  'WrongQuestions': instance.wrongQuestions,
  'correctQuestions': instance.correctQuestions,
};

CorrectQuestionModel _$CorrectQuestionModelFromJson(
  Map<String, dynamic> json,
) => CorrectQuestionModel(
  qid: json['QID'] as String,
  question: json['Question'] as String,
  correctAnswer: json['correctAnswer'] as String,
  answers: Answers.fromJson(json['answers'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CorrectQuestionModelToJson(
  CorrectQuestionModel instance,
) => <String, dynamic>{
  'QID': instance.qid,
  'Question': instance.question,
  'correctAnswer': instance.correctAnswer,
  'answers': instance.answers,
};

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers();

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{};

WrongQuestionModel _$WrongQuestionModelFromJson(Map<String, dynamic> json) =>
    WrongQuestionModel(
      qid: json['QID'] as String,
      question: json['Question'] as String,
      inCorrectAnswer: json['inCorrectAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      answers: Answers.fromJson(json['answers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WrongQuestionModelToJson(WrongQuestionModel instance) =>
    <String, dynamic>{
      'QID': instance.qid,
      'Question': instance.question,
      'inCorrectAnswer': instance.inCorrectAnswer,
      'correctAnswer': instance.correctAnswer,
      'answers': instance.answers,
    };
