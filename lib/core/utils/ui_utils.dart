import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showEasyLoading() {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.indicatorSize = 45.0;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.radius = 10.0;
    EasyLoading.instance.backgroundColor = ColorManager.blue;
    EasyLoading.instance.indicatorColor = Colors.white;
    EasyLoading.instance.textColor = Colors.white;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: UiConstants.loading);
  }

  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoadingIndicator()],
          ),
        ),
      ),
    ),
  );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();
  static void hideEasyLoading() => EasyLoading.dismiss();

  static void showMessage(
    String message, {
    required Color backGroundColor,
    required Color textColor,
  }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    textColor: textColor,
  );

  static void showMessageWithNav({
    required BuildContext context,
    String? title,
    required String message,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: getMediumStyle(color: ColorManager.black, fontSize: 18.sp),
          ),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: getMediumStyle(color: ColorManager.black, fontSize: 18.sp),
          ),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title ?? '',
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: Sizes.s18.sp,
          ),
        ),
        content: Text(
          message,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: Sizes.s18.sp,
          ),
        ),

        actions: actions,
      ),
    );
  }

  static void showLoadingMessage({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: ColorManager.blue),
            Text(
              loadingText,
              style: getSemiBoldStyle(
                color: ColorManager.blue,
                fontSize: Sizes.s16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
