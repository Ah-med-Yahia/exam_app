import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({super.key, required this.image, required this.isActive});

  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Insets.s5.h,
        horizontal: Insets.s8.w,
      ),
      decoration: BoxDecoration(
        color: isActive ? ColorManager.blue_10 : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset(
        colorFilter: ColorFilter.mode(isActive? ColorManager.blue:ColorManager.grey, BlendMode.srcIn),
        image,
        height: Sizes.s24.h,
        width: Sizes.s24.w,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
