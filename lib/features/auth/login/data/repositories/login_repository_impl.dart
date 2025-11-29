import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_local_data_source.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_remote_data_source.dart';
import 'package:exam_app/features/auth/login/data/mapper/user_mapper.dart';
import 'package:exam_app/features/auth/login/data/models/login_request.dart';
import 'package:exam_app/features/auth/login/data/models/login_response.dart';
import 'package:exam_app/features/auth/login/domain/entites/login_entity.dart';
import 'package:exam_app/features/auth/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl(this.remoteDataSource, this.localDataSource);
  @override
  Future<BaseResponse<LoginEntity>> login(LoginRequest request) async {
    final response = await remoteDataSource.login(request);
    switch (response) {
      case SuccessResponse<LoginResponse>():
        final loginResponse = response.data;
        final loginEntity = loginResponse.toEntity();
        final localSave = localDataSource.saveLoggedUser(
          token: loginResponse.token!,
          user: loginResponse.user!.toModel(),
        );
        if(localSave is ErrorResponse){
           return ErrorResponse<LoginEntity>(error:LocalException(message: UiConstants.failedToSaveUser));
        }
        return SuccessResponse<LoginEntity>(data: loginEntity);

      case ErrorResponse<LoginResponse>():
        return ErrorResponse<LoginEntity>(error: response.error);
    }
  }

  Future<BaseResponse<void>> saveLoggedUser({
    required LoginResponse loginResponse,
  }) async {
    BaseResponse<void> response = await localDataSource.saveLoggedUser(
      token: loginResponse.token!,
      user: loginResponse.user!.toModel(),
    );
    switch (response) {
      case SuccessResponse<void>():
        return SuccessResponse<void>(data: null);
      case ErrorResponse<void>():
        return ErrorResponse<void>(error: response.error);
    }
  }
}
