import 'package:exam_app/features/questions/data/models/exam_model/exam_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: "answers")
  final List<AnswerModel> answers;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "question")
  final String question;

  @JsonKey(name: "correct")
  final KeyModel correct;

  @JsonKey(name: "subject")
  final dynamic subject;

  @JsonKey(name: "exam")
  final ExamModel exam;

  @JsonKey(name: "createdAt")
  final DateTime createdAt;

  QuestionModel({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    required this.subject,
    required this.exam,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class AnswerModel {
  @JsonKey(name: "answer")
  final String answer;

  @JsonKey(name: "key")
  final KeyModel key;

  AnswerModel({required this.answer, required this.key});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}

enum KeyModel {
  @JsonValue("A1")
  a1,
  @JsonValue("A2")
  a2,
  @JsonValue("A3")
  a3,
  @JsonValue("A4")
  a4,
}
