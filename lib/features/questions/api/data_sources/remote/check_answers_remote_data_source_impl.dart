import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/api_client/check_answers/check_answers_api_client.dart';
import 'package:exam_app/features/questions/data/datasources/remote/check_answers_remote_data_source.dart';
import 'package:exam_app/features/questions/data/models/answers_request_model/answers_request_model.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CheckAnswersRemoteDataSource)
class CheckAnswersRemoteDataSourceImpl implements CheckAnswersRemoteDataSource {
  final CheckAnswersApiClient apiClient;
  CheckAnswersRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<CheckAnswersResponseModel>> checkAnswers({
    required AnswersRequestModel answers,
    required String token,
  }) async {
    try {
      final response = await apiClient.checkAnswers(answers, token);
      return SuccessResponse<CheckAnswersResponseModel>(data: response);
    } catch (e) {
      return ErrorResponse<CheckAnswersResponseModel>(
          error: RemoteException.fromDioError(e as Exception));
    }
  }
}
