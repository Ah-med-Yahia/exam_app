import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_events.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();

    void validate() {
      cubit.doIntent(
        CheckButtonValidation(
          userNameController,
          firstNameController,
          lastNameController,
          emailController,
          passwordController,
          confirmPasswordController,
          phoneController,
        ),
      );
    }

    userNameController.addListener(validate);
    firstNameController.addListener(validate);
    lastNameController.addListener(validate);
    emailController.addListener(validate);
    passwordController.addListener(validate);
    confirmPasswordController.addListener(validate);
    phoneController.addListener(validate);
  }

  @override
  void dispose() {
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(UiConstants.signUp),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Insets.s16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  label: UiConstants.userName,
                  hintText: UiConstants.enterUserName,
                  controller: userNameController,
                  validator: (value) {
                    return Validator.validateUsername(value);
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: UiConstants.firstName,
                        hintText: UiConstants.enterFirstName,
                        controller: firstNameController,
                        validator: (value) {
                          return Validator.validateFirstName(value);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextFormField(
                        label: UiConstants.lastName,
                        hintText: UiConstants.enterLastName,
                        controller: lastNameController,
                        validator: (value) {
                          return Validator.validateLastName(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  label: UiConstants.email,
                  hintText: UiConstants.enterEmail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: UiConstants.password,
                        hintText: UiConstants.enterPassword,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          return Validator.validatePassword(value);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextFormField(
                        label: UiConstants.confirmPassword,
                        hintText: UiConstants.enterConfirmPassword,
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          return Validator.validateConfirmPassword(
                            value,
                            passwordController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  label: UiConstants.phoneNumber,
                  hintText: UiConstants.enterPhoneNumber,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return Validator.validatePhoneNumber(value);
                  },
                ),
                SizedBox(height: 20.h),
                BlocConsumer<SignUpCubit, SignUpStates>(
                  listener: (context, state) {
                    if (state.signUpState?.isLoading == true) {
                      UIUtils.showLoading(context);
                    } else if (state.signUpState?.errorMessage != null) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(
                        state.signUpState!.errorMessage!,
                        backGroundColor: ColorManager.red,
                        textColor: ColorManager.white,
                      );
                    } else if ((state.signUpState?.isLoading == false) &&
                        state.signUpState?.data != null &&
                        state.signUpState!.data!.isNotEmpty) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(
                        state.signUpState!.data!,
                        backGroundColor: ColorManager.green,
                        textColor: ColorManager.white,
                      );
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      label: UiConstants.signUp,
                      backgroundColor: state.isFormValid
                          ? ColorManager.blue
                          : ColorManager.grey,
                      onTap: state.isFormValid
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignUpCubit>().doIntent(
                                  SignUpEvent(
                                    SignUpRequestEntity(
                                      email: emailController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      username: userNameController.text,
                                      password: passwordController.text,
                                      rePassword:
                                          confirmPasswordController.text,
                                      phone: phoneController.text,
                                    ),
                                  ),
                                );
                              }
                            }
                          : () {},
                    );
                  },
                ),

                SizedBox(height: 10.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: UiConstants.alreadyHaveAccount,
                      style: getRegularStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s16,
                        fontFamily: GoogleFontsKeys.inter,
                      ),
                      children: [
                        TextSpan(
                          text: UiConstants.login,
                          style: getRegularStyle(
                            color: ColorManager.blue,
                            fontSize: FontSize.s16,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Login screen
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
