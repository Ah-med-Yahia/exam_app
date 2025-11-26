import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/network/api_call.dart';
import 'package:exam_app/features/auth/login/api/api_client/login_api_client.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_remote_data_source.dart';
import 'package:exam_app/features/auth/login/data/models/login_request.dart';
import 'package:exam_app/features/auth/login/data/models/login_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final LoginApiClient _loginApiClient;

  LoginRemoteDataSourceImpl(this._loginApiClient);

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest body) {
    return safeApiCall<LoginResponse>(() => _loginApiClient.login(body));
  }
}
