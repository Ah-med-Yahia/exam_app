import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/Auth/login/data/models/login_request.dart';
import 'package:exam_app/features/Auth/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(LoginRequest body);
}
