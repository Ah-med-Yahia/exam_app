import 'package:exam_app/features/auth/login/domain/entites/user_entity.dart';

class LoginEntity {
  final String? message;
  final UserEntity? user;

  LoginEntity({this.message, this.user});
}
