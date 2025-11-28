import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/meta_data_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_subjects_response.g.dart';

@JsonSerializable()
class GetAllSubjectsResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "metadata")
    MetadataDTO? metadata;
    @JsonKey(name: "subjects")
    List<SubjectDTO>? subjects;

    GetAllSubjectsResponse({
        this.message,
        this.metadata,
        this.subjects,
    });

    factory GetAllSubjectsResponse.fromJson(Map<String, dynamic> json) => _$GetAllSubjectsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetAllSubjectsResponseToJson(this);
}