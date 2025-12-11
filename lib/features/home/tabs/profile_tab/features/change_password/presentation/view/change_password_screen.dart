import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/home/tabs/profile_tab/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:exam_app/features/home/tabs/profile_tab/features/change_password/presentation/cubit/change_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _currentPassword;
  late final TextEditingController _newPassword;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    super.initState();
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(UiConstants.resetPasswordHeader)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocListener<ChangePasswordCubit, ChangePasswordStates>(
            listener: (context, state) {
              if (state.errorMessage != null) {}
            },
            child: Form(
              key: _formKey,
              child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(
                      state.errorMessage!,
                      backGroundColor: ColorManager.red,
                      textColor: ColorManager.white,
                    );
                  }

                  if (state.isLoading == true) {
                    UIUtils.showLoading(context);
                  }
                  if (state.successMessage != null) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(
                      UiConstants.passwordUpdatedSuccessfully,
                      backGroundColor: ColorManager.green,
                      textColor: ColorManager.white,
                    );
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) => Column(
                  children: [
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      label: UiConstants.currentPassword,
                      hintText: UiConstants.currentPassword,
                      controller: _currentPassword,
                      validator: Validator.validatePassword,
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .doIntent(CurrentPasswordChanged(value)),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      label: UiConstants.newPassword,
                      hintText: UiConstants.newPassword,
                      controller: _newPassword,
                      validator: Validator.validatePassword,
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .doIntent(NewPasswordChanged(value)),
                    ),

                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      label: UiConstants.confirmPassword,
                      hintText: UiConstants.confirmPassword,
                      controller: _confirmPassword,
                      validator: (value) => Validator.validateConfirmPassword(
                        value,
                        _newPassword.text.trim(),
                      ),
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .doIntent(ConfirmPasswordChanged(value)),
                    ),
                    SizedBox(height: 40.h),

                    CustomElevatedButton(
                      label: UiConstants.updata,
                      backgroundColor: ColorManager.blue,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ChangePasswordCubit>().doIntent(
                            UpdateProfilePressed(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
