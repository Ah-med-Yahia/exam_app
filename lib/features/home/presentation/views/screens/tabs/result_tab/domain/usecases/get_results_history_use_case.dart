import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/entities/get_results_history_response_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/repositories/get_results_history_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetResultsHistoryUseCase {
  final GetResultsRepository repository;

  GetResultsHistoryUseCase(this.repository);

  Future<BaseResponse<GetResultsHistoryResponseEntity>> call() async {
    return await repository.getResultsHistory();
  }
}