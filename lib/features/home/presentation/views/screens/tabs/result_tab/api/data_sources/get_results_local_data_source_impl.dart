import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/api/api_client/get_results_api_client.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/data_sources/get_results_local_data_source.dart';
import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';
import 'package:exam_app/features/start_exam/data/models/get_exam_response.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetResultsLocalDataSource)
class GetResultsLocalDataSourceImpl implements GetResultsLocalDataSource {
  final Box<String> tokenBox;
  final Box<List<String>> examsBox;
  final GetResultsApiClient getResultsApiClient;
  GetResultsLocalDataSourceImpl(this.tokenBox, this.examsBox,this.getResultsApiClient);
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
  Future<BaseResponse<List<ExamDTO>>> getExamsIdsHistory() async{
    try {
      String? token = tokenBox.get(CacheConstants.tokenKey);
      final examsIds = examsBox.get(CacheConstants.cachedExamsKey);
      if (examsIds == null || token==null) {
        throw (Exception());
      } else {
        List<Future<GetExamResponse>> futureExamsResponses= examsIds.map((id) => getResultsApiClient.getExamById(id, token),).toList();
        List<GetExamResponse> examsResponses=await Future.wait(futureExamsResponses);
        List<ExamDTO> examsDTOs=examsResponses.map((res) =>res.exam! ,).toList();
        return SuccessResponse<List<ExamDTO>>(data:examsDTOs );
      }
    } catch (e) {
      return ErrorResponse<List<ExamDTO>>(
        error: LocalException(message: 'Failed to get exams history locally'),
      );
    }
  }
}
