import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_events.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this._signUpUseCase) : super(SignUpStates());
  final SignUpUseCase _signUpUseCase;

  void doIntent(SignUpEvents event) {
    switch (event) {
      case SignUpEvent(:final request):
        _signUp(request);
      case ValidateField():
        _validateFormField(event);
    }
  }

  void _validateFormField(ValidateField event) {
    final bool isValid;

    switch (event.fieldName) {
      case 'username':
        isValid = Validator.validateUsername(event.value) == null;
        emit(state.copyWith(isUserNameValid: isValid));
      case 'firstName':
        isValid = Validator.validateFirstName(event.value) == null;
        emit(state.copyWith(isFistNameValid: isValid));
      case 'lastName':
        isValid = Validator.validateLastName(event.value) == null;
        emit(state.copyWith(isLastNameValid: isValid));
      case 'email':
        isValid = Validator.validateEmail(event.value) == null;
        emit(state.copyWith(isEmailValid: isValid));
      case 'password':
        isValid = Validator.validatePassword(event.value) == null;
        emit(state.copyWith(isPasswordValid: isValid));
      case 'confirmPassword':
        isValid =
            Validator.validateConfirmPassword(event.value, event.password) ==
            null;
        emit(state.copyWith(isConfirmPasswordValid: isValid));
      case 'phone':
        isValid = Validator.validatePhoneNumber(event.value) == null;
        emit(state.copyWith(isPhoneValid: isValid));
      default:
        break;
    }
  }

  void _signUp(SignUpRequestEntity request) async {
    emit(state.copyWith(signUpState: BaseState<String>(isLoading: true)));
    final result = await _signUpUseCase(request);
    switch (result) {
      case SuccessResponse<void>():
        emit(
          state.copyWith(
            signUpState: BaseState<String>(
              isLoading: false,
              data: 'Sign Up Successful',
            ),
          ),
        );
      case ErrorResponse<void>():
        emit(
          state.copyWith(
            signUpState: BaseState<String>(
              isLoading: false,
              errorMessage: result.error.message,
            ),
          ),
        );
    }
  }
}
