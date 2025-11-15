import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_password_api_client.g.dart';
@injectable
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;
  @POST(ApiConstants.forgotPasswordEndPoint)
  Future<ForgetPasswordResponse> forgetPassword(@Body() ForgetPasswordRequest forgetPasswordRequest);

  @POST(ApiConstants.verifyResetCodeEndPoint)
  Future<VerifyResetCodeResponse> verifyResetCode(@Body() VerifyResetCodeRequest verifyResetCodeRequest);

  @PUT(ApiConstants.resetPasswordEndPoint)
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest resetPasswordRequest);
}