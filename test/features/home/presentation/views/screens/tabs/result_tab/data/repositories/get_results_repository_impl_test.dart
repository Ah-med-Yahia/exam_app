import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/api/data_sources/get_results_local_data_source_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/api/data_sources/get_results_remote_data_source_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/repositories/get_results_repository_impl.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_results_repository_impl_test.mocks.dart';

@GenerateMocks([GetResultsLocalDataSourceImpl, GetResultsRemoteDataSourceImpl])
void main() {
  late GetResultsRepositoryImpl repository;
  late MockGetResultsLocalDataSourceImpl mockLocalDataSource;
  late MockGetResultsRemoteDataSourceImpl mockremoteDataSource;
  late CachedExamResultModel testCachedExamModel;

  setUpAll(() {
    mockLocalDataSource = MockGetResultsLocalDataSourceImpl();
    mockremoteDataSource = MockGetResultsRemoteDataSourceImpl();
    repository = GetResultsRepositoryImpl(
      remoteDataSource: mockremoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    repository.localDataSource = mockLocalDataSource;
    testCachedExamModel = CachedExamResultModel(
      answers: CheckAnswersResponseEntity(
        message: 'message',
        correct: 2,
        wrong: 2,
        total: 'total',
        wrongQuestions: [],
        correctQuestions: [],
      ),
      exam: ExamEntity(title: 'title', duration: 20, numberOfQuestions: 20),
      questions: [],
    );
    provideDummy <BaseResponse<List<CachedExamResultModel>>>(
      SuccessResponse<List<CachedExamResultModel>>(data: [testCachedExamModel]),
    );
  });

  group('GetResultsRepositoryImpl', () {
    test(
      'should return SuccessResponse with entity list when local call succeeds',
      () {
        when(mockLocalDataSource.getResultsHistory()).thenReturn(
          SuccessResponse<List<CachedExamResultModel>>(
            data: [testCachedExamModel],
          ),
        );

        
        final result = repository.getCachedResultsHistory();

        
        expect(result, isA<SuccessResponse<List<CachedExamResultEntity>>>());

        verify(mockLocalDataSource.getResultsHistory()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );
    test('should return ErrorResponse when local call fails', () {
      when(
        mockLocalDataSource.getResultsHistory(),
      ).thenReturn(ErrorResponse<List<CachedExamResultModel>>(error: LocalException(message: 'Local error')));

      
      final result = repository.getCachedResultsHistory();

      
      expect(result, isA<ErrorResponse<List<CachedExamResultEntity>>>());
      expect((result as ErrorResponse).error.message, 'Local error');

      verify(mockLocalDataSource.getResultsHistory()).called(1);
    });
  });
}
