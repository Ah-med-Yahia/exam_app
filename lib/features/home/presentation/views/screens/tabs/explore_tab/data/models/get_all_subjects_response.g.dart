// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_subjects_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSubjectsResponse _$GetAllSubjectsResponseFromJson(
  Map<String, dynamic> json,
) => GetAllSubjectsResponse(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : MetadataDTO.fromJson(json['metadata'] as Map<String, dynamic>),
  subjects: (json['subjects'] as List<dynamic>?)
      ?.map((e) => SubjectDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetAllSubjectsResponseToJson(
  GetAllSubjectsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'subjects': instance.subjects,
};
