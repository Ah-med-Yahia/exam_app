import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:exam_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:exam_app/features/auth/login/presentation/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = getIt<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                UiConstants.login,
                style: getMediumStyle(color: ColorManager.black, fontSize: 20),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        label: UiConstants.email,
                        hintText: UiConstants.emailHintText,
                        controller: _emailController,
                        validator: Validator.validateEmail,
                        onChanged: (value) {
                          loginCubit.doIntent(EmailChanged(value));
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        label: UiConstants.enterPassword,
                        hintText: UiConstants.enterPassword,
                        controller: _passwordController,
                        validator: Validator.validatePassword,
                        keyboardType: TextInputType.text,
                        onChanged: (value) =>
                            loginCubit.doIntent(PasswordChanged(value)),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                            height: 18.h,
                            width: 18.w,
                            child: BlocBuilder<LoginCubit, LoginStates>(
                              builder: (context, state) => Checkbox(
                                checkColor: ColorManager.white,
                                activeColor: ColorManager.black,
                                value: state.rememberMe,
                                onChanged: (_) =>
                                    loginCubit.doIntent(RememberMeToggled()),
                              ),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              UiConstants.rememberMe,
                              style: getRegularStyle(color: ColorManager.black),
                            ),
                            onPressed: () {
                              loginCubit.doIntent(RememberMeToggled());
                            },
                          ),
                          const Spacer(),
                          TextButton(
                            child: Text(
                              UiConstants.forgetPasswordHeadLine,
                              style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.black,
                                decorationThickness: 1.5,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(Routes.forgetPassword);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      BlocListener<LoginCubit, LoginStates>(
                        listenWhen: (previous, current) =>
                            previous.isLoading != current.isLoading ||
                            previous.data != current.data ||
                            previous.errorMessage != current.errorMessage,
                        listener: (context, state) {
                          if (state.isLoading) {
                            UIUtils.showLoading(context);
                          } else {
                            UIUtils.hideLoading(context);
                          }
                          if (state.data != null) {
                            UIUtils.showMessage(
                              UiConstants.loginSuccessful,
                              backGroundColor: ColorManager.green,
                              textColor: ColorManager.white,
                            );
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(Routes.home);
                          } else if (state.errorMessage != null &&
                              state.errorMessage!.isNotEmpty) {
                            UIUtils.showMessage(
                              state.errorMessage!,
                              backGroundColor: ColorManager.red,
                              textColor: ColorManager.white,
                            );
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginStates>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              label: UiConstants.login,
                              backgroundColor: state.isFormValid
                                  ? ColorManager.blue
                                  : ColorManager.grey,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  loginCubit.doIntent(
                                    LoginButtonPressed(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            UiConstants.dontHaveAccount,
                            style: getRegularStyle(color: ColorManager.black),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(
                              context,
                            ).pushReplacementNamed(Routes.register),
                            child: Text(
                              UiConstants.signUp,
                              style: getRegularStyle(
                                color: ColorManager.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.blue,
                                decorationThickness: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
