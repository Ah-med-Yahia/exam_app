import 'package:bloc/bloc.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/usecases/get_local_results_history_use_case.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/cubit/result_event.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/cubit/result_tab_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResultTabCubit extends Cubit<ResultTabState> {
  final GetLocalResultsHistoryUseCase useCase;
  ResultTabCubit(this.useCase) : super(ResultTabState());

  void doIntent(ResultEvent event) {
    switch (event) {
      case GetResultsHistoryEvent():
        _getResultsHistory();
    }
  }

  void _getResultsHistory() {
    emit(
      state.copyWith(
        resultState: BaseState<List<CachedExamResultEntity>>(isLoading: true),
      ),
    );
    final response = useCase();
    switch (response) {
      case SuccessResponse<List<CachedExamResultEntity>>():
        emit(
          state.copyWith(
            resultState: BaseState<List<CachedExamResultEntity>>(
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<List<CachedExamResultEntity>>():
        emit(
          state.copyWith(
            resultState: BaseState<List<CachedExamResultEntity>>(
              errorMessage: response.error.message,
            ),
          ),
        );
    }
  }
}
