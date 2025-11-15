import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';



@JsonSerializable()
class ResetPasswordRequest {
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "newPassword")
    String? newPassword;

    ResetPasswordRequest({
        this.email,
        this.newPassword,
    });

    factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);

    Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
    ResetPasswordRequestModel toDomain()=>ResetPasswordRequestModel(
      email: email,
      newPassword: newPassword
    );
}
