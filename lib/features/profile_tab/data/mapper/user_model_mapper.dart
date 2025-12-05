import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/user.dart';

extension UserModelMapper on User {
  UserModel toUserMode() {
    return UserModel(
      username: username ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      role: role ?? '',
      isVerified: isVerified ?? false,
      id: id ?? '',
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
