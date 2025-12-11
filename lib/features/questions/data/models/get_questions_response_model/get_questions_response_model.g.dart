// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_questions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuestionsResponseModel _$GetQuestionsResponseModelFromJson(
  Map<String, dynamic> json,
) => GetQuestionsResponseModel(
  message: json['message'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetQuestionsResponseModelToJson(
  GetQuestionsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'questions': instance.questions,
};
