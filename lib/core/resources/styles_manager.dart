import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:exam_app/core/resources/font_managar.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color, {
  required String fontFamily,
}) {
  switch (fontFamily.toLowerCase()) {
    case 'poppins':
      return GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    case 'roboto':
      return GoogleFonts.roboto(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    case 'cairo':
      return GoogleFonts.cairo(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
      case 'inter':
      return GoogleFonts.inter(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    default:
      return GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
  }
}

TextStyle getLightStyle({
  double? fontSize,
  required Color color,
  String fontFamily='roboto',
}) => _getTextStyle(
  fontSize ?? FontSize.s14.sp,
  FontWeightManager.light,
  color,
  fontFamily: fontFamily,
);

TextStyle getRegularStyle({
  double? fontSize,
  required Color color,
  String fontFamily='roboto',
}) => _getTextStyle(
  fontSize ?? FontSize.s14.sp,
  FontWeightManager.regular,
  color,
  fontFamily: fontFamily,
);

TextStyle getMediumStyle({
  double? fontSize,
  required Color color,
  String fontFamily='roboto',
}) => _getTextStyle(
  fontSize ?? FontSize.s14.sp,
  FontWeightManager.medium,
  color,
  fontFamily: fontFamily,
);

TextStyle getSemiBoldStyle({
  double? fontSize,
  required Color color,
  String fontFamily='roboto',
}) => _getTextStyle(
  fontSize ?? FontSize.s14.sp,
  FontWeightManager.semiBold,
  color,
  fontFamily: fontFamily,
);

TextStyle getBoldStyle({
  double? fontSize,
  required Color color,
  String fontFamily='roboto',
}) => _getTextStyle(
  fontSize ?? FontSize.s14.sp,
  FontWeightManager.bold,
  color,
  fontFamily: fontFamily,
);
