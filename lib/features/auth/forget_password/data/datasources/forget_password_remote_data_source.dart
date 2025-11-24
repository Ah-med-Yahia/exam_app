import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest);
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(VerifyResetCodeRequest verifyResetCodeRequest);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest);
}