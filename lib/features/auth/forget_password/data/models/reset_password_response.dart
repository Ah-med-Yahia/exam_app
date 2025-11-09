import 'package:exam_app/features/auth/forget_password/domain/entities/reset_password_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';



@JsonSerializable()
class ResetPasswordResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "token")
    String? token;
    @JsonKey(name: "code")
    int? code;
    ResetPasswordResponse({
        this.message,
        this.token,
        this.code
    });

    factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ResetPasswordResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
    ResetPasswordResponseModel toDomain()=>ResetPasswordResponseModel(
      message: message,
      token: token,
      code: code
    );
}
