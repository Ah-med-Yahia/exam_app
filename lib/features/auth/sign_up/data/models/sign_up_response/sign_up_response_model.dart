import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'sign_up_response_model.g.dart';

SignUpResponseModel signUpResponseFromJson(String str) =>
    SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SignUpResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "token")
  final String token;
  @JsonKey(name: "user")
  final UserModel user;

  SignUpResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseModelToJson(this);
}
