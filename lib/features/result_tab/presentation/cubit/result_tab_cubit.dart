import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'result_tab_state.dart';

class ResultTabCubit extends Cubit<ResultTabState> {
  ResultTabCubit() : super(ResultTabInitial());
}
