import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/api/api_client/get_results_api_client.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/data_sources/get_results_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetResultsRemoteDataSource)
class GetResultsRemoteDataSourceImpl implements GetResultsRemoteDataSource {
  final GetResultsApiClient apiClient;
  GetResultsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BaseResponse<GetResultsHistoryResponseModel>> getResultsHistory(
    String token,
  ) async {
    try {
      final response = await apiClient.getResultsHistory(token);
      return SuccessResponse<GetResultsHistoryResponseModel>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<GetResultsHistoryResponseModel>(
        error: RemoteException.fromDioError(e),
      );
    }
  }
}
