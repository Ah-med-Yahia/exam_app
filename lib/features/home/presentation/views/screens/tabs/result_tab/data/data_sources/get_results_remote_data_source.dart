import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';

abstract class GetResultsRemoteDataSource {
  Future<BaseResponse<GetResultsHistoryResponseModel>> getResultsHistory(String token);
}