import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamHistoryCard extends StatelessWidget {
  final ExamEntity examEntity;
  final VoidCallback onTap;
  final String numOfCorrectedAnswers;
  const ExamHistoryCard({
    super.key,
    required this.examEntity,
    required this.onTap,
    required this.numOfCorrectedAnswers
  });

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: sizeScreen.height * .13,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(Sizes.s10.r),
          border: Border.all(color: ColorManager.grey),
          boxShadow: [
            BoxShadow(
              color: ColorManager.subjectCardShadowColor,
              blurRadius: Sizes.s8.r,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: Sizes.s10.h, right: 14.w),
          child: Row(
            children: [
              SizedBox(width: Sizes.s24.w),
              Image.asset(ImageAssets.examImage, fit: BoxFit.cover),
              SizedBox(width: Sizes.s8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              examEntity.title,
                              style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: Sizes.s16.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              examEntity.numberOfQuestions.toString() +
                                  UiConstants.questionsNumberText,
                              style: getRegularStyle(
                                color: ColorManager.darkGrey,
                                fontSize: Sizes.s13.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                            SizedBox(height: Sizes.s16.h),
                          ],
                        ),
                        Spacer(),
                        Text(
                          examEntity.duration.toString() +
                              UiConstants.minutesNumberText,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: Sizes.s14.sp,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$numOfCorrectedAnswers ',
                              style: getSemiBoldStyle(
                                color: ColorManager.blue,
                                fontSize: Sizes.s12.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                            TextSpan(
                              text: UiConstants.correctedAnswers,
                              style: getMediumStyle(
                                color: ColorManager.blue,
                                fontSize: Sizes.s12.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                            TextSpan(
                              text: examEntity.duration.toString(),
                              style: getSemiBoldStyle(
                                color: ColorManager.blue,
                                fontSize: Sizes.s12.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                            TextSpan(
                              text: UiConstants.minText,
                              style: getMediumStyle(
                                color: ColorManager.blue,
                                fontSize: Sizes.s12.sp,
                                fontFamily: GoogleFontsKeys.inter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
