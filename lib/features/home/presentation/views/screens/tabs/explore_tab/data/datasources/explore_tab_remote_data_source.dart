import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';

abstract class ExploreTabRemoteDataSource {
  Future<BaseResponse<List<SubjectDTO>>> getAllSubjects(String token);
}