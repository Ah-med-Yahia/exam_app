import "package:exam_app/config/base_response/base_response.dart";
import "package:exam_app/config/base_state/base_state.dart";
import "package:exam_app/core/errors/exception.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/use_cases/get_all_exams_use_case.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/use_cases/get_all_subjects_use_case.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_events.dart";
import "package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_states.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:test/test.dart";

import "explore_tab_cubit_test.mocks.dart";
@GenerateMocks([GetAllSubjectsUseCase,GetAllExamsUseCase])
void main() {
  late ExploreTabCubit exploreTabCubit;
  late MockGetAllSubjectsUseCase mockGetAllSubjectsUseCase;
  late MockGetAllExamsUseCase mockGetAllExamsUseCase;
  setUpAll(() {
    provideDummy<BaseResponse<List<SubjectEntity>>>(
      SuccessResponse<List<SubjectEntity>>(data: [])
    );
    provideDummy<BaseResponse<List<ExamEntity>>>(
      SuccessResponse<List<ExamEntity>>(data: [])
    );
    mockGetAllSubjectsUseCase=MockGetAllSubjectsUseCase();
    mockGetAllExamsUseCase=MockGetAllExamsUseCase();
    exploreTabCubit=ExploreTabCubit(mockGetAllSubjectsUseCase, mockGetAllExamsUseCase);
  });
  tearDownAll(() {
    exploreTabCubit.close();
  });
  group("GetAllSubjectsEvent", () {
    List<SubjectEntity> dummySujectsEntities=[
      SubjectEntity(id: "1", name: "Math", icon: "math_icon"),
      SubjectEntity(id: "2", name: "Science", icon: "science_icon")
    ];
    test("Emmiting loading then success state when use case returns success", () async{
      when(mockGetAllSubjectsUseCase()).thenAnswer(
        (_)async =>SuccessResponse<List<SubjectEntity>>(data: dummySujectsEntities) ,
      );
      expectLater(
        exploreTabCubit.stream, 
        emitsInOrder([
          predicate<ExploreTabStates>(
            (state) => state.gettingAllSubjects?.isLoading==true,
          ),
          predicate<ExploreTabStates>(
            (state)=>state.gettingAllSubjects?.isLoading==false && state.gettingAllSubjects?.data==dummySujectsEntities
          )
        ])
      );
      exploreTabCubit.doIntent(GetAllSubjectsEvent());
    });
    test("Emitting loading then error state when use case returns error", () async{
      String errorMessage="Network Error";
      when(mockGetAllSubjectsUseCase()).thenAnswer(
        (_)async =>ErrorResponse<List<SubjectEntity>>(error: RemoteException(message: errorMessage)) ,
      );
      expectLater(
        exploreTabCubit.stream, 
        emitsInOrder([
          predicate<ExploreTabStates>(
            (state) =>state.gettingAllSubjects?.isLoading==true ,
          ),
          predicate<ExploreTabStates>(
            (state) =>state.gettingAllSubjects?.isLoading==false && state.gettingAllSubjects?.errorMessage==errorMessage ,
          )
        ])
      );
      exploreTabCubit.doIntent(GetAllSubjectsEvent());
    });
    test("shouldn't emit states when cubit is closed", () async{
      exploreTabCubit.close();
      exploreTabCubit.doIntent(GetAllSubjectsEvent());
      expect(exploreTabCubit.isClosed, true);
    },);
  });
  
  group("GetAllExamsEvent", () {
    List<ExamEntity> dummyExamsEntities=[
      ExamEntity(id: "1", title: "Math Exam", subject: "Subject 1"),
      ExamEntity(id: "2", title: "Science Exam", subject: "Subject 2")
    ];
    test("Emitting loading then success state", () async{
      when(mockGetAllExamsUseCase()).thenAnswer(
        (_) async=>SuccessResponse<List<ExamEntity>>(data: dummyExamsEntities) ,
      );
      expectLater(
        exploreTabCubit.stream, 
        emitsInOrder([
          predicate<ExploreTabStates>(
            (state) =>state.getAllExams?.isLoading==true ,
          ),
          predicate<ExploreTabStates>(
            (state) =>state.getAllExams?.isLoading==false && state.getAllExams?.data==dummyExamsEntities ,
          )
        ])
      );
      exploreTabCubit.doIntent(GetAllExamsEvent());
    });
    test("Emitting loading then error state", () async{
      String errorMessage="Network Error";
      when(mockGetAllExamsUseCase()).thenAnswer(
        (_)async =>ErrorResponse<List<ExamEntity>>(error: RemoteException(message: errorMessage)) ,
      );
      expectLater(
        exploreTabCubit.stream, 
        emitsInOrder([
          predicate<ExploreTabStates>(
            (state) =>state.getAllExams?.isLoading==true ,
          ),
          predicate<ExploreTabStates>(
            (state) =>state.getAllExams?.isLoading==false && state.getAllExams?.errorMessage==errorMessage,
          )
        ])
      );
      exploreTabCubit.doIntent(GetAllExamsEvent());
    });
  });
  group("SearchSubjectsEvent", () {
    List<SubjectEntity> dummyAllSubjectsEntities=[
      SubjectEntity(id: "1", name: "Mathematics", icon: "math"),
      SubjectEntity(id: "2", name: "Physics", icon: "physics"),
      SubjectEntity(id: "3", name: "Chemistry", icon: "chemistry")
    ];
    test("Filtering subjects based on a query", () async{
      final initialState = ExploreTabStates(
        gettingAllSubjects: BaseState<List<SubjectEntity>>(data: dummyAllSubjectsEntities),
      );
      exploreTabCubit.emit(initialState);
      expectLater(
        exploreTabCubit.stream, 
        emits(
          predicate<ExploreTabStates>(
            (state) =>state.searchQuery=="math" && state.filteredSubjects?.length==1 && state.filteredSubjects?.first.name=="Mathematics",
          )
        )
      );
      exploreTabCubit.doIntent(SearchSubjectsEvent("math", dummyAllSubjectsEntities));
    });
    test("Handling case insensitive search", () {
      final initialState = ExploreTabStates(
        gettingAllSubjects: BaseState<List<SubjectEntity>>(data: dummyAllSubjectsEntities),
      );
      exploreTabCubit.emit(initialState);
      expectLater(
        exploreTabCubit.stream, 
        emits(
          predicate<ExploreTabStates>(
            (state) => state.searchQuery=="PHYSICS" && state.filteredSubjects?.length==1 && state.filteredSubjects?.first.name=="Physics",
          )
        )
      );
      exploreTabCubit.doIntent(SearchSubjectsEvent("PHYSICS", dummyAllSubjectsEntities));
    });
    test("Returning all subjects on empty search query", () {
      final initialState = ExploreTabStates(
        gettingAllSubjects: BaseState<List<SubjectEntity>>(data: dummyAllSubjectsEntities),
      );
      exploreTabCubit.emit(initialState);
      expectLater(
        exploreTabCubit.stream, 
        emits(
          predicate<ExploreTabStates>(
            (state)=>state.searchQuery=='' && state.filteredSubjects==dummyAllSubjectsEntities
          )
        )
      );
      exploreTabCubit.doIntent(SearchSubjectsEvent('', dummyAllSubjectsEntities));
    });
  });
}