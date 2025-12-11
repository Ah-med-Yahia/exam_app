import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/start_exam/data/models/get_exam_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'start_exam_api_client.g.dart';
@injectable
@RestApi()
abstract class StartExamApiClient {
  @factoryMethod
  factory StartExamApiClient(Dio dio)=_StartExamApiClient;

  @GET('${ApiConstants.gettingAllExamsEndPoint}/{id}')
  Future<GetExamResponse> getExamById(@Path("id") String id,@Header("token") String token);
}