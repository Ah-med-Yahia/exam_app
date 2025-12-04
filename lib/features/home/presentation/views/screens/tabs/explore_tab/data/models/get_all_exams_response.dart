import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/exam_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/meta_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_exams_response.g.dart';

@JsonSerializable()
class GetAllExamsResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "metadata")
    MetadataDTO? metadata;
    @JsonKey(name: "exams")
    List<ExamDTO>? exams;

    GetAllExamsResponse({
        this.message,
        this.metadata,
        this.exams,
    });

    factory GetAllExamsResponse.fromJson(Map<String, dynamic> json) => _$GetAllExamsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetAllExamsResponseToJson(this);
}




