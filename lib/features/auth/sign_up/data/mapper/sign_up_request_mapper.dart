import 'package:exam_app/features/auth/sign_up/data/models/sign_up_request/sign_up_request_model.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';

extension SignUpRequestMapper on SignUpRequestEntity {
  SignUpRequestModel toModel() => SignUpRequestModel(
        email: email,
        password: password,
        firstName: firstName, 
        lastName: lastName,
        phone: phone,
        rePassword: rePassword,
        username: username,
      );
}
