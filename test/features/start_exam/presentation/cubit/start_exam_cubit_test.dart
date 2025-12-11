import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:exam_app/features/start_exam/domain/use_cases/start_exam_use_case.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_cubit.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_events.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'start_exam_cubit_test.mocks.dart';
@GenerateMocks([StartExamUseCase])
void main() {
  late StartExamCubit startExamCubit;
  late MockStartExamUseCase mockStartExamUseCase;
  setUpAll(() {
    provideDummy<BaseResponse<ExamEntity>>(SuccessResponse<ExamEntity>(data: ExamEntity()));
    mockStartExamUseCase=MockStartExamUseCase();
    startExamCubit=StartExamCubit(mockStartExamUseCase);
  });
  tearDownAll(() {
    startExamCubit.close();
  });
  group("GetExamEvent", () {
    String id="dummy_id";
    ExamEntity examEntity=ExamEntity(id: "id",title: "title",subject: "Subject");
    test("Emitting loading then success state when use case returns success", ()async {
      when(mockStartExamUseCase(id)).thenAnswer(
        (_)async =>SuccessResponse<ExamEntity>(data: examEntity) ,
      );
      expectLater(
        startExamCubit.stream, 
        emitsInOrder([
          predicate<StartExamStates>(
            (state) =>state.getExamState?.isLoading==true ,
          ),
          predicate<StartExamStates>(
            (state) =>state.getExamState?.isLoading==false && state.getExamState?.data==examEntity ,
          )
        ])
      );
      startExamCubit.doIntent(GetExamEvent(), id);
    });
    test("Emitting loading then error state when use case returns error", () async{
      String errorMessage="Network Error";
      when(mockStartExamUseCase(id)).thenAnswer(
        (_)async =>ErrorResponse<ExamEntity>(error: RemoteException(message: errorMessage)) ,
      );
      expectLater(
        startExamCubit.stream, 
        emitsInOrder([
          predicate<StartExamStates>(
            (state) =>state.getExamState?.isLoading==true ,
          ),
          predicate<StartExamStates>(
            (state) =>state.getExamState?.isLoading==false && state.getExamState?.errorMessage==errorMessage
          )
        ])
      );
      startExamCubit.doIntent(GetExamEvent(), id);
    });
    test("shouldn't emit states after closing cubit", () async{
      startExamCubit.close();
      startExamCubit.doIntent(GetExamEvent(), id);
      expect(startExamCubit.isClosed, true);
    });
  });
}