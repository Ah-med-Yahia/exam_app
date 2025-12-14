import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/data_sources/local/cache_result_local_data_source_impl.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'cache_result_local_data_source_impl_test.mocks.dart';

@GenerateMocks([Box<CachedExamResultModel>])
void main() {
  late CacheResultLocalDataSourceImpl dataSource;
  late MockBox<CachedExamResultModel> mockBox;

  final tCachedResult = CachedExamResultModel(
    answers: CheckAnswersResponseEntity(
      message: 'message',
      correct: 2,
      wrong: 4,
      total: '20',
      wrongQuestions: [
        WrongQuestionEntity(
          qid: 'qid',
          question: 'question',
          inCorrectAnswer: 'A2',
          correctAnswer: 'A1',
        ),
      ],
      correctQuestions: [
        CorrectQuestionEntity(
          qid: 'qid',
          question: 'question',
          correctAnswer: 'A1',
        ),
      ],
    ),
    exam: ExamEntity(title: 'title', duration: 20, numberOfQuestions: 20),
    questions: [],
  );

  setUpAll(() {
    mockBox = MockBox<CachedExamResultModel>();
    dataSource = CacheResultLocalDataSourceImpl(mockBox);
  });

  group('CacheResultLocalDataSourceImpl', () {
    test('should return SuccessResponse when caching succeeds', () async {
      when(mockBox.add(tCachedResult)).thenAnswer((_) async => 0);

      final result = await dataSource.cacheResult(tCachedResult);

      expect(result, isA<SuccessResponse<void>>());

      verify(mockBox.add(tCachedResult)).called(1);
      verifyNoMoreInteractions(mockBox);
    });
    test('should return ErrorResponse when caching throws exception', () async {
      when(mockBox.add(tCachedResult)).thenThrow(Exception('Hive error'));

      final result = await dataSource.cacheResult(tCachedResult);

      expect(result, isA<ErrorResponse<void>>());
      expect((result as ErrorResponse).error, isA<LocalException>());

      verify(mockBox.add(tCachedResult)).called(1);
    });
  });
}
