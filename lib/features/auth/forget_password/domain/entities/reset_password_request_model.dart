import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';

class ResetPasswordRequestModel {
  String? email;
  String? newPassword;
  ResetPasswordRequestModel({this.email,this.newPassword});
  ResetPasswordRequest toDTO()=>ResetPasswordRequest(
    email: email,
    newPassword: newPassword
  );
}