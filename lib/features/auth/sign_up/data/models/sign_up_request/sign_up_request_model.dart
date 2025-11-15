import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'sign_up_request_model.g.dart';

SignUpRequestModel signUpRequestFromJson(String str) =>
    SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequestModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SignUpRequestModel {
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

  SignUpRequestModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}
