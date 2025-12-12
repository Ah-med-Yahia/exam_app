
import 'package:bloc/bloc.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/profile_tab/features/change_password/data/models/change_password_request.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/profile_tab/features/change_password/data/models/change_password_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/profile_tab/features/change_password/domain/usecases/change_password_use_case.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/profile_tab/features/change_password/presentation/cubit/change_password_intents.dart';
import 'package:injectable/injectable.dart';

part 'change_password_states.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit(this._passwordUseCase) : super(ChangePasswordStates());
  final ChangePasswordUseCase _passwordUseCase;

  Future<void> doIntent(ChangePasswordIntents intent) async {
    switch (intent) {
      case CurrentPasswordChanged():
        emit(
          state.copyWith(
            currentPassword: intent.currentPassword,
            clearError: true,
            clearSuccess: true,
          ),
        );

        break;
      case NewPasswordChanged():
        emit(
          state.copyWith(
            newPassword: intent.newPassword,
            clearError: true,
            clearSuccess: true,
          ),
        );
        break;

      case ConfirmPasswordChanged():
        emit(
          state.copyWith(
            confirmPassword: intent.confirmPassword,
            clearError: true,
            clearSuccess: true,
          ),
        );
        break;
      case UpdateProfilePressed():
        _updatePassword();
    }
  }

  Future<void> _updatePassword() async {
    if (state.currentPassword.isEmpty ||
        state.confirmPassword.isEmpty ||
        state.newPassword.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: UiConstants.pleaseCompleteYourData,
          clearData: true,
        ),
      );
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      emit(
        state.copyWith(
          errorMessage: UiConstants.passwordsdontMatch,
          clearSuccess: true,
        ),
      );
      return;
    }
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final request = ChangePasswordRequest(
      oldPassword: state.currentPassword,
      password: state.newPassword,
      rePassword: state.newPassword,
    );

    final response = await _passwordUseCase(request);

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            data: response.data,
            isLoading: false,
            isUpdatedSuccessfully: true,
            successMessage: UiConstants.passwordUpdatedSuccessfully,
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            isLoading: false,
            clearSuccess: true,
            errorMessage: UiConstants.failedToUpdatepassword,
          ),
        );
        break;
    }
  }
}
