import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';

class GetQuestionsStates {
  final BaseState<List<QuestionEntity>>? questionsState;
  final ExamEntity? examDetails;
  GetQuestionsStates({this.questionsState, this.examDetails});

  GetQuestionsStates copyWith({
    BaseState<List<QuestionEntity>>? questionsState,
    ExamEntity? examDetails,
  }) {
    return GetQuestionsStates(
      questionsState: questionsState ?? this.questionsState,
      examDetails: examDetails ?? this.examDetails,
    );
  }
}
