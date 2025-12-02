import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';
import 'package:exam_app/features/questions/domain/usecases/answers_check_use_case.dart';
import 'package:exam_app/features/questions/domain/usecases/cache_answers_use_case.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_event.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AnswerCubit extends Cubit<AnswerState> {
  AnswerCubit(this.answersCheckUseCase,this.cacheAnswersUseCase) : super(AnswerState());

  final AnswersCheckUseCase answersCheckUseCase;
  final CacheAnswersUseCase cacheAnswersUseCase;

  void doIntent(AnswerEvent event) {
    switch (event) {
      case SelectAnswerEvent(:final questionId, :final selectedAnswer):
        selectAnswer(questionId, selectedAnswer);
      case CalculateScoreEvent(:final answers, :final time):
        calculateScore(answers, time);
      case NextQuestionEvent(:final currentQuestionIndex):
        nextQuestion(currentQuestionIndex);
      case InitializeAnswersEvent(:final questions):
        initialAnswers(questions);
      case CacheAnswersEvent(:final examId, :final answers):
        cacheAnswers(examId, answers);
    }
  }

  void nextQuestion(int currentQuestionIndex) {
    emit(state.copyWith(currentQuestionIndex: currentQuestionIndex));
  }

  void initialAnswers(List<QuestionEntity> questions) {
    emit(
      state.copyWith(
        answers: questions
            .map((e) => AnswerCheckEntity(questionId: e.id, correct: " "))
            .toList(),
      ),
    );
  }

  void selectAnswer(String questionId, KeyEntity? selectedAnswer) {
    final updatedList = List<AnswerCheckEntity>.from(state.answers);

    final index = updatedList.indexWhere((e) => e.questionId == questionId);

    final correctString = selectedAnswer?.name.toUpperCase();

    updatedList[index] = AnswerCheckEntity(
      questionId: questionId,
      correct: correctString ?? " ",
    );

    emit(state.copyWith(answers: updatedList));
  }

  void calculateScore(List<AnswerCheckEntity> answers, int time) async {
    emit(
      state.copyWith(
        scoreState: BaseState<CheckAnswersResponseEntity>(isLoading: true),
      ),
    );
    final response = await answersCheckUseCase(
      answers: AnswersRequestEntity(answers: answers, time: time),
    );
    switch (response) {
      case SuccessResponse<CheckAnswersResponseEntity>():
        emit(
          state.copyWith(
            scoreState: BaseState<CheckAnswersResponseEntity>(
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<CheckAnswersResponseEntity>():
        emit(
          state.copyWith(
            scoreState: BaseState<CheckAnswersResponseEntity>(
              errorMessage: response.error.message,
            ),
          ),
        );
    }
  }

  void cacheAnswers(String examId, CheckAnswersResponseEntity answers) async {
    await cacheAnswersUseCase(
      examId: examId,
      answers:answers,
    );
  }
}
