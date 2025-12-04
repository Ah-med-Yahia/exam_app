import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';

abstract class GetQuestionLocalDataSource {
  BaseResponse<String> getToken();
  Future<BaseResponse<void>> cacheAnswers(String examId,CheckAnswersResponseEntity answers);
}
