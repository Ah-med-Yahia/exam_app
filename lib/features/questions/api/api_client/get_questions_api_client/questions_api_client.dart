import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'questions_api_client.g.dart';

@singleton
@RestApi()
abstract class GetQuestionsApiClient {
  @factoryMethod
  factory GetQuestionsApiClient(Dio dio) = _GetQuestionsApiClient;

  @GET(ApiConstants.questionsEndPoint)
  Future<GetQuestionsResponseModel> getAllQuestions(
    @Query(ApiConstants.examQueryKey) String examId,
    @Header(ApiConstants.headerTokenKey) String token
  );
}
