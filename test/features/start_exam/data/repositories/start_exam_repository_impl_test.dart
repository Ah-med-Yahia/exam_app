import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/start_exam/api/datasources/start_exam_local_data_source_impl.dart';
import 'package:exam_app/features/start_exam/api/datasources/start_exam_remote_data_source_impl.dart';
import 'package:exam_app/features/start_exam/data/models/exam_dto.dart';
import 'package:exam_app/features/start_exam/data/repositories/start_exam_repository_impl.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'start_exam_repository_impl_test.mocks.dart';

@GenerateMocks([StartExamLocalDataSourceImpl,StartExamRemoteDataSourceImpl])
void main() {
  late StartExamRepositoryImpl startExamRepositoryImpl;
  late MockStartExamLocalDataSourceImpl mockStartExamLocalDataSourceImpl;
  late MockStartExamRemoteDataSourceImpl mockStartExamRemoteDataSourceImpl;
  setUpAll(() {
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: ""));
    provideDummy<BaseResponse<ExamDTO>>(SuccessResponse<ExamDTO>(data: ExamDTO()));
    mockStartExamLocalDataSourceImpl=MockStartExamLocalDataSourceImpl();
    mockStartExamRemoteDataSourceImpl=MockStartExamRemoteDataSourceImpl();
    startExamRepositoryImpl=StartExamRepositoryImpl(mockStartExamLocalDataSourceImpl, mockStartExamRemoteDataSourceImpl);
  });
  group("Test cases of getExamById function", () {
    test("success case with a filled exam dto",()async{
      String id="dummy_id";
      String token="dummy_token";
      when(mockStartExamLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      ExamDTO examDTO=ExamDTO(id:"id",title: "title",subject: "subject",duration: 20);
      when(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).thenAnswer(
        (_) async=>SuccessResponse<ExamDTO>(data: examDTO) ,
      );
      final result=await startExamRepositoryImpl.getExamById(id);
      expect(result, isA<SuccessResponse<ExamEntity>>());
      expect((result as SuccessResponse<ExamEntity>).data.id, examDTO.id);
      expect(result.data.title, examDTO.title);
      expect(result.data.subject, examDTO.subject);
      expect(result.data.duration, examDTO.duration);
      verify(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).called(1);
      verify(mockStartExamLocalDataSourceImpl.getToken()).called(1);
    });
    test("success case with an exam dto with empty fields(details)",()async{
      String id="dummy_id";
      String token="dummy_token";
      when(mockStartExamLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      ExamDTO examDTO=ExamDTO(id:"id");
      when(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).thenAnswer(
        (_) async=>SuccessResponse<ExamDTO>(data: examDTO) ,
      );
      final result=await startExamRepositoryImpl.getExamById(id);
      expect(result, isA<SuccessResponse<ExamEntity>>());
      expect((result as SuccessResponse<ExamEntity>).data.id, examDTO.id);
      expect(result.data.title, isNull);
      expect(result.data.subject, isNull);
      expect(result.data.duration, isNull);
      verify(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).called(1);
      verify(mockStartExamLocalDataSourceImpl.getToken()).called(1);
    });
    test("Error case with remote AppException error",() async{
      String id="dummy_id";
      String token="dummy_token";
      when(mockStartExamLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      AppException exception=RemoteException(message: "Network error");
      when(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).thenAnswer(
        (_)async =>ErrorResponse(error: exception) ,
      );
      final result=await startExamRepositoryImpl.getExamById(id);
      expect(result, isA<ErrorResponse<ExamEntity>>());
      expect((result as ErrorResponse<ExamEntity>).error.message, exception.message);
      verify(mockStartExamRemoteDataSourceImpl.getExamById(id, token)).called(1);
      verify(mockStartExamLocalDataSourceImpl.getToken()).called(1);
    });
    test("Error case with failing to retrieve token", () async{
      String id="dummy_id";
      AppException tokenException=LocalException(message: "Token not found");
      when(mockStartExamLocalDataSourceImpl.getToken()).thenAnswer(
        (_) async=>ErrorResponse<String>(error: tokenException) ,
      );
      final result=await startExamRepositoryImpl.getExamById(id);
      expect(result, isA<ErrorResponse<ExamEntity>>());
      expect((result as ErrorResponse<ExamEntity>).error.message, equals(tokenException.message));
      verify(mockStartExamLocalDataSourceImpl.getToken()).called(1);
    });
  });
}