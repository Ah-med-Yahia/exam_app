import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_remote_data_source.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl implements ForgetPasswordRemoteDataSource{
  final ForgetPasswordApiClient forgetPasswordApiClient;
  ForgetPasswordRemoteDataSourceImpl({required this.forgetPasswordApiClient});

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(ForgetPasswordRequest forgetPasswordRequest) async{
    try{
      ForgetPasswordResponse forgetPasswordResponse=await forgetPasswordApiClient.forgetPassword(forgetPasswordRequest);
      return SuccessResponse<ForgetPasswordResponse>(data: forgetPasswordResponse);
    }catch(e){
      return ErrorResponse<ForgetPasswordResponse>(error: e as Exception);
    }
  }
  
  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest) async{
    try{
      ResetPasswordResponse resetPasswordResponse=await forgetPasswordApiClient.resetPassword(resetPasswordRequest);
      return SuccessResponse<ResetPasswordResponse>(data: resetPasswordResponse);
    }catch(e){
      return ErrorResponse<ResetPasswordResponse>(error: e as Exception);
    }
  }
  
  @override
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(VerifyResetCodeRequest verifyResetCodeRequest) async{
    try{
      VerifyResetCodeResponse verifyResetCodeResponse=await forgetPasswordApiClient.verifyResetCode(verifyResetCodeRequest);
      return SuccessResponse<VerifyResetCodeResponse>(data: verifyResetCodeResponse);
    }catch(e){
      return ErrorResponse<VerifyResetCodeResponse>(error: e as Exception);
    }
  }
}