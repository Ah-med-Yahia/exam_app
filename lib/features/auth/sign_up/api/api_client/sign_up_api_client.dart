import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_request/sign_up_request_model.dart';
import 'package:exam_app/features/auth/sign_up/data/models/sign_up_response/sign_up_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'sign_up_api_client.g.dart';

@singleton
@RestApi()
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST(ApiConstants.signUpEndPoint)
  Future<SignUpResponseModel> signUp(@Body() SignUpRequestModel signUpRequest);
}