import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/api_client/get_questions_api_client/questions_api_client.dart';
import 'package:exam_app/features/questions/data/datasources/remote/get_question_remote_data_source.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetQuestionRemoteDataSource)
class GetQuestionsRemoteDataSourcesImpl implements GetQuestionRemoteDataSource {
  final GetQuestionsApiClient apiClient;
  GetQuestionsRemoteDataSourcesImpl({required this.apiClient});

  @override
  Future<BaseResponse<GetQuestionsResponseModel>> getQuestions(
    String examId,
    String token
  ) async {
    try {
      final response = await apiClient.getAllQuestions(examId,token);
      return SuccessResponse<GetQuestionsResponseModel>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<GetQuestionsResponseModel>(
          error: RemoteException.fromDioError(e));
    }
  }
}
