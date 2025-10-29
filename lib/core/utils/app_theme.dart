import 'package:exam_app/core/resources/color_managar.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: ColorManager.black
      )
    )
  );
}