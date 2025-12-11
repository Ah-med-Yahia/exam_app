import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/start_exam/api/api_client/start_exam_api_client.dart';
import 'package:exam_app/features/start_exam/data/datasources/start_exam_remote_data_source.dart';
import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';
import 'package:exam_app/features/start_exam/data/models/get_exam_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: StartExamRemoteDataSource)
class StartExamRemoteDataSourceImpl implements StartExamRemoteDataSource{
  final StartExamApiClient startExamApiClient;
  StartExamRemoteDataSourceImpl(this.startExamApiClient);
  @override
  Future<BaseResponse<ExamDTO>> getExamById(String id, String token) async{
    try{
      GetExamResponse getExamResponse=await startExamApiClient.getExamById(id, token);
      return SuccessResponse<ExamDTO>(data: getExamResponse.exam!);
    }catch(e){
      return ErrorResponse<ExamDTO>(error: RemoteException.fromDioError(e as Exception));
    }
  }
}