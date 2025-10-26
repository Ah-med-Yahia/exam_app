import 'package:exam_app/core/resources/font_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);

TextStyle getLightStyle({double? fontSize, required Color color}) =>
    _getTextStyle(fontSize ?? FontSize.s14.sp, FontWeightManager.light, color);

TextStyle getRegularStyle({double? fontSize, required Color color}) =>
    _getTextStyle(
      fontSize ?? FontSize.s14.sp,
      FontWeightManager.regular,
      color,
    );

TextStyle getMediumStyle({double? fontSize, required Color color}) =>
    _getTextStyle(fontSize ?? FontSize.s14.sp, FontWeightManager.medium, color);

TextStyle getSemiBoldStyle({double? fontSize, required Color color}) =>
    _getTextStyle(
      fontSize ?? FontSize.s14.sp,
      FontWeightManager.semiBold,
      color,
    );

TextStyle getBoldStyle({double? fontSize, required Color color}) =>
    _getTextStyle(fontSize ?? FontSize.s14.sp, FontWeightManager.bold, color);
