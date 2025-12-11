import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';

abstract class ExploreTabRepository {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
  Future<BaseResponse<List<ExamEntity>>> getAllExams();
}