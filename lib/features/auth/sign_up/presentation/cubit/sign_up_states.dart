sealed class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSuccess extends SignUpStates {}

class SignUpFailure extends SignUpStates {
  final String error;

  SignUpFailure(this.error);
}
