import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/datasources/local/get_question_local_data_source.dart';
import 'package:exam_app/features/questions/data/datasources/remote/check_answers_remote_data_source.dart';
import 'package:exam_app/features/questions/data/mappers/check_answers_request_mapper.dart';
import 'package:exam_app/features/questions/data/mappers/check_answers_response_mapper.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/answers_check_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AnswersCheckRepository)
class AnswersCheckRepositoryImpl implements AnswersCheckRepository {
  final CheckAnswersRemoteDataSource remoteDataSource;
  final GetQuestionLocalDataSource localDataSource;

  AnswersCheckRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<BaseResponse<CheckAnswersResponseEntity>> checkAnswers({
    required AnswersRequestEntity answers,
  }) async {
    final tokenResponse = localDataSource.getToken();
    switch (tokenResponse) {
      case SuccessResponse<String>():
        final response = await remoteDataSource.checkAnswers(
          answers: answers.toModel,
          token: tokenResponse.data,
        );
        switch (response) {
          case SuccessResponse<CheckAnswersResponseModel>():
            return SuccessResponse<CheckAnswersResponseEntity>(
              data: response.data.toEntity(),
            );
          case ErrorResponse<CheckAnswersResponseModel>():
            return ErrorResponse<CheckAnswersResponseEntity>(
              error: response.error,
            );
        }
      case ErrorResponse<String>():
        return ErrorResponse<CheckAnswersResponseEntity>(
          error: tokenResponse.error,
        );
    }
  }

  @override
  Future<BaseResponse<void>> cacheAnswers(
    String examId,
    CheckAnswersResponseEntity answers,
  ) async {
    final response = await localDataSource.cacheAnswers(examId, answers);
    switch (response) {
      case SuccessResponse<void>():
        return SuccessResponse<void>(data: null);
      case ErrorResponse<void>():
        return ErrorResponse<void>(error: response.error);
    }
  }
}
