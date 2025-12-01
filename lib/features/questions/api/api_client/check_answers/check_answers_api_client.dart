import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/questions/data/models/answers_request_model/answers_request_model.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part   'check_answers_api_client.g.dart';

@singleton
@RestApi()
abstract class CheckAnswersApiClient {
  @factoryMethod
  factory CheckAnswersApiClient(Dio dio) = _CheckAnswersApiClient;

  @POST(ApiConstants.checkAnswers)
  Future<CheckAnswersResponseModel> checkAnswers(
    @Body() AnswersRequestModel answers,
    @Header(ApiConstants.headerTokenKey) String token,
  );
}
