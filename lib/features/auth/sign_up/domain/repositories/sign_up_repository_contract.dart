import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';

abstract class SignUpRepositoryContract {
  Future<BaseResponse<void>> signUp(SignUpRequestEntity request);
}
