import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'get_results_api_client.g.dart';

@singleton
@RestApi()
abstract class GetResultsApiClient {
  @factoryMethod
  factory GetResultsApiClient(Dio dio) = _GetResultsApiClient;

  @GET(ApiConstants.userResultsHistory)
  Future<GetResultsHistoryResponseModel> getResultsHistory(
    @Header(ApiConstants.headerTokenKey) String token
  );
}
