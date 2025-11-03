import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/Auth/login/data/models/login_request.dart';
import 'package:exam_app/features/Auth/login/domain/entites/login_entity.dart';

abstract class LoginRepository {
    Future<BaseResponse<LoginEntity>> login(LoginRequest request);
}
