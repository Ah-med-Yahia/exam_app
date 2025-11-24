import 'package:exam_app/features/auth/forget_password/domain/entities/forget_password_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';



@JsonSerializable()
class ForgetPasswordRequest {
    @JsonKey(name: "email")
    String? email;

    ForgetPasswordRequest({
        this.email,
    });

    factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgetPasswordRequestFromJson(json);

    Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
    ForgetPasswordRequestModel toDomain() =>ForgetPasswordRequestModel(
      email: email
    );
}
