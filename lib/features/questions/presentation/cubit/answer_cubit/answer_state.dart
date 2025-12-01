import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';

class AnswerState {
  final List<AnswerCheckEntity> answers;
  final BaseState<CheckAnswersResponseEntity>? scoreState;
  final int currentQuestionIndex ;

  AnswerState({List<AnswerCheckEntity>? answers, this.scoreState,this.currentQuestionIndex=0})
    : answers = answers ?? [];

  AnswerState copyWith({
    List<AnswerCheckEntity>? answers,
    BaseState<CheckAnswersResponseEntity>? scoreState,
    int? currentQuestionIndex,
  }) {
    return AnswerState(
      answers: answers ?? this.answers,
      scoreState: scoreState ?? this.scoreState,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}
