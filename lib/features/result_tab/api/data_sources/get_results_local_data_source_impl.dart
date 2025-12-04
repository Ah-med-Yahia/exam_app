import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/result_tab/data/data_sources/get_results_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetResultsLocalDataSource)
class GetResultsLocalDataSourceImpl implements GetResultsLocalDataSource {
  final Box<String> tokenBox;
  final Box<List<String>> examsBox;
  GetResultsLocalDataSourceImpl(this.tokenBox, this.examsBox);
  @override
  BaseResponse<String> getToken() {
    try {
      String? token = tokenBox.get(CacheConstants.tokenKey);
      if (token == null) {
        throw (Exception());
      } else {
        return SuccessResponse<String>(data: token);
      }
    } catch (e) {
      return ErrorResponse<String>(
        error: LocalException(message: 'Failed to get token locally'),
      );
    }
  }
  
  @override
  BaseResponse<List<String>> getExamsIdsHistory() {
    try {
      final examsIds = examsBox.get(CacheConstants.cachedExamsKey);
      if (examsIds == null) {
        throw (Exception());
      } else {
        return SuccessResponse<List<String>>(data: examsIds);
      }
    } catch (e) {
      return ErrorResponse<List<String>>(
        error: LocalException(message: 'Failed to get exams history locally'),
      );
    }
  }
}
