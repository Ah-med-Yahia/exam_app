import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/result_tab/domain/entities/get_results_history_response_entity.dart';

abstract class GetResultsRepository {
  Future<BaseResponse<GetResultsHistoryResponseEntity>> getResultsHistory();
}