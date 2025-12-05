import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/entities/get_results_history_response_entity.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';

abstract class GetResultsRepository {
  Future<BaseResponse<GetResultsHistoryResponseEntity>> getResultsHistory();

  Future<BaseResponse<List<ExamEntity>>> getExamsIdHistory();
}
