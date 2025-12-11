import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/home/tabs/result_tab/domain/repositories/get_results_history_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetLocalResultsHistoryUseCase {
  final GetResultsRepository repository;

  GetLocalResultsHistoryUseCase(this.repository);

  BaseResponse<List<CachedExamResultEntity>> call()  {
    return  repository.getCachedResultsHistory();
  }
}
