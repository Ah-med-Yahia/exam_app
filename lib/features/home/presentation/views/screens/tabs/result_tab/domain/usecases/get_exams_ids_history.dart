import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/repositories/get_results_history_repository.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetExamsIdsHistoryUseCase {
  final GetResultsRepository repository;

  GetExamsIdsHistoryUseCase(this.repository);

  Future<BaseResponse<List<ExamEntity>>> call()  async{
    return repository.getExamsIdHistory();
  }
}