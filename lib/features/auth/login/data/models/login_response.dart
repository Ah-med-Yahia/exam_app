import 'package:exam_app/features/Auth/login/domain/entites/login_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? message;
  final String? token;
  final User? user;

  const LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

extension LoginResponseMapper on LoginResponse {
  LoginEntity toEntity() {
    return LoginEntity(message: message, token: token, user: user?.toEntity());
  }
}
