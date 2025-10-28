import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
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

  static void showMessage(String message) =>
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  static void showMessageWithNav({required BuildContext context,String? title,required String message,String? posActionName,Function? posAction,String? negActionName,Function? negAction}){
    List<Widget>? actions=[];
    if(posActionName!=null){
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          posAction?.call();
        }, 
        child: Text(posActionName,style: getMediumStyle(color: ColorManager.black,fontSize: 18.sp),)
      )
      );
    }
    if(negActionName!=null){
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negAction?.call();
        }, 
        child: Text(negActionName,style: getMediumStyle(color: ColorManager.black,fontSize: 18.sp),)
      )
      );
    }
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title?? '',style: getMediumStyle(color: ColorManager.black,fontSize: 18.sp),),
        content: Text(message,style: getMediumStyle(color: ColorManager.black,fontSize: 18.sp),),
        actions: actions,
      ),
    );
  }
}
