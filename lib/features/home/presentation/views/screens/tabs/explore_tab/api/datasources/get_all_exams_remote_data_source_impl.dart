import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/api/api_client/explore_tab_api_client.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/get_all_exams_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/exam_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/get_all_exams_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GetAllExamsRemoteDataSource)
class GetAllExamsRemoteDataSourceImpl implements GetAllExamsRemoteDataSource{
  final ExploreTabApiClient exploreTabApiClient;
  GetAllExamsRemoteDataSourceImpl({required this.exploreTabApiClient});
  @override
  Future<BaseResponse<List<ExamDTO>>> getAllExams(String token) async{
    try{
      GetAllExamsResponse getAllExamsResponse=await exploreTabApiClient.getAllExams(token);
      return SuccessResponse<List<ExamDTO>>(data: getAllExamsResponse.exams!);
    }catch(e){
      return ErrorResponse<List<ExamDTO>>(error: RemoteException.fromDioError(e as Exception));
    }
  }
}