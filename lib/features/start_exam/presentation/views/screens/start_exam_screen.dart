import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_cubit.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_events.dart';
import 'package:exam_app/features/start_exam/presentation/cubit/start_exam_states.dart';
import 'package:exam_app/features/start_exam/presentation/views/widgets/instruction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StartExamScreen extends StatelessWidget {
  StartExamScreen({super.key});
  final StartExamCubit cubit=getIt<StartExamCubit>();
  @override
  Widget build(BuildContext context) {
    String id=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: ColorManager.black,)
        ),
      ),
      body: BlocProvider<StartExamCubit>(
        create: (context) => cubit..doIntent(GetExamEvent(), id),
        child: BlocBuilder<StartExamCubit,StartExamStates>(
          builder: (context, state) {
            final getExamState=state.getExamState;
            if(getExamState?.data==null && getExamState?.isLoading==false){
              return Center(child: Text(UiConstants.missingExamDetails,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),);
            }else if(getExamState?.errorMessage!=null && getExamState?.isLoading==false){
              return Center(child: Text(getExamState!.errorMessage!,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),);
            }else if(getExamState?.data!=null && getExamState?.isLoading==false){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(ImageAssets.examImage,width: Sizes.s42.w,height: Sizes.s47.h,),
                              Text(getExamState!.data!.title!,style: getSemiBoldStyle(color: ColorManager.black,fontSize: Sizes.s20.sp,fontFamily: GoogleFontsKeys.inter),),
                              Spacer(),
                              Text(getExamState.data!.duration.toString()+UiConstants.minutesNumberText,style: getRegularStyle(color: ColorManager.blue,fontSize: Sizes.s13.sp,fontFamily: GoogleFontsKeys.inter),)
                            ],
                          ),
                          SizedBox(height: Sizes.s8.h,),
                          Row(
                            children: [
                              Text(getExamState.data!.title!,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),
                              SizedBox(height: Sizes.s20.h, child: VerticalDivider(color: ColorManager.darkBlueGrey,)),
                              Text(getExamState.data!.numberOfQuestions.toString()+UiConstants.questionsNumberText,style: getRegularStyle(color: ColorManager.darkGrey,fontSize: Sizes.s16.sp,fontFamily: GoogleFontsKeys.inter),)
                            ],
                          ),
                          SizedBox(height: Sizes.s16.h,),
                        ],
                      ),
                    ),
                    Divider(color: ColorManager.darkBlueGrey,),
                    SizedBox(height: Sizes.s24.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(UiConstants.instructionsHeader,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter)),
                          SizedBox(height: Sizes.s16.h,),
                          InstructionCard(),
                          SizedBox(height: Sizes.s8.h,),
                          InstructionCard(),
                          SizedBox(height: Sizes.s8.h,),
                          InstructionCard(),
                          SizedBox(height: Sizes.s8.h,),
                          InstructionCard(),
                          SizedBox(height: Sizes.s48.h,),
                          CustomElevatedButton(
                            label: UiConstants.startText, 
                            backgroundColor: ColorManager.blue,
                            onTap:() {
                              
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(color: ColorManager.blue,),);
            }
          },
        ),
      ),
    );
  }
}