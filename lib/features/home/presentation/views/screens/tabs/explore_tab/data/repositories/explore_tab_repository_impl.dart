import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_local_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/get_all_exams_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/exam_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/repositories/explore_tab_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreTabRepository)
class ExploreTabRepositoryImpl implements ExploreTabRepository {
  final ExploreTabRemoteDataSource exploreTabRemoteDataSource;
  final ExploreTabLocalDataSource exploreTabLocalDataSource;
  final GetAllExamsRemoteDataSource getAllExamsRemoteDataSource;
  ExploreTabRepositoryImpl(
     this.exploreTabRemoteDataSource,
     this.exploreTabLocalDataSource,
     this.getAllExamsRemoteDataSource
  );
  @override
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() async {
    BaseResponse<String> tokenResponse = await exploreTabLocalDataSource
        .getToken();
    switch (tokenResponse) {
      case SuccessResponse<String>():
        BaseResponse<List<SubjectDTO>> subjectsResponse =
            await exploreTabRemoteDataSource.getAllSubjects(tokenResponse.data);
        switch (subjectsResponse) {
          case SuccessResponse<List<SubjectDTO>>():
            List<SubjectDTO> subjectsDTO = subjectsResponse.data;
            List<SubjectEntity> subjects = subjectsDTO
                .map((e) => e.toDomain())
                .toList();
            return SuccessResponse<List<SubjectEntity>>(data: subjects);
          case ErrorResponse<List<SubjectDTO>>():
            return ErrorResponse<List<SubjectEntity>>(
              error: subjectsResponse.error,
            );
        }
      case ErrorResponse<String>():
        return ErrorResponse<List<SubjectEntity>>(error: tokenResponse.error);
    }
  }

  @override
  Future<BaseResponse<List<ExamEntity>>> getAllExams() async{
    BaseResponse<String> tokenResponse=await exploreTabLocalDataSource.getToken();
    switch(tokenResponse){
      
      case SuccessResponse<String>():
        BaseResponse<List<ExamDTO>> examsResponse=await getAllExamsRemoteDataSource.getAllExams(tokenResponse.data);
        switch(examsResponse){
          
          case SuccessResponse<List<ExamDTO>>():
            List<ExamDTO> examsDTOS=examsResponse.data;
            List<ExamEntity> exams=examsDTOS.map((exam) =>exam.toDomain() ,).toList();
            return SuccessResponse<List<ExamEntity>>(data: exams);
          case ErrorResponse<List<ExamDTO>>():
            return ErrorResponse<List<ExamEntity>>(error: examsResponse.error);
        }
      case ErrorResponse<String>():
        return ErrorResponse<List<ExamEntity>>(error: tokenResponse.error);
    }
  }
}