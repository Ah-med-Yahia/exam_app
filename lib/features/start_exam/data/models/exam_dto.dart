import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exam_dto.g.dart';
@JsonSerializable()
class ExamDTO {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "duration")
    int? duration;
    @JsonKey(name: "subject")
    String? subject;
    @JsonKey(name: "numberOfQuestions")
    int? numberOfQuestions;
    @JsonKey(name: "active")
    bool? active;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;

    ExamDTO({
        this.id,
        this.title,
        this.duration,
        this.subject,
        this.numberOfQuestions,
        this.active,
        this.createdAt,
    });

    factory ExamDTO.fromJson(Map<String, dynamic> json) => _$ExamDTOFromJson(json);

    Map<String, dynamic> toJson() => _$ExamDTOToJson(this);
    ExamEntity toDomain(){
      return ExamEntity(
        id: id,
        title: title,
        numberOfQuestions: numberOfQuestions,
        duration: duration,
        subject: subject
      );
    }
}