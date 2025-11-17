import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/Auth/login/data/datasources/login_remote_data_source.dart';
import 'package:exam_app/features/Auth/login/data/models/login_request.dart';
import 'package:exam_app/features/Auth/login/data/models/login_response.dart';
import 'package:exam_app/features/Auth/login/domain/entites/login_entity.dart';
import 'package:exam_app/features/Auth/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);
  @override
  Future<BaseResponse<LoginEntity>> login(LoginRequest request) async {
    final response = await remoteDataSource.login(request);
    switch (response) {
      case SuccessResponse<LoginResponse>():
        final loginResponse = response.data;
        final loginEntity = loginResponse.toEntity();
        return SuccessResponse<LoginEntity>(data: loginEntity);

      case ErrorResponse<LoginResponse>():
        return ErrorResponse<LoginEntity>(error: response.error);
    }
  }
}
