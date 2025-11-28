class LoginIntents {}

class EmailChanged extends LoginIntents {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends LoginIntents {
  final String password;
  PasswordChanged(this.password);
}

class RememberMeToggled extends LoginIntents {}

class LoginButtonPressed extends LoginIntents {
  final String email;
  final String password;
  LoginButtonPressed(this.email, this.password);
}
