import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';
import 'package:exam_app/features/start_exam/data/models/get_exam_response.dart';
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
  @GET('${ApiConstants.gettingAllExamsEndPoint}/{id}')
  Future<GetExamResponse> getExamById(@Path("id") String id,@Header("token") String token);
}
