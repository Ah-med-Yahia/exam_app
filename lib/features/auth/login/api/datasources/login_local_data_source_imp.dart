import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_local_data_source.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LoginLocalDataSource)
class LoginLocalDataSourceImp implements LoginLocalDataSource {
  final Box<UserModel> userBox;
  final Box<String> tokenBox;
  LoginLocalDataSourceImp(this.userBox, this.tokenBox);
  @override
  Future<BaseResponse<void>> saveLoggedUser({
    required String token,
    required UserModel user,
  }) async {
    try {
      await userBox.put(CacheConstants.currentUserKey, user);
      await tokenBox.put(CacheConstants.tokenKey, token);
      return SuccessResponse<void>(data: null);
    } catch (e) {
      return ErrorResponse<void>(error: LocalException(message: 'Failed to save user locally'));
    }
  }
}
