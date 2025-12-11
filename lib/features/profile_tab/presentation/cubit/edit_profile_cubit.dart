import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_local_data_source.dart';
import 'package:exam_app/features/profile_tab/data/mapper/user_model_mapper.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_request.dart';
import 'package:exam_app/features/profile_tab/domain/use_cases/edit_profile_use_case.dart';
import 'package:exam_app/features/profile_tab/presentation/cubit/edit_profile_intents.dart';
import 'package:exam_app/features/profile_tab/presentation/cubit/edit_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit(this._profileUseCase, this._localDataSource)
    : super(EditProfileStates());
  final EditProfileUseCase _profileUseCase;
  final LoginLocalDataSource _localDataSource;

  Future<void> doIntent(EditProfileIntent intent) async {
    switch (intent) {
      case LoadUserData():
        _loadUserData();
        break;

      case EmailChanged():
        emit(
          state.copyWith(
            email: intent.email,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case UsernameChanged():
        emit(
          state.copyWith(
            username: intent.username,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case FirstNameChanged():
        emit(
          state.copyWith(
            firstName: intent.firstName,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case LastNameChanged():
        emit(
          state.copyWith(
            lastName: intent.lastName,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case ProfileImagePicked():
        emit(
          state.copyWith(
            profileImagePath: intent.imagePath,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case PhoneChanged():
        emit(
          state.copyWith(
            phone: intent.phone,
            clearError: true,
            successMessage: null,
          ),
        );
        break;

      case UpdateProfilePressed():
        await _updateProfile();
        break;
      case ChangePasswordRequested():
        throw UnimplementedError();
    }
  }

  void resetMessages() {
  emit(
    state.copyWith(
      isUpdatedSuccessfully: false,
      errorMessage: null,
      successMessage: null,
    ),
  );
}

  void _loadUserData() {
    final user = _localDataSource.getUser();
    if (user != null) {
      emit(
        state.copyWith(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          isDataLoaded: true,
        ),
      );
    }
  }

  Future<void> _updateProfile() async {
    if (state.username.isEmpty ||
        state.email.isEmpty ||
        state.phone.isEmpty ||
        state.firstName.isEmpty ||
        state.lastName.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: UiConstants.pleaseCompleteYourData,
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final user = _localDataSource.getUser();

    bool noChanges =
        user != null &&
        user.username == state.username &&
        user.email == state.email &&
        user.phone == state.phone &&
        user.firstName == state.firstName &&
        user.lastName == state.lastName;

    if (noChanges) {
      emit(
        state.copyWith(
          isLoading: false,
          isUpdatedSuccessfully: false,
          successMessage: UiConstants.noChanesToUpdate,
        ),
      );
      return;
    }

    final request = EditProfileRequest(
      email: state.email,
      username: state.username,
      phone: state.phone,
      firstName: state.firstName,
      lastName: state.lastName,
    );

    final response = await _profileUseCase(request);

    switch (response) {
      case SuccessResponse():
        if (response.data.user != null) {
          final updatedUser = response.data.user!;
          final saveResult = await _localDataSource.saveUser(
            updatedUser.toUserMode(),
          );

          if (saveResult is SuccessResponse) {
            emit(
              state.copyWith(
                isLoading: false,
                isUpdatedSuccessfully: true,
                successMessage: UiConstants.profileUpdatedSuccessfully,
                data: response.data,
                username: updatedUser.username,
                firstName: updatedUser.firstName,
                lastName: updatedUser.lastName,
                email: updatedUser.email,
                phone: updatedUser.phone,
              ),
            );
          } else {
            emit(
              state.copyWith(
                isLoading: false,
                isUpdatedSuccessfully: false,
                errorMessage: UiConstants.failedToSaveUser,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              isUpdatedSuccessfully: false,
              errorMessage: UiConstants.failedToUpdateProfile,
            ),
          );
        }
        break;

      case ErrorResponse():
        emit(
          state.copyWith(
            isLoading: false,
            isUpdatedSuccessfully: false,
            errorMessage: response.error.message,
          ),
        );
        break;
    }
  }
}
