import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/Auth/login/api/api_client/login_api_client.dart';
import 'package:exam_app/features/Auth/login/data/datasources/login_remote_data_source.dart';
import 'package:exam_app/features/Auth/login/data/models/login_request.dart';
import 'package:exam_app/features/Auth/login/data/models/login_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final LoginApiClient loginApiClient;

  LoginRemoteDataSourceImpl(this.loginApiClient);
  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest body) async {
    try {
      final response = await loginApiClient.login(body);
      return SuccessResponse<LoginResponse>(data: response);
    } catch (exception) {
      return ErrorResponse<LoginResponse>(
        error: Exception(exception.toString()),
      );
    }
  }
}
