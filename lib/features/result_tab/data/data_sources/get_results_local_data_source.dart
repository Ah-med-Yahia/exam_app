import 'package:exam_app/config/base_response/base_response.dart';

abstract class GetResultsLocalDataSource {
  BaseResponse<String> getToken();
  BaseResponse<List<String>> getExamsIdsHistory();
}