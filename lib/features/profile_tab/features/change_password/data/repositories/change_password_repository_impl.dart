import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/datasources/change_password_data_source.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_request.dart';
import 'package:exam_app/features/profile_tab/features/change_password/data/models/change_password_response.dart';
import 'package:exam_app/features/profile_tab/features/change_password/domain/repositories/change_passwprd_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswprdRepository)
class ChangePasswordRepositoryImpl implements ChangePasswprdRepository {
  final ChangePasswordDataSource _dataSource;

  ChangePasswordRepositoryImpl(this._dataSource);
  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  ) async {
    final response = await _dataSource.changePassword(request);

    switch (response) {
      case SuccessResponse<ChangePasswordResponse>():
        final passwordResponse = response.data;
        return SuccessResponse<ChangePasswordResponse>(data: passwordResponse);

      case ErrorResponse<ChangePasswordResponse>():
        return ErrorResponse<ChangePasswordResponse>(error: response.error);
    }
  }
}
