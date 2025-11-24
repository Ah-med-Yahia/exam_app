import 'package:exam_app/features/auth/forget_password/data/models/forget_password_request.dart';

class ForgetPasswordRequestModel {
  String? email;
  ForgetPasswordRequestModel({required this.email});
  ForgetPasswordRequest toDTO()=>ForgetPasswordRequest(
    email: email
  );
}