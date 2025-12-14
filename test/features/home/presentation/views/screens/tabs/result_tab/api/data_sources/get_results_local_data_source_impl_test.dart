import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/api/data_sources/get_results_local_data_source_impl.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../../../../../questions/api/data_sources/local/cache_result_local_data_source_impl_test.mocks.dart';

@GenerateMocks([Box<String>, Box<CachedExamResultModel>])
void main() {
  late GetResultsLocalDataSourceImpl dataSource;
  late MockBox<String> mockTokenBox;
  late MockBox<CachedExamResultModel> mockResultsBox;
  late CachedExamResultModel testCachedExamModel;

  setUpAll(() {
    mockTokenBox = MockBox<String>();
    mockResultsBox = MockBox<CachedExamResultModel>();
    dataSource = GetResultsLocalDataSourceImpl(mockTokenBox, mockResultsBox);
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
  });

  group('GetResultsLocalDataSourceImpl', () {
    group('success cases', () {
      test('getToken should return ErrorResponse when token is null', () {
        when(mockTokenBox.get(CacheConstants.tokenKey)).thenReturn(null);

        final result = dataSource.getToken();

        expect(result, isA<ErrorResponse<String>>());
        expect((result as ErrorResponse).error, isA<LocalException>());

        verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
      });
    });

    group('error cases', () {
      test('getToken should return ErrorResponse when token is null', () {
        when(mockTokenBox.get(CacheConstants.tokenKey)).thenReturn(null);

        final result = dataSource.getToken();

        expect(result, isA<ErrorResponse<String>>());
        expect((result as ErrorResponse).error, isA<LocalException>());

        verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
      });

      test('getToken should return ErrorResponse when box.get throws', () {
        when(mockTokenBox.get(CacheConstants.tokenKey)).thenThrow(Exception());

        final result = dataSource.getToken();

        expect(result, isA<ErrorResponse<String>>());
        expect((result as ErrorResponse).error, isA<LocalException>());

        verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
      });
    });

    test(
      'getResultsHistory should return SuccessResponse when box has values',
      () {
        when(mockResultsBox.values).thenReturn([testCachedExamModel]);

        final result = dataSource.getResultsHistory();

        expect(result, isA<SuccessResponse<List<CachedExamResultModel>>>());
        expect((result as SuccessResponse).data, [testCachedExamModel]);

        verify(mockResultsBox.values).called(1);
        verifyNoMoreInteractions(mockResultsBox);
      },
    );
    test(
      'getResultsHistory should return ErrorResponse when box.values throws',
      () {
        when(mockResultsBox.values).thenThrow(Exception());

        final result = dataSource.getResultsHistory();

        expect(result, isA<ErrorResponse<List<CachedExamResultModel>>>());
        expect((result as ErrorResponse).error, isA<LocalException>());

        verify(mockResultsBox.values).called(1);
      },
    );
  });
}
