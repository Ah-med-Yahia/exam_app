import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/start_exam/data/datasources/start_exam_local_data_source.dart';
import 'package:exam_app/features/start_exam/data/datasources/start_exam_remote_data_source.dart';
import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:exam_app/features/start_exam/domain/repositories/start_exam_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: StartExamRepository)
class StartExamRepositoryImpl implements StartExamRepository{
  final StartExamLocalDataSource startExamLocalDataSource;
  final StartExamRemoteDataSource startExamRemoteDataSource;
  StartExamRepositoryImpl(this.startExamLocalDataSource,this.startExamRemoteDataSource);
  @override
  Future<BaseResponse<ExamEntity>> getExamById(String id) async{
    BaseResponse<String> tokenResponse=await startExamLocalDataSource.getToken();
    switch(tokenResponse){
      
      case SuccessResponse<String>():
        BaseResponse<ExamDTO> examDTOResponse=await startExamRemoteDataSource.getExamById(id, tokenResponse.data);
        switch(examDTOResponse){
          
          case SuccessResponse<ExamDTO>():
            ExamDTO examDTO=examDTOResponse.data;
            ExamEntity examEntity=examDTO.toDomain();
            return SuccessResponse<ExamEntity>(data: examEntity);
          case ErrorResponse<ExamDTO>():
            return ErrorResponse<ExamEntity>(error: examDTOResponse.error);
        }
      case ErrorResponse<String>():
        return ErrorResponse<ExamEntity>(error: tokenResponse.error);
    }
  }

}