import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'answers_request_entity.g.dart';

AnswersRequestEntity answersRequestEntityFromJson(String str) =>
    AnswersRequestEntity.fromJson(json.decode(str));

String answersRequestEntityToJson(AnswersRequestEntity data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AnswersRequestEntity {
  @JsonKey(name: "answers")
  final List<AnswerCheckEntity> answers;
  @JsonKey(name: "time")
  final int time;

  AnswersRequestEntity({required this.answers, required this.time});

  factory AnswersRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AnswersRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersRequestEntityToJson(this);
}

@JsonSerializable()
class AnswerCheckEntity {
  @JsonKey(name: "questionId")
  final String questionId;
  @JsonKey(name: "correct")
  final String correct;

  AnswerCheckEntity({required this.questionId, required this.correct});

  factory AnswerCheckEntity.fromJson(Map<String, dynamic> json) =>
      _$AnswerCheckEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerCheckEntityToJson(this);
}
