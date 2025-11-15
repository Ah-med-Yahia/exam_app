// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestEntity _$SignUpRequestEntityFromJson(Map<String, dynamic> json) =>
    SignUpRequestEntity(
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      rePassword: json['rePassword'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$SignUpRequestEntityToJson(
  SignUpRequestEntity instance,
) => <String, dynamic>{
  'username': instance.username,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'password': instance.password,
  'rePassword': instance.rePassword,
  'phone': instance.phone,
};
