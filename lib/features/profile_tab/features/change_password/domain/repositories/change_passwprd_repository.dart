import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_request.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_response.dart';

abstract class ChangePasswprdRepository {
  Future<BaseResponse<ChangePasswordResponse>> changePassword(ChangePasswordRequest request);
}
