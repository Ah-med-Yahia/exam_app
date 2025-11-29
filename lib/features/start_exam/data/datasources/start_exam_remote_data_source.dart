import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';

abstract class StartExamRemoteDataSource {
  Future<BaseResponse<ExamDTO>> getExamById(String id,String token);
}