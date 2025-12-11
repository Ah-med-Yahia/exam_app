import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';

abstract class GetQuestionsRepository {
  Future<BaseResponse<GetQuestionsResponseEntity>> getQuestions({
    required String examId,
  });
}