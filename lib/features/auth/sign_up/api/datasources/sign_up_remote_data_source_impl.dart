import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/auth/sign_up/api/api_client/api_client.dart';
import 'package:exam_app/features/auth/sign_up/data/datasources/sign_up_remote_data_source_contract.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_request/sign_up_request_model.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_response/sign_up_response_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SignUpRemoteDataSourceContract)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSourceContract {
  SignUpApiClient apiClient;

  SignUpRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BaseResponse<SignUpResponseModel>> signUp(
    SignUpRequestModel request,
  ) async {
    try {
      SignUpResponseModel response = await apiClient.signUp(request);
      return SuccessResponse<SignUpResponseModel>(data: response);
    } catch (e) {
      return ErrorResponse<SignUpResponseModel>(error: RemoteException.fromDioError(e as Exception));
    }
  }
}
