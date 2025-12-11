import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'check_answers_response_model.g.dart';

CheckAnswersResponseModel checkAnswersResponseModelFromJson(String str) =>
    CheckAnswersResponseModel.fromJson(json.decode(str));

String checkAnswersResponseModelToJson(CheckAnswersResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CheckAnswersResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "correct")
  final int correct;
  @JsonKey(name: "wrong")
  final int wrong;
  @JsonKey(name: "total")
  final String total;
  @JsonKey(name: "WrongQuestions")
  final List<WrongQuestionModel> wrongQuestions;
  @JsonKey(name: "correctQuestions")
  final List<CorrectQuestionModel> correctQuestions;

  CheckAnswersResponseModel({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });

  factory CheckAnswersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckAnswersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAnswersResponseModelToJson(this);
}

@JsonSerializable()
class CorrectQuestionModel {
  @JsonKey(name: "QID")
  final String qid;
  @JsonKey(name: "Question")
  final String question;
  @JsonKey(name: "correctAnswer")
  final String correctAnswer;
  @JsonKey(name: "answers")
  final Answers answers;

  CorrectQuestionModel({
    required this.qid,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  factory CorrectQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$CorrectQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectQuestionModelToJson(this);
}

@JsonSerializable()
class Answers {
  Answers();

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);
}

@JsonSerializable()
class WrongQuestionModel {
  @JsonKey(name: "QID")
  final String qid;
  @JsonKey(name: "Question")
  final String question;
  @JsonKey(name: "inCorrectAnswer")
  final String inCorrectAnswer;
  @JsonKey(name: "correctAnswer")
  final String correctAnswer;
  @JsonKey(name: "answers")
  final Answers answers;

  WrongQuestionModel({
    required this.qid,
    required this.question,
    required this.inCorrectAnswer,
    required this.correctAnswer,
    required this.answers,
  });

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$WrongQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WrongQuestionModelToJson(this);
}
