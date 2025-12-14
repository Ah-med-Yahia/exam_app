import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/api/data_sources/local/get_questions_local_data_source_impl.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'cache_result_local_data_source_impl_test.mocks.dart';

@GenerateMocks([Box<String>])
void main() {
  late GetQuestionsLocalDataSourceImpl dataSource;
  late MockBox<String> mockTokenBox;

  const String tToken = 'token123';

  setUpAll(() {
    mockTokenBox = MockBox<String>();
    dataSource = GetQuestionsLocalDataSourceImpl(mockTokenBox);
  });

  group('GetQuestionsLocalDataSourceImpl', () {
    test('should return SuccessResponse when token exists', () {
      when(mockTokenBox.get(CacheConstants.tokenKey)).thenReturn(tToken);

      final result = dataSource.getToken();

      expect(result, isA<SuccessResponse<String>>());
      expect((result as SuccessResponse).data, 'token123');

      verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
      verifyNoMoreInteractions(mockTokenBox);
    });
    test('should return ErrorResponse when token is null', () {
      when(mockTokenBox.get(CacheConstants.tokenKey)).thenReturn(null);

      final result = dataSource.getToken();

      expect(result, isA<ErrorResponse<String>>());
      expect((result as ErrorResponse).error, isA<LocalException>());

      verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
    });

    test('should return ErrorResponse when box.get throws exception', () {
      when(
        mockTokenBox.get(CacheConstants.tokenKey),
      ).thenThrow(Exception('Hive error'));

      final result = dataSource.getToken();

      expect(result, isA<ErrorResponse<String>>());
      expect((result as ErrorResponse).error, isA<LocalException>());

      verify(mockTokenBox.get(CacheConstants.tokenKey)).called(1);
    });
  });
}
