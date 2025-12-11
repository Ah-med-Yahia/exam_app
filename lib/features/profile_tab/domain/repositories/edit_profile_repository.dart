import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';

abstract class EditProfileRepository {
  Future<BaseResponse<EditProfileResponse>> editProfile(
    EditProfileRequest request,
  );
}
