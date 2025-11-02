import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_request/sign_up_request_model.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_response/sign_up_response_model.dart';

abstract class SignUpRemoteDataSourceContract {
  Future<BaseResponse<SignUpResponseModel>> singnUp(SignUpRequestModel request);
}
