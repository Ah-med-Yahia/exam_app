import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/api_client/get_questions_api_client/questions_api_client.dart';
import 'package:exam_app/features/questions/api/data_sources/remote/get_questions_remote_data_sources_impl.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_questions_remote_data_sources_impl_test.mocks.dart';

@GenerateMocks([GetQuestionsApiClient])
void main() {
  late GetQuestionsRemoteDataSourcesImpl dataSource;
  late MockGetQuestionsApiClient mockApiClient;

  const tExamId = 'exam123';
  const tToken = 'token123';

  setUpAll(() {
    mockApiClient = MockGetQuestionsApiClient();
    dataSource = GetQuestionsRemoteDataSourcesImpl(apiClient: mockApiClient);
    provideDummy<BaseResponse<GetQuestionsResponseModel>>(
      SuccessResponse<GetQuestionsResponseModel>(
        data: GetQuestionsResponseModel(message: 'Success', questions: []),
      ),
    );
  });

  group('GetQuestionsRemoteDataSourcesImpl', () {
    test('should return SuccessResponse when api call succeeds', () async {
      final responseModel = GetQuestionsResponseModel(
        message: 'success',
        questions: [],
      );

      when(
        mockApiClient.getAllQuestions(tExamId, tToken),
      ).thenAnswer((_) async => responseModel);

      final result = await dataSource.getQuestions(tExamId, tToken);

      expect(result, isA<SuccessResponse<GetQuestionsResponseModel>>());
      expect((result as SuccessResponse).data, responseModel);

      verify(mockApiClient.getAllQuestions(tExamId, tToken)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test(
      'should return ErrorResponse when api call throws exception',
      () async {
        when(
          mockApiClient.getAllQuestions(tExamId, tToken),
        ).thenThrow(Exception('Dio error'));

        final result = await dataSource.getQuestions(tExamId, tToken);

        expect(result, isA<ErrorResponse<GetQuestionsResponseModel>>());
        expect((result as ErrorResponse).error, isA<RemoteException>());

        verify(mockApiClient.getAllQuestions(tExamId, tToken)).called(1);
      },
    );
  });
}
