import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:exam_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app/features/auth/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_events.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates>{
  ForgetPasswordCubit(this._forgetPasswordUseCase,this._resetPasswordUseCase,this._verifyResetCodeUseCase):super(ForgetPasswordStates());
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  void doIntent(ForgetPasswordEvents event,String? email,String? resetCode,String? newPassword){
    if (isClosed) return;
    switch(event){
      
      case ForgotPasswordEvent():
        _forgetPassword(email??'');

      case VerifyResetCodeEvent():
        _verifyResetCode(resetCode??'');

      case ResetPasswordEvent():
        _resetPassword(email??'', newPassword??'');

      case ClearVerifyResetCodeErrorEvent():
        _clearVerifyResetCodeError();

      case ClearForgetPasswordStateEvent():
        _clearForgetPasswordState();
      
      case UserInteractedEvent():
        _markUserInteracted();

      case UpdateFormValidationEvent():
        _updateFormValidation(event.isValid);

      case ClearResetPasswordErrorEvent():
        _clearResetPasswordError();

      case RefreshFormEvent():
        _refreshForm();
    }
  }
  Future<void>_forgetPassword(String email)async{
    if (isClosed) return;
    emit(state.copyWith(
      forgetPasswordState: BaseState<ForgetPasswordResponseModel>(isLoading: true),
    ));
    BaseResponse<ForgetPasswordResponseModel> response=await _forgetPasswordUseCase(ForgetPasswordRequestModel(email: email));
    if (isClosed) return;
    switch(response){
      
      case SuccessResponse<ForgetPasswordResponseModel>():
        emit(state.copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponseModel>(
            isLoading: false,
            data: response.data
          ),
        ));
      case ErrorResponse<ForgetPasswordResponseModel>():
        String errorMessage=response.error.message;
        emit(state.copyWith(
          forgetPasswordState: BaseState<ForgetPasswordResponseModel>(
            isLoading: false,
            errorMessage: errorMessage
          ),
        ));
    }
  }
  Future<void> _verifyResetCode(String resetCode)async{
    if (isClosed) return;
    emit(state.copyWith(
      verifyResetCodeState: BaseState<VerifyResetCodeResponseModel>(
        isLoading: true
      )
    ));
    BaseResponse<VerifyResetCodeResponseModel> response=await _verifyResetCodeUseCase(VerifyResetCodeRequestModel(resetCode: resetCode));
    if (isClosed) return;
    switch(response){
      
      case SuccessResponse<VerifyResetCodeResponseModel>():
        emit(state.copyWith(
          verifyResetCodeState: BaseState<VerifyResetCodeResponseModel>(
            isLoading: false,
            data: response.data
          )
        ));
      case ErrorResponse<VerifyResetCodeResponseModel>():
        String errorMessage=response.error.message;
        emit(state.copyWith(
          verifyResetCodeState: BaseState<VerifyResetCodeResponseModel>(
            isLoading: false,
            errorMessage: errorMessage
          )
        ));
    }
  }
  Future<void> _resetPassword(String email,String newPassword)async{
    if (isClosed) return;
    emit(state.copyWith(
      resetPasswordState: BaseState<ResetPasswordResponseModel>(
        isLoading: true
      ),
    ));
    BaseResponse<ResetPasswordResponseModel> response=await _resetPasswordUseCase(ResetPasswordRequestModel(email: email,newPassword: newPassword));
    if (isClosed) return;
    switch(response){
      
      case SuccessResponse<ResetPasswordResponseModel>():
        emit(state.copyWith(
          resetPasswordState: BaseState<ResetPasswordResponseModel>(
            isLoading: false,
            data: response.data
          ),
        ));
      case ErrorResponse<ResetPasswordResponseModel>():
        String errorMessage=response.error.message;
        emit(state.copyWith(
          resetPasswordState: BaseState<ResetPasswordResponseModel>(
            isLoading: false,
            errorMessage: errorMessage
          ),
        ));
    }
  }
  Future<void> _clearVerifyResetCodeError()async{
    if(isClosed) return;
    emit(state.copyWith(
      verifyResetCodeState: BaseState<VerifyResetCodeResponseModel>(
        isLoading: false,
        data: null,
        errorMessage: null, 
      )
    ));
  }
  Future<void> _clearForgetPasswordState()async{
    if(isClosed) return;
    emit(state.copyWith(
      forgetPasswordState: BaseState<ForgetPasswordResponseModel>(
        isLoading: false,
        data: null,
        errorMessage: null
      )
    ));
  }
  Future<void> _markUserInteracted()async{
    if(isClosed) return;
    emit(state.copyWith(
      hasUserInteracted: true
    ));
  }
  Future<void>_updateFormValidation(bool isValid)async{
    if(isClosed) return;
    emit(state.copyWith(
      isFormValid: isValid
    ));
  }
  Future<void> _clearResetPasswordError()async{
    if (isClosed) return;
    emit(state.copyWith(
      resetPasswordState: BaseState<ResetPasswordResponseModel>(
        isLoading: false,
        data: null,
        errorMessage: null,
      ),
    ));
  }
  Future<void> _refreshForm()async{
    if(isClosed) return;
    emit(state.copyWith(
      hasUserInteracted: false,
      isFormValid: true
    ));
  }
}
