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

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
            buildWhen: (previous, current) {
              return previous.forgetPasswordState!=current.forgetPasswordState ||
              previous.hasUserInteracted!=current.hasUserInteracted ||
              previous.isFormValid!=current.isFormValid;
            },
            listener: (context, state) {
              final forgotPasswordState = state.forgetPasswordState;
              if (forgotPasswordState?.isLoading == true) {
                UIUtils.showLoadingMessage(
                  context: context,
                  loadingText: UiConstants.sendingResetCodeLoadingMessage,
                );
              } else if (forgotPasswordState?.data != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.successTitle,
                  message: forgotPasswordState!.data!.info!,
                  posActionName: UiConstants.okButton,
                  posAction: () {
                    Navigator.pushNamed(
                      context,
                      Routes.verifyResetCode,
                      arguments: _emailController.text,
                    );
                  },
                );
              } else if (forgotPasswordState?.errorMessage != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.failureTitle,
                  message: forgotPasswordState!.errorMessage!,
                  negActionName: UiConstants.okButton,
                );
              }
            },
            builder: (context, state) {
              final bool hasApiError = state.forgetPasswordState?.errorMessage != null;
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
                labelColor=hasAnyError?ColorManager.red:ColorManager.darkGrey;
                buttonColor=hasAnyError?ColorManager.grey:ColorManager.blue;
                borderColor=hasAnyError?ColorManager.red:ColorManager.black;
                errorText=!hasApiError?null:state.forgetPasswordState!.errorMessage!;
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
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
                      child: Column(
                        children: [
                          Text(
                            UiConstants.forgetPasswordHeadLine,
                            style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: Sizes.s18.sp,
                              fontFamily: GoogleFontsKeys.inter,
                            ),
                          ),
                          SizedBox(height: Sizes.s16.h),
                          Text(
                            UiConstants.providingEmailMessage,
                            style: getRegularStyle(
                              color: ColorManager.darkGrey,
                              fontFamily: GoogleFontsKeys.inter,
                            ),
                          ),
                          Text(
                            UiConstants.providingEmailMessagePart2,
                            style: getRegularStyle(
                              color: ColorManager.darkGrey,
                              fontFamily: GoogleFontsKeys.inter,
                            ),
                          ),
                          SizedBox(height: Sizes.s24.h),
                          CustomTextFormField(
                            controller: _emailController,
                            borderColor: borderColor,
                            label: UiConstants.emailLabel,
                            labelColor: labelColor,
                            hintText: UiConstants.emailHintText,
                            validator: Validator.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              if(state.forgetPasswordState?.errorMessage!=null){
                                context.read<ForgetPasswordCubit>().doIntent(ClearForgetPasswordStateEvent(), null, null, null);
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
                                  ForgotPasswordEvent(),
                                  _emailController.text,
                                  null,
                                  null,
                                );
                              }
                            },
                          ),
                        ],
                      ),
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
