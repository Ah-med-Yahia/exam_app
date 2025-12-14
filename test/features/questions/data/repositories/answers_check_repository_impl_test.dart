import 'package:dio/dio.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/data_sources/local/cache_result_local_data_source_impl.dart';
import 'package:exam_app/features/questions/api/data_sources/local/get_questions_local_data_source_impl.dart';
import 'package:exam_app/features/questions/api/data_sources/remote/check_answers_remote_data_source_impl.dart';
import 'package:exam_app/features/questions/data/mappers/check_answers_response_mapper.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:exam_app/features/questions/data/repositories/answers_check_repository_impl.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'answers_check_repository_impl_test.mocks.dart';

@GenerateMocks([
  CheckAnswersRemoteDataSourceImpl,
  GetQuestionsLocalDataSourceImpl,
  CacheResultLocalDataSourceImpl,
])
void main() {
  late AnswersCheckRepositoryImpl repositoryImpl;
  late MockCheckAnswersRemoteDataSourceImpl mockRemoteDataSource;
  late MockGetQuestionsLocalDataSourceImpl mockGetQuesLocalDataSource;
  late MockCacheResultLocalDataSourceImpl mockCacheLocalDataSource;
  late CheckAnswersResponseModel testcheckAnswerModel;
  late AnswersRequestEntity testAnswerRequestEntity;
  late CachedExamResultEntity testcachedExamResultEntity;

  const tToken = 'valid_test_token';
  const tTokenErrorMessage = 'falied to get token locally';

  DioException createDioException({required DioExceptionType type}) {
    return DioException(
      requestOptions: RequestOptions(path: '/api/questions'),
      type: type,
    );
  }

  setUpAll(() {
    mockRemoteDataSource = MockCheckAnswersRemoteDataSourceImpl();
    mockGetQuesLocalDataSource = MockGetQuestionsLocalDataSourceImpl();
    mockCacheLocalDataSource = MockCacheResultLocalDataSourceImpl();

    testcheckAnswerModel = CheckAnswersResponseModel(
      correct: 2,
      wrong: 2,
      message: 'message',
      total: '20%',
      wrongQuestions: [
        WrongQuestionModel(
          qid: 'id',
          question: 'wrong question',
          inCorrectAnswer: 'A4',
          correctAnswer: 'A2',
          answers: Answers(),
        ),
      ],
      correctQuestions: [
        CorrectQuestionModel(
          qid: 'id',
          question: 'correct question',
          correctAnswer: 'A2',
          answers: Answers(),
        ),
      ],
    );

    testAnswerRequestEntity = AnswersRequestEntity(
      answers: [AnswerCheckEntity(questionId: 'id', correct: 'A2')],
      time: 20,
    );

    testcachedExamResultEntity = CachedExamResultEntity(
      answers: testcheckAnswerModel.toEntity(),
      questions:[ ],
      exam: ExamEntity(duration: 20, title: 'exam', numberOfQuestions: 20),
    );

    provideDummy<BaseResponse<CheckAnswersResponseModel>>(
      SuccessResponse<CheckAnswersResponseModel>(data: testcheckAnswerModel),
    );

    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: ''));

    provideDummy<BaseResponse<void>>(SuccessResponse<void>(data: null));

    repositoryImpl = AnswersCheckRepositoryImpl(
      mockRemoteDataSource,
      mockGetQuesLocalDataSource,
      mockCacheLocalDataSource,
    );
  });

  setUp(() {
    reset(mockCacheLocalDataSource);
    reset(mockGetQuesLocalDataSource);
    reset(mockRemoteDataSource);
  });

  group('answers check test cases', () {
    group('success case', () {
      test(
        'should return SuccessResponse when token and remote call succeed',
        () async {
          when(
            mockGetQuesLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(
            mockRemoteDataSource.checkAnswers(
              answers: anyNamed('answers'),
              token: tToken,
            ),
          ).thenAnswer(
            (_) async => SuccessResponse<CheckAnswersResponseModel>(
              data: testcheckAnswerModel,
            ),
          );

          final result = await repositoryImpl.checkAnswers(
            answers: testAnswerRequestEntity,
          );

          expect(result, isA<SuccessResponse<CheckAnswersResponseEntity>>());

          verify(mockGetQuesLocalDataSource.getToken()).called(1);
          verify(
            mockRemoteDataSource.checkAnswers(
              answers: anyNamed('answers'),
              token: tToken,
            ),
          ).called(1);

          verifyNoMoreInteractions(mockCacheLocalDataSource);
        },
      );
    });

    group('error case', () {
      test('should return ErrorResponse when token retrieval fails', () async {
        when(mockGetQuesLocalDataSource.getToken()).thenReturn(
          ErrorResponse<String>(
            error: LocalException(message: tTokenErrorMessage),
          ),
        );

        final result = await repositoryImpl.checkAnswers(
          answers: testAnswerRequestEntity,
        );

        expect(result, isA<ErrorResponse<CheckAnswersResponseEntity>>());

        verify(mockGetQuesLocalDataSource.getToken()).called(1);
        verifyNever(
          mockRemoteDataSource.checkAnswers(
            answers: anyNamed('answers'),
            token: tToken,
          ),
        );
      });

      test(
        'should return ErrorResponse when remote data source returns error',
        () async {
          when(
            mockGetQuesLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(
            mockRemoteDataSource.checkAnswers(
              answers: anyNamed('answers'),
              token: tToken,
            ),
          ).thenAnswer(
            (_) async => ErrorResponse<CheckAnswersResponseModel>(
              error: RemoteException.fromDioError(
                createDioException(type: DioExceptionType.receiveTimeout),
              ),
            ),
          );

          final result = await repositoryImpl.checkAnswers(
            answers: testAnswerRequestEntity,
          );

          expect(result, isA<ErrorResponse<CheckAnswersResponseEntity>>());

          final errorResult =
              result as ErrorResponse<CheckAnswersResponseEntity>;
          expect(errorResult.error.message, 'Receive timeout');

          verify(mockGetQuesLocalDataSource.getToken()).called(1);
          verify(
            mockRemoteDataSource.checkAnswers(
              answers: anyNamed('answers'),
              token: tToken,
            ),
          ).called(1);
        },
      );
    });
  });

  group('cacheAnswers test cases', () {
    group('success case', () {
      test('should cache answers successfully', () async {
        when(
          mockCacheLocalDataSource.cacheResult(any),
        ).thenAnswer((_) async => SuccessResponse<void>(data: null));

        final result = await repositoryImpl.cacheAnswers(
          testcachedExamResultEntity,
        );

        expect(result, isA<SuccessResponse<void>>());

        verify(mockCacheLocalDataSource.cacheResult(any)).called(1);
      });
    });

    group('error cases', () {
      test('should return ErrorResponse when cache fails', () async {
        when(mockCacheLocalDataSource.cacheResult(any)).thenAnswer(
          (_) async => ErrorResponse<void>(
            error: LocalException(message: 'failed to get results'),
          ),
        );

        final result = await repositoryImpl.cacheAnswers(
          testcachedExamResultEntity,
        );

        expect(result, isA<ErrorResponse<void>>());
        final errorResult = result as ErrorResponse<void>;
        expect(errorResult.error.message, 'failed to get results');
      });
    });
  });
}
