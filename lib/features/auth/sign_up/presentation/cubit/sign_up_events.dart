import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';

sealed class SignUpEvents {}

class SignUpEvent extends SignUpEvents {
  final SignUpRequestEntity request;
  SignUpEvent(this.request);
}

class ValidateField extends SignUpEvents {
  final String fieldName;
  final String? password;
  final String value;

  ValidateField(this.fieldName, this.value,[this.password]);
}

