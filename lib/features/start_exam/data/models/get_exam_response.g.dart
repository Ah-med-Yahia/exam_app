// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exam_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExamResponse _$GetExamResponseFromJson(Map<String, dynamic> json) =>
    GetExamResponse(
      message: json['message'] as String?,
      exam: json['exam'] == null
          ? null
          : ExamDTO.fromJson(json['exam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetExamResponseToJson(GetExamResponse instance) =>
    <String, dynamic>{'message': instance.message, 'exam': instance.exam};
