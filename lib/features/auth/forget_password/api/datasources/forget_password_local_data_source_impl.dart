import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_local_data_source.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordLocalDataSource)
class ForgetPasswordLocalDataSourceImpl implements ForgetPasswordLocalDataSource{
  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(VerifyResetCodeRequest verifyResetCodeRequest) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
  }

}