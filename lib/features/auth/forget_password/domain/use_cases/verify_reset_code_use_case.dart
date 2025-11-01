import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepository forgetPasswordRepository;
  VerifyResetCodeUseCase({required this.forgetPasswordRepository});
  Future<BaseResponse<VerifyResetCodeResponseModel>> call(VerifyResetCodeRequestModel verifyResetCodeRequest)async{
    return forgetPasswordRepository.verifyResetCode(verifyResetCodeRequest);
  }
}