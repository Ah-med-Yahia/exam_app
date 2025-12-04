import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:exam_app/features/start_exam/domain/use_cases/start_exam_use_case.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_events.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class StartExamCubit extends Cubit<StartExamStates>{
  final StartExamUseCase _startExamUseCase;
  StartExamCubit(this._startExamUseCase):super(StartExamStates());
  void doIntent(StartExamEvents event,String id){
    switch(event){

      case GetExamEvent():
        _getExamById(id);
    }
  }
  Future<void> _getExamById(String id) async{
    if(isClosed) return;
    emit(state.copyWith(
      getExamState: BaseState<ExamEntity>(
        isLoading: true
      )
    ));
    final BaseResponse<ExamEntity> response=await _startExamUseCase(id);
    if(isClosed) return;
    switch(response){
      
      case SuccessResponse<ExamEntity>():
        emit(state.copyWith(
          getExamState: BaseState<ExamEntity>(
            isLoading: false,
            data: response.data
          )
        ));
      case ErrorResponse<ExamEntity>():
        emit(state.copyWith(
          getExamState: BaseState<ExamEntity>(
            isLoading: false,
            errorMessage: response.error.message
          )
        ));
    }
  }
}