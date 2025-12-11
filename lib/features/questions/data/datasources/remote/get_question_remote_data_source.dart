import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';

abstract class GetQuestionRemoteDataSource {
  Future<BaseResponse<GetQuestionsResponseModel>> getQuestions(String examId,String token);
}
