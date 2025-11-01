import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
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
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              SizedBox(height: 15.h),
              CustomTextFormField(
                label: UiConstants.email,
                hintText: UiConstants.enterEmail,
                controller: _emailController,
                validator: Validator.validateEmail,
              ),
              SizedBox(height: 15.h),
              CustomTextFormField(
                label: UiConstants.passwordAppBarHeadLine,
                hintText: UiConstants.enterPassword,
                controller: _passwordController,
                validator: Validator.validatePassword,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SizedBox(
                    height: 18.h,
                    width: 18.w,
                    child: Checkbox(
                      checkColor: ColorManager.white,
                      activeColor: ColorManager.black,
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    child: Text(
                      UiConstants.rememberMe,
                      style: getRegularStyle(color: ColorManager.black),
                    ),
                    onPressed: () {
                      rememberMe = !rememberMe;
                      setState(() {});
                    },
                  ),
                  Spacer(),
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
                      Navigator.of(context).pushNamed(Routes.forgetPassword);
                    },
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              CustomElevatedButton(
                label: UiConstants.login,
                backgroundColor: ColorManager.blue,
                onTap: () {},
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    UiConstants.dontHaveAccount,
                    style: getRegularStyle(color: ColorManager.black),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.register),
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
    );
  }
}
