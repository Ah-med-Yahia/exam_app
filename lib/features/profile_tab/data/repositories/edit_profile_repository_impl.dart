import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/data/data_sources/edit_profile_data_source.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:exam_app/features/profile_tab/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileDataSource _editProfileDataSource;

  EditProfileRepositoryImpl(this._editProfileDataSource);
  @override
  Future<BaseResponse<EditProfileResponse>> editProfile(
    EditProfileRequest request,
  ) async {
    final response = await _editProfileDataSource.editProfile(request);
    switch (response) {
      case SuccessResponse<EditProfileResponse>():
        final profileResponse = response.data;
        return SuccessResponse(data: profileResponse);

      case ErrorResponse<EditProfileResponse>():
        return ErrorResponse<EditProfileResponse>(error: response.error);
    }
  }
}
