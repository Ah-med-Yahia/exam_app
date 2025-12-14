import 'package:dio/dio.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/data_sources/local/get_questions_local_data_source_impl.dart';
import 'package:exam_app/features/questions/api/data_sources/remote/get_questions_remote_data_sources_impl.dart';
import 'package:exam_app/features/questions/data/models/exam_model/exam_model.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:exam_app/features/questions/data/models/question_model/question_model.dart';
import 'package:exam_app/features/questions/data/repositories/get_questions_response_repository_impl.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_questions_response_repository_impl_test.mocks.dart';

@GenerateMocks([
  GetQuestionsRemoteDataSourcesImpl,
  GetQuestionsLocalDataSourceImpl,
])
void main() {
  late GetQuestionsResponseRepositoryImpl repositoryImpl;
  late MockGetQuestionsRemoteDataSourcesImpl mockRemoteDataSource;
  late MockGetQuestionsLocalDataSourceImpl mockLocalDataSource;
  late GetQuestionsResponseModel testResponseModel;
  late ExamModel testExamModel;
  late QuestionModel testQuestionModel;

  const tExamId = 'exam_123';
  const tToken = 'valid_test_token';
  const tTokenErrorMessage = 'falied to get token locally';
  final tCreatedAt = DateTime(2025, 1, 1, 10, 0);

  ExamModel createTestExamModel({
    String id = 'exam_123',
    String title = 'Mathematics Final Exam',
    int duration = 120,
    String subject = 'Mathematics',
    int numberOfQuestions = 50,
    bool active = true,
  }) {
    return ExamModel(
      id: id,
      title: title,
      duration: duration,
      subject: subject,
      numberOfQuestions: numberOfQuestions,
      active: active,
      createdAt: tCreatedAt,
    );
  }

  QuestionModel createTestQuestionModel({
    String id = 'question_1',
    String question = 'What is 2 + 2?',
    String type = 'multiple_choice',
    KeyModel correct = KeyModel.a1,
    String subject = 'Mathematics',
  }) {
    return QuestionModel(
      id: id,
      question: question,
      type: type,
      correct: correct,
      subject: subject,
      answers: [
        AnswerModel(answer: '3', key: KeyModel.a1),
        AnswerModel(answer: '4', key: KeyModel.a2),
        AnswerModel(answer: '5', key: KeyModel.a3),
      ],
      exam: testExamModel,
      createdAt: tCreatedAt,
    );
  }

  DioException createDioException({required DioExceptionType type}) {
    return DioException(
      requestOptions: RequestOptions(path: '/api/questions'),
      type: type,
    );
  }

  setUpAll(() {
    mockRemoteDataSource = MockGetQuestionsRemoteDataSourcesImpl();
    mockLocalDataSource = MockGetQuestionsLocalDataSourceImpl();

    provideDummy<BaseResponse<GetQuestionsResponseModel>>(
      SuccessResponse<GetQuestionsResponseModel>(
        data: GetQuestionsResponseModel(message: 'Success', questions: []),
      ),
    );

    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: ''));

    repositoryImpl = GetQuestionsResponseRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  setUp(() {
    reset(mockRemoteDataSource);
    reset(mockLocalDataSource);

    testExamModel = createTestExamModel();
    testQuestionModel = createTestQuestionModel();
    testResponseModel = GetQuestionsResponseModel(
      message: 'Questions retrieved successfully',
      questions: [testQuestionModel],
    );
  });

  group('GetQuestions Repository Tests', () {
    group('Success Cases', () {
      test(
        'should return SuccessResponse with correct data when token retrieval and remote call succeed',
        () async {
          when(
            mockLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(mockRemoteDataSource.getQuestions(tExamId, tToken)).thenAnswer(
            (_) async => SuccessResponse<GetQuestionsResponseModel>(
              data: testResponseModel,
            ),
          );

          final result = await repositoryImpl.getQuestions(examId: tExamId);

          expect(result, isA<SuccessResponse<GetQuestionsResponseEntity>>());

          final successResult =
              result as SuccessResponse<GetQuestionsResponseEntity>;
          expect(successResult.data.questions.length, 1);
          expect(successResult.data.questions.first.id, 'question_1');
          expect(successResult.data.questions.first.question, 'What is 2 + 2?');

          verify(mockLocalDataSource.getToken()).called(1);
          verify(mockRemoteDataSource.getQuestions(tExamId, tToken)).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );

      test(
        'should return SuccessResponse with empty questions list when no questions available',
        () async {
          final emptyResponseModel = GetQuestionsResponseModel(
            message: 'No questions found',
            questions: [],
          );

          when(
            mockLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(mockRemoteDataSource.getQuestions(tExamId, tToken)).thenAnswer(
            (_) async => SuccessResponse<GetQuestionsResponseModel>(
              data: emptyResponseModel,
            ),
          );

          final result = await repositoryImpl.getQuestions(examId: tExamId);

          expect(result, isA<SuccessResponse<GetQuestionsResponseEntity>>());

          final successResult =
              result as SuccessResponse<GetQuestionsResponseEntity>;
          expect(successResult.data.questions, isEmpty);

          verify(mockLocalDataSource.getToken()).called(1);
          verify(mockRemoteDataSource.getQuestions(tExamId, tToken)).called(1);
        },
      );

      test(
        'should return SuccessResponse with multiple questions when available',
        () async {
          final multipleQuestionsModel = GetQuestionsResponseModel(
            message: 'Multiple questions retrieved',
            questions: [
              createTestQuestionModel(id: 'question_1'),
              createTestQuestionModel(
                id: 'question_2',
                question: 'What is 3 + 3?',
              ),
              createTestQuestionModel(
                id: 'question_3',
                question: 'What is 4 + 4?',
              ),
            ],
          );

          when(
            mockLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(mockRemoteDataSource.getQuestions(tExamId, tToken)).thenAnswer(
            (_) async => SuccessResponse<GetQuestionsResponseModel>(
              data: multipleQuestionsModel,
            ),
          );

          final result = await repositoryImpl.getQuestions(examId: tExamId);

          expect(result, isA<SuccessResponse<GetQuestionsResponseEntity>>());

          final successResult =
              result as SuccessResponse<GetQuestionsResponseEntity>;
          expect(successResult.data.questions.length, 3);
          expect(successResult.data.questions[0].id, 'question_1');
          expect(successResult.data.questions[1].id, 'question_2');
          expect(successResult.data.questions[2].id, 'question_3');

          verify(mockLocalDataSource.getToken()).called(1);
          verify(mockRemoteDataSource.getQuestions(tExamId, tToken)).called(1);
        },
      );
    });

    group('Failure Cases', () {
      test('should return ErrorResponse when token retrieval fails', () async {
        when(mockLocalDataSource.getToken()).thenReturn(
          ErrorResponse<String>(
            error: LocalException(message: 'falied to get token locally'),
          ),
        );

        final result = await repositoryImpl.getQuestions(examId: tExamId);

        expect(result, isA<ErrorResponse<GetQuestionsResponseEntity>>());

        final errorResult = result as ErrorResponse<GetQuestionsResponseEntity>;
        expect(errorResult.error.message, tTokenErrorMessage);

        verify(mockLocalDataSource.getToken()).called(1);
        verifyNever(mockRemoteDataSource.getQuestions(any, any));
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test(
        'should return ErrorResponse when remote data source returns error',
        () async {
          when(
            mockLocalDataSource.getToken(),
          ).thenReturn(SuccessResponse<String>(data: tToken));

          when(mockRemoteDataSource.getQuestions(tExamId, tToken)).thenAnswer(
            (_) async => ErrorResponse<GetQuestionsResponseModel>(
              error: RemoteException.fromDioError(
                createDioException(type: DioExceptionType.receiveTimeout),
              ),
            ),
          );

          final result = await repositoryImpl.getQuestions(examId: tExamId);

          expect(result, isA<ErrorResponse<GetQuestionsResponseEntity>>());

          final errorResult =
              result as ErrorResponse<GetQuestionsResponseEntity>;
          expect(errorResult.error.message, 'Receive timeout');

          verify(mockLocalDataSource.getToken()).called(1);
          verify(mockRemoteDataSource.getQuestions(tExamId, tToken)).called(1);
        },
      );
    });
  });
}
