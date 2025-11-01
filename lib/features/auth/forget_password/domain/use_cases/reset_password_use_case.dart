import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepository forgetPasswordRepository;
  ResetPasswordUseCase({required this.forgetPasswordRepository});
  Future<BaseResponse<ResetPasswordResponseModel>> call(ResetPasswordRequestModel resetPasswordRequest)async{
    return forgetPasswordRepository.resetPassword(resetPasswordRequest);
  }
}