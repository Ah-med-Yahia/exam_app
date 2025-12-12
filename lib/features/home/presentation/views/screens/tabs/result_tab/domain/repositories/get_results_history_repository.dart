import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/entities/get_results_history_response_entity.dart';

abstract class GetResultsRepository {
  Future<BaseResponse<GetResultsHistoryResponseEntity>> getResultsHistory();
  BaseResponse<List<CachedExamResultEntity>> getCachedResultsHistory();
}
