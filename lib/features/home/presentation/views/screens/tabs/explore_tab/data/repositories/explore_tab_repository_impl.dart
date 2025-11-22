import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_local_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/repositories/explore_tab_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreTabRepository)
class ExploreTabRepositoryImpl implements ExploreTabRepository {
  final ExploreTabRemoteDataSource exploreTabRemoteDataSource;
  final ExploreTabLocalDataSource exploreTabLocalDataSource;
  ExploreTabRepositoryImpl({
    required this.exploreTabRemoteDataSource,
    required this.exploreTabLocalDataSource,
  });
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
}