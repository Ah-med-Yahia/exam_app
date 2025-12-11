import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';

abstract class LoginLocalDataSource {
  Future<BaseResponse<void>> saveLoggedUser({
    required String token,
    required UserModel user,
  });

  UserModel? getUser();

 Future<BaseResponse<void>> saveUser(UserModel user);
}
