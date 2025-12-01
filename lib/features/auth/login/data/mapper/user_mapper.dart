import 'package:exam_app/features/auth/login/data/models/user.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';

extension UserMapper on User {
  UserModel toModel() {
    return UserModel(
       username: username ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      role: role ?? 'user',
      isVerified: isVerified ?? false,
      id: id ?? '',
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
