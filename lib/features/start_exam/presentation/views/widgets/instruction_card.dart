import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: Sizes.s10.w,),
        Icon(Icons.circle,color: ColorManager.darkGrey,size: Sizes.s12.sp,),
        SizedBox(width: Sizes.s10.w,),
        Text(UiConstants.instructionDetail,style: getMediumStyle(color: ColorManager.darkGrey,fontFamily: GoogleFontsKeys.inter),)
      ],
    );
  }
}