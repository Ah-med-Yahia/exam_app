import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/network/api_call.dart';
import 'package:exam_app/features/profile_tab/api/api_client/edit_profile_api_client.dart';
import 'package:exam_app/features/profile_tab/data/data_sources/edit_profile_data_source.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileDataSource)
class EditProfileDataSourceImpl implements EditProfileDataSource {
  final EditProfileApiClient _apiClient;

  EditProfileDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<EditProfileResponse>> editProfile(
    EditProfileRequest request,
  ) {
    return safeApiCall(() => _apiClient.editProfile(request));
  }
}
