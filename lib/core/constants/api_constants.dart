class ApiConstants {
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const String signUpEndPoint = 'auth/signup';
  static const String loginEndPoint = 'auth/signin';
  static const String changePasswordPoint = 'auth/changePassword';
  static const String deleteAccountEndPoint = 'auth/deleteMe';
  static const String editProfileEndPoint = 'auth/editProfile';
  static const String logoutEndPoint = 'auth/logout';
  static const String getLoggedEndPoint = 'auth/profileData';
  static const String forgotPasswordEndPoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndPoint = 'auth/verifyResetCode';
  static const String resetPasswordEndPoint = 'auth/resetPassword';
}

class CacheConstants {
  static const String tokenKey = 'token';
  static const String tokenBoxKey = 'tokenBox';
  static const String userBoxKey = 'userBox';
  static const String currentUserKey = 'currentUser';

}
