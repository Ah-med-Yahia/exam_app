import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    appBarTheme: AppBarTheme(
      titleTextStyle: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
        fontFamily: GoogleFontsKeys.inter,
      ),
      iconTheme: IconThemeData(color: ColorManager.black),
      backgroundColor: ColorManager.white,
    ),
  );
}
