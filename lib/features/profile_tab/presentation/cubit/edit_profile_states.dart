import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/profile_tab/data/models/edit_profile_response/edit_profile_response.dart';

class EditProfileStates extends BaseState<EditProfileResponse> {
  final bool isFormValid;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? successMessage;
  final String? profileImagePath;
  final bool isUpdatedSuccessfully;
  final bool isDataLoaded;
  final bool messageShown;

  const EditProfileStates( {
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.profileImagePath,
    this.isFormValid = false,
    this.isUpdatedSuccessfully = false,
    this.isDataLoaded = false,
    super.isLoading = false,
    super.data,
    super.errorMessage,
    this.successMessage,
    this.messageShown = false,
  });

  @override
  List<Object?> get props => [
    username,
    firstName,
    lastName,
    email,
    phone,
    profileImagePath,
    isFormValid,
    isUpdatedSuccessfully,
    isDataLoaded,
    isLoading,
    data,
    errorMessage,
    successMessage,
    messageShown
  ];

  EditProfileStates copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? profileImagePath,
    String? successMessage,
    EditProfileResponse? data,
    bool clearData = false,
    String? errorMessage,
    bool clearError = false,
    bool? isLoading,
    bool? isFormValid,
    bool? isUpdatedSuccessfully,
    bool? isDataLoaded,
    bool clearSuccess = false,
     bool? messageShown
  }) {
    return EditProfileStates(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isDataLoaded: isDataLoaded ?? this.isDataLoaded,
      data: clearData ? null : (data ?? this.data),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      isUpdatedSuccessfully:
          isUpdatedSuccessfully ?? this.isUpdatedSuccessfully,
          messageShown: messageShown ?? this.messageShown
    );
  }
}
