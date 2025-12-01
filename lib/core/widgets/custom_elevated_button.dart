import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(343.w, 48.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: getMediumStyle(
          color: ColorManager.white,
          fontSize: Sizes.s16.sp,
          fontFamily: GoogleFontsKeys.roboto
        )
      ),
    );
  }
}
