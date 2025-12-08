import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';

abstract class GetResultsLocalDataSource {
  BaseResponse<String> getToken();
  BaseResponse<List<CachedExamResultModel>> getResultsHistory();
}