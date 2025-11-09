sealed class ForgetPasswordEvents {}
class ForgotPasswordEvent extends ForgetPasswordEvents{}
class VerifyResetCodeEvent extends ForgetPasswordEvents{}
class ResetPasswordEvent extends ForgetPasswordEvents{}
class ClearVerifyResetCodeErrorEvent extends ForgetPasswordEvents{}
class ClearForgetPasswordStateEvent extends ForgetPasswordEvents{}
class UserInteractedEvent extends ForgetPasswordEvents{}
class UpdateFormValidationEvent extends ForgetPasswordEvents {
  final bool isValid;
  UpdateFormValidationEvent({required this.isValid}); 
}
class ClearResetPasswordErrorEvent extends ForgetPasswordEvents{}
class RefreshFormEvent extends ForgetPasswordEvents{}  