import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/features/auth/login/data/models/login_request.dart';
import 'package:exam_app/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:exam_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:exam_app/features/auth/login/presentation/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUseCase) : super(LoginStates());
  final LoginUseCase _loginUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> doIntent(LoginIntents intent) async {
    switch (intent) {
      case EmailChanged():
        final isValid = _validateForm();
        emit(state.copyWith(isFormValid: isValid));
        break;
      case PasswordChanged():
        final isValid = _validateForm();
        emit(state.copyWith(isFormValid: isValid));
        break;

      case RememberMeToggled():
        emit(state.copyWith(rememberMe: !state.rememberMe));
        break;

      case LoginButtonPressed():
          _performLogin(intent);
          break;
      }
    }

  bool _validateForm() {
    return Validator.validateEmail(emailController.text) == null &&
        Validator.validatePassword(passwordController.text) == null;
  }

   Future<void> _performLogin(LoginButtonPressed intent) async {
  emit(state.copyWith(isLoading: true, data: null, errorMessage: null));

  final response = await _loginUseCase(
    LoginRequest(
      email: intent.email,
      password: intent.password,
    ),
  );
  
  switch (response) {
    case SuccessResponse():
      emit(state.copyWith(data: response.data, isLoading: false));
      break;

    case ErrorResponse():
      emit(
        state.copyWith(
          errorMessage: UiConstants.failedToLogin,
          isLoading: false,
        ),
      );
      break;
  }
}

@override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
