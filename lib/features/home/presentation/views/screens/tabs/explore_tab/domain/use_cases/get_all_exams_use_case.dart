import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/repositories/explore_tab_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetAllExamsUseCase {
  final ExploreTabRepository exploreTabRepository;
  GetAllExamsUseCase({required this.exploreTabRepository});
  Future<BaseResponse<List<ExamEntity>>> call()async{
    return exploreTabRepository.getAllExams();
  }
}