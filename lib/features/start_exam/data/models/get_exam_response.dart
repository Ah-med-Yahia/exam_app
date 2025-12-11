import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_exam_response.g.dart';

@JsonSerializable()
class GetExamResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "exam")
    ExamDTO? exam;

    GetExamResponse({
        this.message,
        this.exam,
    });

    factory GetExamResponse.fromJson(Map<String, dynamic> json) => _$GetExamResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetExamResponseToJson(this);
}


