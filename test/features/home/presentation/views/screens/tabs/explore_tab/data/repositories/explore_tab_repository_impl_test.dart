import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/api/datasources/explore_tab_local_data_source_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/api/datasources/explore_tab_remote_data_source_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/api/datasources/get_all_exams_remote_data_source_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/exam_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/subject_dto.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/repositories/explore_tab_repository_impl.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'explore_tab_repository_impl_test.mocks.dart';
@GenerateMocks([ExploreTabRemoteDataSourceImpl,ExploreTabLocalDataSourceImpl,GetAllExamsRemoteDataSourceImpl])
void main() {
  late ExploreTabRepositoryImpl exploreTabRepositoryImpl;
  late MockExploreTabLocalDataSourceImpl mockExploreTabLocalDataSourceImpl;
  late MockExploreTabRemoteDataSourceImpl mockExploreTabRemoteDataSourceImpl;
  late MockGetAllExamsRemoteDataSourceImpl mockGetAllExamsRemoteDataSourceImpl;
  setUpAll(() {
    provideDummy<BaseResponse<String>>(
      SuccessResponse<String>(data: "")
    );
    provideDummy<BaseResponse<List<SubjectDTO>>>(
      SuccessResponse<List<SubjectDTO>>(data: [])
    );
    provideDummy<BaseResponse<List<ExamDTO>>>(
      SuccessResponse<List<ExamDTO>>(data: [])
    );
    mockGetAllExamsRemoteDataSourceImpl=MockGetAllExamsRemoteDataSourceImpl();
    mockExploreTabRemoteDataSourceImpl=MockExploreTabRemoteDataSourceImpl();
    mockExploreTabLocalDataSourceImpl=MockExploreTabLocalDataSourceImpl();
    exploreTabRepositoryImpl=ExploreTabRepositoryImpl(mockExploreTabRemoteDataSourceImpl, mockExploreTabLocalDataSourceImpl, mockGetAllExamsRemoteDataSourceImpl);
  },);

  group("Test cases of getAllSubjects Function", () {
    test("Success case with subjects dto non empty list",()async{
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );  
      List<SubjectDTO> dummySubjectsDTO=[
        SubjectDTO(id: "1",name: "Subject 1",icon: "icon url 1"),
        SubjectDTO(id: "2",name: "Subject 2",icon: "icon url 2"),
      ];
      when(mockExploreTabRemoteDataSourceImpl.getAllSubjects(token)).thenAnswer(
        (_) async => SuccessResponse<List<SubjectDTO>>(data: dummySubjectsDTO),
      );
      final result=await exploreTabRepositoryImpl.getAllSubjects();
      expect(result, isA<SuccessResponse<List<SubjectEntity>>>());
      expect((result as SuccessResponse<List<SubjectEntity>>).data.length, dummySubjectsDTO.length);
      expect(result.data[0].id, dummySubjectsDTO[0].id);
      expect(result.data[0].name, dummySubjectsDTO[0].name);
      expect(result.data[0].icon, dummySubjectsDTO[0].icon);
      expect(result.data[1].id, dummySubjectsDTO[1].id);
      expect(result.data[1].name, dummySubjectsDTO[1].name);
      expect(result.data[1].icon, dummySubjectsDTO[1].icon);
      verify(mockExploreTabRemoteDataSourceImpl.getAllSubjects(token)).called(1);
    });

    test("Success case with subjects dto empty list", () async{
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );  
      when(mockExploreTabRemoteDataSourceImpl.getAllSubjects(token)).thenAnswer(
        (_) async => SuccessResponse<List<SubjectDTO>>(data: []),
      );
      final result=await exploreTabRepositoryImpl.getAllSubjects();
      expect(result, isA<SuccessResponse<List<SubjectEntity>>>());
      expect((result as SuccessResponse<List<SubjectEntity>>).data.length, isZero);
      verify(mockExploreTabRemoteDataSourceImpl.getAllSubjects(token)).called(1);
    });
    test("Error case with AppException error remote", () async{
      AppException exception=RemoteException(message: "Remote dio error exception");
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      when(mockExploreTabRemoteDataSourceImpl.getAllSubjects(token)).thenAnswer(
        (_) async => ErrorResponse<List<SubjectDTO>>(error: exception),
      );
      final result=await exploreTabRepositoryImpl.getAllSubjects();
      expect(result, isA<ErrorResponse<List<SubjectEntity>>>());
      expect((result as ErrorResponse<List<SubjectEntity>>).error.message, equals(exception.message)); 
    });

    test("Error case when token retrieval fails", () async{
      AppException tokenException = LocalException(message: "Token not found");
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_) async => ErrorResponse<String>(error: tokenException),
      );
      final result = await exploreTabRepositoryImpl.getAllSubjects();
      expect(result, isA<ErrorResponse<List<SubjectEntity>>>());
      expect((result as ErrorResponse<List<SubjectEntity>>).error.message, equals(tokenException.message));
    });
  },);
  group("Test cases of getAllExams Function", () {
    test("Success case with exams dto non empty list",()async{
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      List<ExamDTO> dummyExamsDTO=[
        ExamDTO(id: "id 1",title: "Exam 1",subject: "Subject 1"),
        ExamDTO(id: "id 2",title: "Exam 1",subject: "Subject 2"),
      ];
      when(mockGetAllExamsRemoteDataSourceImpl.getAllExams(token)).thenAnswer(
        (_) async=> SuccessResponse<List<ExamDTO>>(data: dummyExamsDTO),
      );
      final result=await exploreTabRepositoryImpl.getAllExams();
      expect(result, isA<SuccessResponse<List<ExamEntity>>>());
      expect((result as SuccessResponse<List<ExamEntity>>).data.length, dummyExamsDTO.length);
      expect(result.data[0].id, dummyExamsDTO[0].id);
      expect(result.data[0].title, dummyExamsDTO[0].title);
      expect(result.data[0].subject, dummyExamsDTO[0].subject);
      expect(result.data[1].id, dummyExamsDTO[1].id);
      expect(result.data[1].title, dummyExamsDTO[1].title);
      expect(result.data[1].subject, dummyExamsDTO[1].subject);
      verify(mockGetAllExamsRemoteDataSourceImpl.getAllExams(token)).called(1);  
    });

    test("Success case with empty exams dto list", () async{
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      when(mockGetAllExamsRemoteDataSourceImpl.getAllExams(token)).thenAnswer(
        (_) async=> SuccessResponse<List<ExamDTO>>(data: []),
      );
      final result=await exploreTabRepositoryImpl.getAllExams();
      expect(result, isA<SuccessResponse<List<ExamEntity>>>());
      expect((result as SuccessResponse<List<ExamEntity>>).data.length, isZero);
      verify(mockGetAllExamsRemoteDataSourceImpl.getAllExams(token)).called(1);
    });
    test("Error case with AppException error remote", () async{
      AppException exception=RemoteException(message: "Remote dio error exception");
      String token="dummy_token";
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_)async =>SuccessResponse<String>(data: token) ,
      );
      when(mockGetAllExamsRemoteDataSourceImpl.getAllExams(token)).thenAnswer(
        (_) async=>ErrorResponse<List<ExamDTO>>(error: exception) ,
      );
      final result=await exploreTabRepositoryImpl.getAllExams();
      expect(result,isA<ErrorResponse<List<ExamEntity>>>());
      expect((result as ErrorResponse<List<ExamEntity>>).error.message,equals(exception.message));
    });
    test("Error case when token retrieval fails", () async{
      AppException tokenException = LocalException(message: "Token not found");
      when(mockExploreTabLocalDataSourceImpl.getToken()).thenAnswer(
        (_) async => ErrorResponse<String>(error: tokenException),
      );
      final result=await exploreTabRepositoryImpl.getAllExams();
      expect(result,isA<ErrorResponse<List<ExamEntity>>>());
      expect((result as ErrorResponse<List<ExamEntity>>).error.message,equals(tokenException.message));
    });
  },);
}