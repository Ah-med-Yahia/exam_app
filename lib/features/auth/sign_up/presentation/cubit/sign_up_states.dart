import 'package:exam_app/config/base_state/base_state.dart';

class SignUpStates {
  final BaseState<String>? signUpState;
  final bool isUserNameValid;
  final bool isFistNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isPhoneValid;

  bool get isFormValid =>
      isUserNameValid &&
      isEmailValid &&
      isFistNameValid &&
      isLastNameValid &&
      isPasswordValid &&
      isConfirmPasswordValid &&
      isPhoneValid;

  SignUpStates({
    this.signUpState,
    this.isUserNameValid = false,
    this.isFistNameValid = false,
    this.isLastNameValid = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isPhoneValid = false,
  });

  SignUpStates copyWith({
    BaseState<String>? signUpState,
    bool? isUserNameValid,
    bool? isFistNameValid,
    bool? isLastNameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isPhoneValid,
  }) {
    return SignUpStates(
      signUpState: signUpState ?? this.signUpState,
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isFistNameValid: isFistNameValid ?? this.isFistNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
    );
  }
}
