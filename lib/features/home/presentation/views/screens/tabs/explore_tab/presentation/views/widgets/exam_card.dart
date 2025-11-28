import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamCard extends StatelessWidget {
  final ExamEntity examEntity;
  final VoidCallback onTap;
  const ExamCard({super.key,required this.examEntity,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait=orientation==Orientation.landscape;
        return InkWell(
          onTap: onTap,
          child: Container(
            height:isPortrait? Sizes.s103.h:Sizes.s103.w,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(Sizes.s10.r),
              border: Border.all(color: ColorManager.grey),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.subjectCardShadowColor,
                  blurRadius: Sizes.s8.r
                )
              ]
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.only(top: Sizes.s10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Sizes.s24.w,
                  ),
                  Container(
                    width: Sizes.s60.w,
                    height: Sizes.s71.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageAssets.examImage,),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(
                    width: Sizes.s8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(examEntity.title!,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s16.sp,fontFamily: GoogleFontsKeys.inter),),
                      Text(examEntity.duration!.toString()+UiConstants.questionsNumberText,style: getRegularStyle(color: ColorManager.darkGrey,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter),),
                      SizedBox(
                        height: Sizes.s16.h,
                      ),
                      RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: UiConstants.fromText,
                            style: getRegularStyle(color: ColorManager.black,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter),
                          ),
                          TextSpan(
                            text: UiConstants.oneText,
                            style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter)
                          ),
                          TextSpan(
                            text: UiConstants.toText,
                            style: getRegularStyle(color: ColorManager.black,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter),
                          ),
                          TextSpan(
                            text: UiConstants.sixText,
                            style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter)
                          )
                        ]
                      ))
                    ],
                  ),
                  SizedBox(
                  width: Sizes.s32.w,
                  ),
                  Text(examEntity.duration!.toString()+UiConstants.minutesNumberText,style: getRegularStyle(color: ColorManager.blue,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter),)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}