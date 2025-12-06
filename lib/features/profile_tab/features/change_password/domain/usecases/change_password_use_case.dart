import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_request.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_response.dart';
import 'package:exam_app/features/profile_tab/features/change_password/domain/repositories/change_passwprd_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswprdRepository _passwprdRepository;

  ChangePasswordUseCase(this._passwprdRepository);

  Future<BaseResponse<ChangePasswordResponse>> call(
    ChangePasswordRequest request,
  ) async {
    return _passwprdRepository.changePassword(request);
  }
}
