import 'package:exam_app/features/Auth/login/domain/entites/user_entity.dart';

class LoginEntity {
  final String? message;
  final String? token;
  final UserEntity? user;

   LoginEntity({
  required  this.message,
  required  this.token,
  required  this.user,
  });
}