import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_local_data_source.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_remote_data_source.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forget_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository{
  final ForgetPasswordRemoteDataSource remoteDataSource;
  final ForgetPasswordLocalDataSource localDataSource;
  ForgetPasswordRepositoryImpl({required this.remoteDataSource,required this.localDataSource});
  @override
  Future<BaseResponse<ForgetPasswordResponseModel>> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequest) async{
    BaseResponse<ForgetPasswordResponse> baseResponseDTO=await remoteDataSource.forgetPassword(forgetPasswordRequest.toDTO());
    switch (baseResponseDTO){

      case SuccessResponse<ForgetPasswordResponse>():
        ForgetPasswordResponse responseDTO=baseResponseDTO.data;
        ForgetPasswordResponseModel responseModel=responseDTO.toDomain();
        return SuccessResponse<ForgetPasswordResponseModel>(data: responseModel);
      case ErrorResponse<ForgetPasswordResponse>():
        return ErrorResponse<ForgetPasswordResponseModel>(error: baseResponseDTO.error);
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponseModel>> resetPassword(ResetPasswordRequestModel resetPasswordRequest) async{
    BaseResponse<ResetPasswordResponse> baseResponseDTO=await remoteDataSource.resetPassword(resetPasswordRequest.toDTO());
    switch (baseResponseDTO){
      
      case SuccessResponse<ResetPasswordResponse>():
        ResetPasswordResponse responseDTO=baseResponseDTO.data;
        String token=responseDTO.token!;
        localDataSource.saveToken(token: token);
        ResetPasswordResponseModel responseModel=responseDTO.toDomain();
        return SuccessResponse<ResetPasswordResponseModel>(data: responseModel);
      case ErrorResponse<ResetPasswordResponse>():
        return ErrorResponse<ResetPasswordResponseModel>(error: baseResponseDTO.error);
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponseModel>> verifyResetCode(VerifyResetCodeRequestModel verifyResetCodeRequest) async{
    BaseResponse<VerifyResetCodeResponse> baseResponseDTO=await remoteDataSource.verifyResetCode(verifyResetCodeRequest.toDTO());
    switch (baseResponseDTO){
      
      case SuccessResponse<VerifyResetCodeResponse>():
        VerifyResetCodeResponse responseDTO=baseResponseDTO.data;
        VerifyResetCodeResponseModel responseModel=responseDTO.toDomain();
        return SuccessResponse<VerifyResetCodeResponseModel>(data: responseModel);
      case ErrorResponse<VerifyResetCodeResponse>():
        return ErrorResponse(error: baseResponseDTO.error);
    }
  }

}