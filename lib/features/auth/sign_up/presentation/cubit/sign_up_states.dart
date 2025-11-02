import 'package:exam_app/config/base_state/base_state.dart';

class SignUpStates {
  final BaseState<String>? signUpState;
  final bool isFormValid;

  SignUpStates({
    this.signUpState,
    this.isFormValid = false,
  });

  SignUpStates copyWith({
    BaseState<String>? signUpState,
    bool? isFormValid,
  }) {
    return SignUpStates(
      signUpState: signUpState ?? this.signUpState,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}



