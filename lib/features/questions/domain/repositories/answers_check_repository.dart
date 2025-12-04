import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';

abstract class AnswersCheckRepository {
  Future<BaseResponse<CheckAnswersResponseEntity>> checkAnswers({
    required AnswersRequestEntity answers,
  });

  Future<BaseResponse<void>> cacheAnswers(
      String examId, CheckAnswersResponseEntity answers);
}