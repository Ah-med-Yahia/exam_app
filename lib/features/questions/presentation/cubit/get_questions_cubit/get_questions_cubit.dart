import 'package:bloc/bloc.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';
import 'package:exam_app/features/questions/domain/usecases/get_questions_use_case.dart';
import 'package:exam_app/features/questions/presentation/cubit/get_questions_cubit/get_guestions_events.dart';
import 'package:exam_app/features/questions/presentation/cubit/get_questions_cubit/get_questions_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetQuestionsCubit extends Cubit<GetQuestionsStates> {
  GetQuestionsCubit(this.getQuestionsUseCase) : super(GetQuestionsStates());

  final GetQuestionsUseCase getQuestionsUseCase;

  void doIntent(GetQuestionsEvents event) {
    switch (event) {
      case QuestionsEvent(:final examId):
        _getQuestions(examId);
    }
  }

  void _getQuestions(String examId) async {
    emit(
      state.copyWith(
        questionsState: BaseState<List<QuestionEntity>>(isLoading: true),
      ),
    );

    final result = await getQuestionsUseCase(examId: examId);
    switch (result) {
      case SuccessResponse<GetQuestionsResponseEntity>():
        emit(
          state.copyWith(
            questionsState: BaseState<List<QuestionEntity>>(
              data: result.data.questions,
            ),
            examDetails: result.data.exam,
          ),
        );
      case ErrorResponse<GetQuestionsResponseEntity>():
        emit(
          state.copyWith(
            questionsState: BaseState<List<QuestionEntity>>(
              errorMessage: result.error.message,
            ),
          ),
        );
    }
  }
}
