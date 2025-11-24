import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';

class ForgetPasswordStates {
  BaseState<ForgetPasswordResponseModel>? forgetPasswordState;
  BaseState<VerifyResetCodeResponseModel>? verifyResetCodeState;
  BaseState<ResetPasswordResponseModel>? resetPasswordState;
  bool? hasUserInteracted;
  bool? isFormValid;
  ForgetPasswordStates({this.forgetPasswordState,this.verifyResetCodeState,this.resetPasswordState,this.hasUserInteracted=false,this.isFormValid=true});
  ForgetPasswordStates copyWith({
    BaseState<ForgetPasswordResponseModel>? forgetPasswordState,
    BaseState<VerifyResetCodeResponseModel>? verifyResetCodeState,
    BaseState<ResetPasswordResponseModel>? resetPasswordState,
    bool? hasUserInteracted,
    bool? isFormValid,  
  }){
    return ForgetPasswordStates(
      forgetPasswordState: forgetPasswordState??this.forgetPasswordState,
      verifyResetCodeState: verifyResetCodeState??this.verifyResetCodeState,
      resetPasswordState: resetPasswordState??this.resetPasswordState,
      hasUserInteracted: hasUserInteracted??this.hasUserInteracted,
      isFormValid:isFormValid??this.isFormValid,
    );
  }
}