import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/models/answers_request_model/answers_request_model.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';

abstract class CheckAnswersRemoteDataSource {
  Future<BaseResponse<CheckAnswersResponseModel>> checkAnswers({
    required AnswersRequestModel answers,
    required String token,
  });
}