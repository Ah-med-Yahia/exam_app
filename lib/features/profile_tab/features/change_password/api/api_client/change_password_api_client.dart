import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_request.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'change_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(ApiConstants.changePasswordEndPoint)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest request
  );
}
