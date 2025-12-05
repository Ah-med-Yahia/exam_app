import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:exam_app/features/profile_tab/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepository _editProfileRepository;

  EditProfileUseCase(this._editProfileRepository);

  Future<BaseResponse<EditProfileResponse>> call(EditProfileRequest request) =>
      _editProfileRepository.editProfile(request);
}
