
import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "info")
    String? info;
    @JsonKey(name: "code")
    int? code;

    ForgetPasswordResponse({
        this.message,
        this.info,
        this.code,
    });

    factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgetPasswordResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
    ForgetPasswordResponseModel toDomain()=>ForgetPasswordResponseModel(
      info: info,
      message: message
    );
}
