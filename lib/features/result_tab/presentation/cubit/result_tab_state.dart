import 'package:exam_app/config/base_state/base_state.dart';

class ResultTabState {
  final BaseState? resultState;
  ResultTabState({this.resultState});

  ResultTabState copyWith({BaseState? resultState}) {
    return ResultTabState(resultState: resultState??this.resultState);
  }
}
