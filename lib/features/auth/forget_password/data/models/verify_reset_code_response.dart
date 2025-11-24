import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response.g.dart';



@JsonSerializable()
class VerifyResetCodeResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "code")
    int? code;

    VerifyResetCodeResponse({
        this.status,
        this.message,
        this.code,
    });

    factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) => _$VerifyResetCodeResponseFromJson(json);

    Map<String, dynamic> toJson() => _$VerifyResetCodeResponseToJson(this);
    VerifyResetCodeResponseModel toDomain()=>VerifyResetCodeResponseModel(
      message: message,
      status: status,
      code: code
    );
}
