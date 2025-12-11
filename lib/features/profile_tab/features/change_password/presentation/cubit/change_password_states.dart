part of 'change_password_cubit.dart';

class ChangePasswordStates extends BaseState<ChangePasswordResponse> {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  final bool isUpdatedSuccessfully;
  final bool isFormValid;
  final bool? clearSuccess;
  final String? successMessage;

  const ChangePasswordStates({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isUpdatedSuccessfully = false,
    this.isFormValid = false,
    super.data,
    super.errorMessage,
    super.isLoading = false,
    this.successMessage,
    this.clearSuccess,
  });

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmPassword,
    isLoading,
    isUpdatedSuccessfully,
    isFormValid,
    data,
    errorMessage,
    successMessage,
    clearSuccess,
  ];

  ChangePasswordStates copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,

    bool? isUpdatedSuccessfully,
    bool? isFormValid,
    bool? isLoading,

    ChangePasswordResponse? data,
    bool clearData = false,

    String? errorMessage,
    bool clearError = false,

    String? successMessage,
    bool clearSuccess = false,
  }) {
    return ChangePasswordStates(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,

      isUpdatedSuccessfully:
          isUpdatedSuccessfully ?? this.isUpdatedSuccessfully,

      isFormValid: isFormValid ?? this.isFormValid,

      isLoading: isLoading ?? this.isLoading,

      data: clearData ? null : (data ?? this.data),

      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),

      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}
