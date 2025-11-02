import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_events.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {

  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());
  final SignUpUseCase _signUpUseCase;

    void doIntent(SignUpEvents event) {
    switch (event) {
      case SignUpEvent(: final request):
        _signUp(request);
    }
  }

  void _signUp(SignUpRequestEntity request) async {
    emit(SignUpLoading());
    final result = await _signUpUseCase(request);
    switch(result) {
      case  SuccessResponse<void>():
        emit(SignUpSuccess());
      case ErrorResponse<void>():
        emit(SignUpFailure(result.error.toString()));
    }
  }
}
