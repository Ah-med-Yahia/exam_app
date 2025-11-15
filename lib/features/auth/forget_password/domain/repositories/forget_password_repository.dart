import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';

abstract class ForgetPasswordRepository {
  Future<BaseResponse<ForgetPasswordResponseModel>> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequest);
  Future<BaseResponse<VerifyResetCodeResponseModel>> verifyResetCode(VerifyResetCodeRequestModel verifyResetCodeRequest);
  Future<BaseResponse<ResetPasswordResponseModel>> resetPassword(ResetPasswordRequestModel resetPasswordRequest);
}