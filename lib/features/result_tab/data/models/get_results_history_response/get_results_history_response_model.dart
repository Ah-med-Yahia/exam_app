import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_results_history_response_model.g.dart';

GetResultsHistoryResponseModel getResultsHistoryResponseModelFromJson(String str) => GetResultsHistoryResponseModel.fromJson(json.decode(str));

String getResultsHistoryResponseModelToJson(GetResultsHistoryResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetResultsHistoryResponseModel {
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "history")
    final HistoryModel history;

    GetResultsHistoryResponseModel({
        required this.message,
        required this.history,
    });

    factory GetResultsHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$GetResultsHistoryResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetResultsHistoryResponseModelToJson(this);
}

@JsonSerializable()
class HistoryModel {
    @JsonKey(name: "_id")
    final String id;
    @JsonKey(name: "checkAnswer")
    final String checkAnswer;
    @JsonKey(name: "QID")
    final QuestionModel qid;
    @JsonKey(name: "user")
    final String user;
    @JsonKey(name: "chosenAnswer")
    final String chosenAnswer;
    @JsonKey(name: "avgAnswerTime")
    final String avgAnswerTime;
    @JsonKey(name: "createdAt")
    final DateTime createdAt;

    HistoryModel({
        required this.id,
        required this.checkAnswer,
        required this.qid,
        required this.user,
        required this.chosenAnswer,
        required this.avgAnswerTime,
        required this.createdAt,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => _$HistoryModelFromJson(json);

    Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}

@JsonSerializable()
class QuestionModel {
    @JsonKey(name: "_id")
    final String id;
    @JsonKey(name: "question")
    final String question;
    @JsonKey(name: "answers")
    final List<AnswerModel> answers;
    @JsonKey(name: "type")
    final String type;
    @JsonKey(name: "correct")
    final String correct;
    @JsonKey(name: "subject")
    final String subject;
    @JsonKey(name: "exam")
    final String exam;
    @JsonKey(name: "createdAt")
    final DateTime createdAt;

    QuestionModel({
        required this.id,
        required this.question,
        required this.answers,
        required this.type,
        required this.correct,
        required this.subject,
        required this.exam,
        required this.createdAt,
    });

    factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class AnswerModel {
    @JsonKey(name: "answer")
    final String answer;
    @JsonKey(name: "key")
    final String key;

    AnswerModel({
        required this.answer,
        required this.key,
    });

    factory AnswerModel.fromJson(Map<String, dynamic> json) => _$AnswerModelFromJson(json);

    Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
