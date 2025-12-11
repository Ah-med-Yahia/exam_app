import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_events.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_states.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/views/widgets/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllExamsScreen extends StatelessWidget {
  AllExamsScreen({super.key});
  final ExploreTabCubit cubit=getIt<ExploreTabCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: ColorManager.black,)
        ),
        title:Text(UiConstants.allExamsHeader,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s20.sp,fontFamily: GoogleFontsKeys.inter),)
      ),
      body: BlocProvider<ExploreTabCubit>(
        create: (context) => cubit..doIntent(GetAllExamsEvent()),
        child: BlocBuilder<ExploreTabCubit,ExploreTabStates>(
          builder: (context, state) {
            final allExamsState=state.getAllExams;
            if(allExamsState?.errorMessage!=null && allExamsState?.isLoading==false){
              return Center(child: Text(allExamsState!.errorMessage!,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),);
            }else if(allExamsState?.data==null && allExamsState?.isLoading==false){
              return Center(child:Text(UiConstants.emptyExams,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),);
            }else if(allExamsState?.data!=null && allExamsState?.isLoading==false){
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                    child: ExamCard(
                      examEntity: allExamsState.data![index],
                      onTap: () {
                        Navigator.pushNamed(context, Routes.startExam,arguments: state.getAllExams?.data![index].id);
                      },
                    ),
                  );
                }, 
                separatorBuilder: (context, index) {
                  return SizedBox(height: Sizes.s16.h,);
                }, 
                itemCount: allExamsState!.data!.length
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