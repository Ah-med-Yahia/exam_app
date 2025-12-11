import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectCard extends StatelessWidget {
  final VoidCallback onPressed;
  final SubjectEntity subjectEntity;
  const SubjectCard({super.key,required this.subjectEntity,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: Sizes.s80.h,
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
        child: Row(
          children: [
            SizedBox(width: Sizes.s22.w,),
            CachedNetworkImage(
              imageUrl: subjectEntity.icon!,
              imageBuilder: (context, imageProvider) => Container(
                height: Sizes.s48.h,
                width: Sizes.s48.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover
                  )
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: ColorManager.blue,),),
              errorWidget: (context, url, error) => Icon(Icons.error,color: ColorManager.red,),
            ),
            SizedBox(width: Sizes.s8.w,),
            Text(subjectEntity.name!,style: getRegularStyle(color: ColorManager.black_0,fontSize: Sizes.s16.sp,fontFamily: GoogleFontsKeys.inter),)
          ],
        ),
      ),
    );
  }
}