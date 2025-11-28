import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/api/api_client/explore_tab_api_client.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/get_all_subjects_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ExploreTabRemoteDataSource)
class ExploreTabRemoteDataSourceImpl implements ExploreTabRemoteDataSource{
  final ExploreTabApiClient exploreTabApiClient;
  ExploreTabRemoteDataSourceImpl({required this.exploreTabApiClient});
  
  @override
  Future<BaseResponse<List<SubjectDTO>>> getAllSubjects(String token) async{
    try{
      GetAllSubjectsResponse subjectResponse=await exploreTabApiClient.getAllSubjects(token);
      return SuccessResponse<List<SubjectDTO>>(data: subjectResponse.subjects!);  
    }catch(e){
      return ErrorResponse<List<SubjectDTO>>(error: RemoteException.fromDioError(e as Exception));
    }
  }
}