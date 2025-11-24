import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'sign_up_request_entity.g.dart';

SignUpRequestEntity signUpRequestFromJson(String str) =>
    SignUpRequestEntity.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequestEntity data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SignUpRequestEntity {
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "rePassword")
  final String rePassword;
  @JsonKey(name: "phone")
  final String phone;

  SignUpRequestEntity({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  factory SignUpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestEntityToJson(this);
}
