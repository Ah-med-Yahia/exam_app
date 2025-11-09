import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_events.dart';
import 'package:exam_app/features/auth/forget_password/presentation/cubit/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';


class VerifyResetCodeScreen extends StatelessWidget {
  VerifyResetCodeScreen({super.key});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
            listener: (context, state) {
              final verifyState = state.verifyResetCodeState;
              if (verifyState?.isLoading == true) {
                UIUtils.showLoadingMessage(
                  context: context,
                  loadingText: UiConstants.verifyingResetCodeLoadingMessage,
                );
              } else if (verifyState?.data != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.successTitle,
                  message: verifyState!.data!.status!,
                  posActionName: UiConstants.okButton,
                  posAction: () {
                      Navigator.pushNamed(
                        context,
                        Routes.resetPassword,
                        arguments: email,
                      );
                  },
                );
              } else if (verifyState?.errorMessage != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.failureTitle,
                  message: verifyState!.errorMessage!,
                  negActionName: UiConstants.okButton,
                );
              }
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
                );   
              } else if (forgotPasswordState?.errorMessage != null) {
                UIUtils.hideLoading(context);
                UIUtils.showMessageWithNav(
                  context: context,
                  title: UiConstants.failureTitle, 
                  message: forgotPasswordState!.errorMessage!,
                  negActionName: UiConstants.okButton
                );
              }
            },
            buildWhen: (previous, current) {
              return previous.verifyResetCodeState!=current.verifyResetCodeState;
            },
            builder: (context, state) {
              final verifyState = state.verifyResetCodeState;
              Color boxColor = ColorManager.blueGrey;
              Color borderColor = ColorManager.transparent;
              String? errorText;
              if (verifyState?.errorMessage != null) {
                borderColor = ColorManager.red;
                boxColor = ColorManager.white;
                errorText = verifyState!.errorMessage!;
              } else if (verifyState?.data != null) {
                boxColor = ColorManager.white;
              }
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.arrow_back_ios,color: ColorManager.black,)
                  ),
                  title: Text(
                    UiConstants.forgetPasswordHeadLine,
                    style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: 'inter'),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
                  child: Column(
                    children: [
                      Text(
                        UiConstants.emailVerificationHeader,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: Sizes.s18.sp,
                          fontFamily: GoogleFontsKeys.inter,
                        ),
                      ),
                      SizedBox(height: Sizes.s16.h),
                      Text(
                        UiConstants.enteringResetCodeInstructionsPart1,
                        style: getRegularStyle(
                          color: ColorManager.darkGrey,
                          fontFamily: GoogleFontsKeys.inter,
                        ),
                      ),
                      Text(
                        UiConstants.enteringResetCodeInstructionsPart2,
                        style: getRegularStyle(
                          color: ColorManager.darkGrey,
                          fontFamily: GoogleFontsKeys.inter,
                        ),
                      ),
                      SizedBox(height: Sizes.s32.h),
                      Pinput(
                        length: 6,
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        autofillHints: const [AutofillHints.oneTimeCode],
                        onChanged: (value) {
                          if(value.isNotEmpty && verifyState?.errorMessage!=null){
                            context.read<ForgetPasswordCubit>().doIntent(ClearVerifyResetCodeErrorEvent(), null, null, null);
                          }
                        },
                        defaultPinTheme: PinTheme(
                          width: Sizes.s37.w,
                          height: Sizes.s68.h,
                          textStyle: getSemiBoldStyle(
                            color: ColorManager.black,
                            fontSize: Sizes.s16.sp,
                          ),
                          decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(Sizes.s10.r),
                            border: Border.all(color: borderColor, width: Sizes.s2.w),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: Sizes.s37.w,
                          height: Sizes.s68.h,
                          textStyle: getSemiBoldStyle(
                            color: ColorManager.black,
                            fontSize: Sizes.s16.sp,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.blueGrey,
                            borderRadius: BorderRadius.circular(Sizes.s10.r),
                            border: Border.all(
                              color: verifyState?.errorMessage != null
                                  ? ColorManager.red
                                  : ColorManager.blue,
                              width: Sizes.s2.w,
                            ),
                          ),
                        ),
                        separatorBuilder: (index) {
                          if (index == 1 || index == 3) {
                            return SizedBox(width: Sizes.s20.w);
                          } else if (index == 5) {
                            return const SizedBox(width: 0);
                          } else {
                            return SizedBox(width: Sizes.s8.w);
                          }
                        },
                        onCompleted: (value) {
                          final viewModel = context.read<ForgetPasswordCubit>();
                          viewModel.doIntent(VerifyResetCodeEvent(), null, value, null);
                        },
                      ),
                      if (errorText != null) ...[
                        SizedBox(height: Sizes.s8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              errorText,
                              style: getRegularStyle(
                                color: ColorManager.red,
                                fontSize: Sizes.s13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: Sizes.s24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            UiConstants.receivingOTPQuestion,
                            style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: Sizes.s16.sp,
                              fontFamily: GoogleFontsKeys.inter,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final viewModel = context.read<ForgetPasswordCubit>();
                              viewModel.doIntent(ForgotPasswordEvent(), email, null, null);
                            },
                            child: Text(
                              UiConstants.resendOTP,
                              style:
                                  getRegularStyle(
                                    color: ColorManager.blue,
                                    fontSize: Sizes.s16.sp,
                                    fontFamily: GoogleFontsKeys.inter,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.blue,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
