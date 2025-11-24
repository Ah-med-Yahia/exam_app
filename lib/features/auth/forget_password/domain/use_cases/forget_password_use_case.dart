import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_request_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepository forgetPasswordRepository;
  ForgetPasswordUseCase({required this.forgetPasswordRepository});
  Future<BaseResponse<ForgetPasswordResponseModel>> call(ForgetPasswordRequestModel forgetPasswordRequest)async{
    return forgetPasswordRepository.forgetPassword(forgetPasswordRequest);
  }
}