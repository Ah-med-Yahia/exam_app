
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'answers_request_model.g.dart';

AnswersRequestModel answersRequestModelFromJson(String str) => AnswersRequestModel.fromJson(json.decode(str));

String answersRequestModelToJson(AnswersRequestModel data) => json.encode(data.toJson());

@JsonSerializable()
class AnswersRequestModel {
    @JsonKey(name: "answers")
    final List<AnswerCheckModel> answers;
    @JsonKey(name: "time")
    final int time;

    AnswersRequestModel({
        required this.answers,
        required this.time,
    });

    factory AnswersRequestModel.fromJson(Map<String, dynamic> json) => _$AnswersRequestModelFromJson(json);

    Map<String, dynamic> toJson() => _$AnswersRequestModelToJson(this);
}

@JsonSerializable()
class AnswerCheckModel {
    @JsonKey(name: "questionId")
    final String questionId;
    @JsonKey(name: "correct")
    final String correct;

    AnswerCheckModel({
        required this.questionId,
        required this.correct,
    });

    factory AnswerCheckModel.fromJson(Map<String, dynamic> json) => _$AnswerCheckModelFromJson(json);

    Map<String, dynamic> toJson() => _$AnswerCheckModelToJson(this);
}
