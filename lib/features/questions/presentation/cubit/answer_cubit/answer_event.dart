import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity/question_entity.dart';

sealed class AnswerEvent {}

class SelectAnswerEvent extends AnswerEvent {
  final String questionId;
  final KeyEntity? selectedAnswer;

  SelectAnswerEvent({required this.questionId, required this.selectedAnswer});
}

class InitializeAnswersEvent extends AnswerEvent {
  final List<QuestionEntity> questions;

  InitializeAnswersEvent({required this.questions});
}

class CalculateScoreEvent extends AnswerEvent {
  final List<AnswerCheckEntity> answers;
  final int time;
  CalculateScoreEvent({required this.answers, required this.time});
}

class NextQuestionEvent extends AnswerEvent {
  final int currentQuestionIndex;
  NextQuestionEvent({required this.currentQuestionIndex});
}

class CacheAnswersEvent extends AnswerEvent {
  final ExamEntity exam;
  final List<QuestionEntity> questions;
  final CheckAnswersResponseEntity answers;

  CacheAnswersEvent({required this.exam, required this.answers,required this.questions});
}
