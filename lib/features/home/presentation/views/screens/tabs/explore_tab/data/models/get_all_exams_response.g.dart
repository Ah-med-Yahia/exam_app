// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_exams_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllExamsResponse _$GetAllExamsResponseFromJson(Map<String, dynamic> json) =>
    GetAllExamsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDTO.fromJson(json['metadata'] as Map<String, dynamic>),
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => ExamDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllExamsResponseToJson(
  GetAllExamsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'exams': instance.exams,
};
