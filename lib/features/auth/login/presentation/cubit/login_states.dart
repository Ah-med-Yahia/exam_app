import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/Auth/login/domain/entites/login_entity.dart';

class LoginStates extends BaseState<LoginEntity> {
  final bool rememberMe;
  final bool isFormValid;

  const LoginStates({
    super.isLoading = false,
    super.data,
    super.errorMessage,
    this.rememberMe = false,
    this.isFormValid = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    data,
    errorMessage,
    rememberMe,
    isFormValid,
  ];

  LoginStates copyWith({
    LoginEntity? data,
    String? errorMessage,
    bool? isLoading,
    bool? isFormValid,
    bool? rememberMe,
  }) {
    return LoginStates(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormValid: isFormValid ?? this.isFormValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
