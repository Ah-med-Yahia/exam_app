import 'package:exam_app/features/questions/data/models/question_model/question_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_questions_response_model.g.dart';

GetQuestionsResponseModel getQuestionsResponseModelFromJson(String str) =>
    GetQuestionsResponseModel.fromJson(json.decode(str));

String getQuestionsResponseModelToJson(GetQuestionsResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetQuestionsResponseModel {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "questions")
  final List<QuestionModel> questions;

  GetQuestionsResponseModel({required this.message, required this.questions});

  factory GetQuestionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuestionsResponseModelToJson(this);
}
