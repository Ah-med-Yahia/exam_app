import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/get_all_subjects_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'explore_tab_api_client.g.dart';
@injectable
@RestApi()
abstract class ExploreTabApiClient {
  @factoryMethod
  factory ExploreTabApiClient(Dio dio)=_ExploreTabApiClient;
  
  @GET(ApiConstants.gettingAllSubjectsEndPoint)
  Future<GetAllSubjectsResponse> getAllSubjects(@Header("token") String token);
}