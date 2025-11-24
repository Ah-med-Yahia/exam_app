import 'package:exam_app/features/auth/forget_password/domain/entities/verify_reset_code_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_request.g.dart';


@JsonSerializable()
class VerifyResetCodeRequest {
    @JsonKey(name: "resetCode")
    String? resetCode;

    VerifyResetCodeRequest({
        this.resetCode,
    });

    factory VerifyResetCodeRequest.fromJson(Map<String, dynamic> json) => _$VerifyResetCodeRequestFromJson(json);

    Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
    VerifyResetCodeRequestModel toDomain()=>VerifyResetCodeRequestModel(
      resetCode: resetCode
    );
}
