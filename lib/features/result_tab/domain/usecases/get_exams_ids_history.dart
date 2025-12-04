import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/result_tab/domain/repositories/get_results_history_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetExamsIdsHistoryUseCase {
  final GetResultsRepository repository;

  GetExamsIdsHistoryUseCase(this.repository);

  BaseResponse<List<String>> call()  {
    return repository.getExamsIdHistory();
  }
}