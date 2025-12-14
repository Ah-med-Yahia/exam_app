import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/api_client/check_answers/check_answers_api_client.dart';
import 'package:exam_app/features/questions/api/data_sources/remote/check_answers_remote_data_source_impl.dart';
import 'package:exam_app/features/questions/data/models/answers_request_model/answers_request_model.dart';
import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'check_answers_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckAnswersApiClient])
void main() {
  late CheckAnswersRemoteDataSourceImpl dataSource;
  late MockCheckAnswersApiClient mockApiClient;

  const tToken = 'token123';

  final tAnswersRequest = AnswersRequestModel(answers: [], time: 20);

  setUpAll(() {
    mockApiClient = MockCheckAnswersApiClient();
    dataSource = CheckAnswersRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('CheckAnswersRemoteDataSourceImpl', () {
    test('should return SuccessResponse when api call succeeds', () async {
      
      final responseModel = CheckAnswersResponseModel(
        correct: 2,
        wrong: 1,
        total: '75%',
        message: 'success',
        correctQuestions: [],
        wrongQuestions: [],
      );

      when(
        mockApiClient.checkAnswers(tAnswersRequest, tToken),
      ).thenAnswer((_) async => responseModel);

      
      final result = await dataSource.checkAnswers(
        answers: tAnswersRequest,
        token: tToken,
      );

      
      expect(result, isA<SuccessResponse<CheckAnswersResponseModel>>());
      expect((result as SuccessResponse).data, responseModel);

      verify(mockApiClient.checkAnswers(tAnswersRequest, tToken)).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });
        test('should return ErrorResponse when api throws exception', () async {
      
      when(
        mockApiClient.checkAnswers(tAnswersRequest, tToken),
      ).thenThrow(Exception('Dio error'));

      
      final result = await dataSource.checkAnswers(
        answers: tAnswersRequest,
        token: tToken,
      );

      
      expect(result, isA<ErrorResponse<CheckAnswersResponseModel>>());
      expect(
        (result as ErrorResponse).error,
        isA<RemoteException>(),
      );

      verify(
        mockApiClient.checkAnswers(tAnswersRequest, tToken),
      ).called(1);
    });
  });
}
