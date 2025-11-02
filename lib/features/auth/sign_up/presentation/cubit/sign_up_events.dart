import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:flutter/material.dart';

sealed class SignUpEvents {}

class SignUpEvent extends SignUpEvents {
  final SignUpRequestEntity request;
  SignUpEvent(this.request);
}

class CheckButtonValidation extends SignUpEvents {
  final TextEditingController userNameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  CheckButtonValidation(
    this.userNameController,
    this.firstNameController,
    this.lastNameController,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    this.phoneController,
  );
}
