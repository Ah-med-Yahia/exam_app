import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';

abstract class StartExamRepository {
  Future<BaseResponse<ExamEntity>> getExamById(String id);
}