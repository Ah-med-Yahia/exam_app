import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/data/mapper/sign_up_request_mapper.dart';
import 'package:exam_app/features/auth/sign_up/data/datasources/sign_up_local_data_source_contract.dart';
import 'package:exam_app/features/auth/sign_up/data/datasources/sign_up_remote_data_source_contract.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_request/sign_up_request_model.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_response/sign_up_response_model.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SignUpRepositoryContract)
class SignUpRepositoryImpl implements SignUpRepositoryContract {
  final SignUpRemoteDataSourceContract remoteDataSource;
  final SignUpLocalDataSourceContract localDataSource;

  SignUpRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<BaseResponse<void>> signUp(SignUpRequestEntity requestEntity) async {
    SignUpRequestModel request = requestEntity.toModel();
    BaseResponse<SignUpResponseModel> response = await remoteDataSource.signUp(
      request,
    );

    switch (response) {
      case SuccessResponse<SignUpResponseModel>():
        BaseResponse<void> cachedResponse = await saveLoggedUser(
          signUpResponse: response.data,
        );
        switch (cachedResponse) {
          case ErrorResponse<void>():
            return ErrorResponse<void>(error: cachedResponse.error);
          case SuccessResponse<void>():
            return SuccessResponse<void>(data: null);
        }
      case ErrorResponse<SignUpResponseModel>():
        return ErrorResponse<void>(error: response.error);
    }
  }

  Future<BaseResponse<void>> saveLoggedUser({
    required SignUpResponseModel signUpResponse,
  }) async {
    BaseResponse<void> response = await localDataSource.saveLoggedUser(
      token: signUpResponse.token,
      user: signUpResponse.user,
    );
    switch (response) {
      case SuccessResponse<void>():
        return SuccessResponse<void>(data: null);
      case ErrorResponse<void>():
        return ErrorResponse<void>(error: response.error);
    }
  }
}
