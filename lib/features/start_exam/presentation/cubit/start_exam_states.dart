import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';

class StartExamStates {
  BaseState<ExamEntity>? getExamState;
  StartExamStates({this.getExamState});
  StartExamStates copyWith({BaseState<ExamEntity>? getExamState}){
    return StartExamStates(
      getExamState: getExamState ?? this.getExamState
    );
  }
}