import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/data/mappers/cached_exam_result_mapper.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/data_sources/get_results_local_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/data_sources/get_results_remote_data_source.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/mappers/get_results_history_response_mapper.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/entities/get_results_history_response_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/repositories/get_results_history_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetResultsRepository)
class GetResultsRepositoryImpl implements GetResultsRepository {
  GetResultsRemoteDataSource remoteDataSource;
  GetResultsLocalDataSource localDataSource;
  GetResultsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<BaseResponse<GetResultsHistoryResponseEntity>>
  getResultsHistory() async {
    final tokenResponse = localDataSource.getToken();
    switch (tokenResponse) {
      case SuccessResponse<String>():
        final response = await remoteDataSource.getResultsHistory(
          tokenResponse.data,
        );
        switch (response) {
          case SuccessResponse<GetResultsHistoryResponseModel>():
            return SuccessResponse<GetResultsHistoryResponseEntity>(
              data: response.data.toEntity(),
            );
          case ErrorResponse<GetResultsHistoryResponseModel>():
            return ErrorResponse<GetResultsHistoryResponseEntity>(
              error: response.error,
            );
        }
      case ErrorResponse<String>():
        return ErrorResponse<GetResultsHistoryResponseEntity>(
          error: tokenResponse.error,
        );
    }
  }

  @override
  BaseResponse<List<CachedExamResultEntity>> getCachedResultsHistory() {
    final response = localDataSource.getResultsHistory();
    switch (response) {
      case SuccessResponse<List<CachedExamResultModel>>():
        return SuccessResponse<List<CachedExamResultEntity>>(
          data: response.data.map((m) => m.toEntity).toList(),
        );
      case ErrorResponse<List<CachedExamResultModel>>():
        return ErrorResponse<List<CachedExamResultEntity>>(
          error: response.error,
        );
    }
  }
}
