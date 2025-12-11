import 'package:json_annotation/json_annotation.dart';
part 'exam_model.g.dart';

@JsonSerializable()
class ExamModel {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "duration")
  final int duration;

  @JsonKey(name: "subject")
  final String subject;

  @JsonKey(name: "numberOfQuestions")
  final int numberOfQuestions;

  @JsonKey(name: "active")
  final bool active;

  @JsonKey(name: "createdAt")
  final DateTime createdAt;

  ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}
