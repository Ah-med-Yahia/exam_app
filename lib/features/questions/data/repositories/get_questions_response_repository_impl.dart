import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/datasources/local/get_question_local_data_source.dart';
import 'package:exam_app/features/questions/data/datasources/remote/get_question_remote_data_source.dart';
import 'package:exam_app/features/questions/data/mappers/get_questions_response_mapper.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/get_questions_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetQuestionsRepository)
class GetQuestionsResponseRepositoryImpl implements GetQuestionsRepository {
  GetQuestionRemoteDataSource remoteDataSource;
  GetQuestionLocalDataSource localDataSource;
  GetQuestionsResponseRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<BaseResponse<GetQuestionsResponseEntity>> getQuestions({
    required String examId,
  }) async {
    final tokenResponse = localDataSource.getToken();
    switch (tokenResponse) {
      case SuccessResponse<String>():
        final response = await remoteDataSource.getQuestions(
          examId,
          tokenResponse.data,
        );
        switch (response) {
          case SuccessResponse<GetQuestionsResponseModel>():
            return SuccessResponse<GetQuestionsResponseEntity>(
              data: response.data.toEntity(),
            );
          case ErrorResponse<GetQuestionsResponseModel>():
            return ErrorResponse<GetQuestionsResponseEntity>(
              error: response.error,
            );
        }
      case ErrorResponse<String>():
        return ErrorResponse<GetQuestionsResponseEntity>(
          error: tokenResponse.error,
        );
    }
  }
}
