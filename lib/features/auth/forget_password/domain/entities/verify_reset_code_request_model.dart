import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';

class VerifyResetCodeRequestModel {
  String? resetCode;
  VerifyResetCodeRequestModel({this.resetCode});
  VerifyResetCodeRequest toDTO()=>VerifyResetCodeRequest(
    resetCode: resetCode
  );
}