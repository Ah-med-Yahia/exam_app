import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/repositories/explore_tab_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetAllSubjectsUseCase {
  final ExploreTabRepository exploreTabRepository;
  GetAllSubjectsUseCase({required this.exploreTabRepository});
  Future<BaseResponse<List<SubjectEntity>>> call(String token)async{
    return exploreTabRepository.getAllSubjects(token);
  }
}