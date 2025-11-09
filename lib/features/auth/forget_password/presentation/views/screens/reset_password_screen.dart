import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_events.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
            buildWhen: (previous, current) {
              return previous.hasUserInteracted!=current.hasUserInteracted ||
              previous.isFormValid!=current.isFormValid ||
              previous.resetPasswordState!=current.resetPasswordState;
            },
            listener: (context, state) {
              final resetState = state.resetPasswordState;
              if (resetState?.isLoading == true) {
                UIUtils.showLoadingMessage(
                  context: context,
                  loadingText: UiConstants.resetingPasswordLoadingMessage,
                );
              } else if (resetState?.data != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.successTitle,
                  message: resetState!.data!.message!,
                  posActionName: UiConstants.okButton,
                  posAction: () {
                    Navigator.pushReplacementNamed(context, Routes.home);
                  },
                );
              } else if (resetState?.errorMessage != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.failureTitle,
                  message: resetState!.errorMessage!,
                  negActionName: UiConstants.okButton,
                );
              }
            },
            builder: (context, state) {
              final bool hasApiError = state.resetPasswordState?.errorMessage != null;
              final bool hasFormError=state.hasUserInteracted==true &&
              state.isFormValid==false;
              final bool hasAnyError = hasApiError || hasFormError;
              Color labelColor;
              Color buttonColor;
              Color borderColor;
              String? errorText;
              if(state.hasUserInteracted==false){
                labelColor=ColorManager.darkGrey;
                buttonColor=ColorManager.blue;
                borderColor=ColorManager.black;
              }else{
                labelColor=hasAnyError?ColorManager.darkGrey:ColorManager.red;
                buttonColor=hasAnyError?ColorManager.blue:ColorManager.grey;
                borderColor=hasAnyError?ColorManager.red:ColorManager.black;
                errorText=!hasApiError?null:state.resetPasswordState!.errorMessage!;
              }
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: ColorManager.black),
                  ),
                  title: Text(
                    UiConstants.forgetPasswordHeadLine,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: Sizes.s18.sp,
                      fontFamily: GoogleFontsKeys.inter,
                    ),
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                    child: Column(
                      children: [
                        Text(
                          UiConstants.resetPasswordHeader,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: Sizes.s18.sp,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                        SizedBox(height: Sizes.s16.h),
                        Text(
                          UiConstants.resetPasswordInstructionsPart1,
                          style: getRegularStyle(
                            color: ColorManager.darkGrey,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                        Text(
                          UiConstants.resetPasswordInstructionsPart2,
                          style: getRegularStyle(
                            color: ColorManager.darkGrey,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                        Text(
                          UiConstants.resetPasswordInstructionsPart3,
                          style: getRegularStyle(
                            color: ColorManager.darkGrey,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                        SizedBox(height: Sizes.s32.h),
                        CustomTextFormField(
                          controller: _passwordController,
                          borderColor: borderColor,
                          label: UiConstants.newPasswordLabel,
                          labelColor: labelColor,
                          hintText: UiConstants.passwordHintText,
                          validator: Validator.validatePassword,
                          onChanged: (value) {
                            if(state.resetPasswordState?.errorMessage!=null){
                              context.read<ForgetPasswordCubit>().doIntent(ClearResetPasswordErrorEvent(), null, null, null);
                            }
                            if(state.isFormValid==false){
                              context.read<ForgetPasswordCubit>().doIntent(RefreshFormEvent(), null, null, null);
                            }
                          },
                        ),
                        SizedBox(height: Sizes.s16.h),
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          borderColor: borderColor,
                          label: UiConstants.confirmPasswordLabelAndHintText,
                          labelColor: labelColor,
                          hintText: UiConstants.confirmPasswordLabelAndHintText,
                          validator: (text) {
                            return Validator.validateConfirmPassword(
                              text,
                              _passwordController.text,
                            );
                          },
                          onChanged: (value) {
                            if(state.resetPasswordState?.errorMessage!=null){
                              context.read<ForgetPasswordCubit>().doIntent(ClearResetPasswordErrorEvent(), null, null, null);
                            }
                            if(state.isFormValid==false){
                              context.read<ForgetPasswordCubit>().doIntent(RefreshFormEvent(), null, null, null);
                            }
                          },
                        ),
                        if(errorText!=null) ...[
                          SizedBox(height: Sizes.s8.h),
                          Text(errorText,style: getRegularStyle(color: ColorManager.red,fontSize: Sizes.s13.sp,),),
                        ],
                        SizedBox(height: Sizes.s48.h),
                        CustomElevatedButton(
                          label: UiConstants.continueBut,
                          backgroundColor: buttonColor,
                          onTap: () {
                            if(state.hasUserInteracted==false){
                              final bool isValid=_formKey.currentState?.validate()==true;
                              context.read<ForgetPasswordCubit>().doIntent(UserInteractedEvent(), null, null, null);
                              context.read<ForgetPasswordCubit>().doIntent(UpdateFormValidationEvent(isValid: isValid), null, null, null);
                            }
                            if (_formKey.currentState?.validate() == true) {
                              final viewModel = context
                                  .read<ForgetPasswordCubit>();
                              viewModel.doIntent(
                                ResetPasswordEvent(),
                                email,
                                null,
                                _passwordController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
