import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_events.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_states.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/views/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final ExploreTabCubit cubit=getIt<ExploreTabCubit>();

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExploreTabCubit>(
      create: (context) => cubit..doIntent(GetAllSubjectsEvent()),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Sizes.s24.h,),
                Text(UiConstants.surveyHeader,style: getMediumStyle(color: ColorManager.blue,fontSize: Sizes.s20.sp,fontFamily: GoogleFontsKeys.inter),),
                SizedBox(height: Sizes.s16.h,),
                _buildSearchField(),
                SizedBox(height: Sizes.s40.h,),
                Text(UiConstants.browsingText,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),
                SizedBox(height: Sizes.s24.h,),
                BlocBuilder<ExploreTabCubit,ExploreTabStates>(
                  builder: (context, state) {
                    final subjectsState=state.gettingAllSubjects;
                    final displayedSubjects = state.filteredSubjects ?? subjectsState?.data;
                    final searchQuery = state.searchQuery;
                    if(subjectsState?.data==null && subjectsState?.isLoading==false){
                      return Center(
                        child: Text(UiConstants.emptySubjects,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter),),
                      );
                    }else if (subjectsState?.errorMessage!=null && subjectsState?.isLoading==false){
                      return Center(
                        child: Text(subjectsState!.errorMessage!,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter)),
                      );
                    }else if(displayedSubjects!=null && subjectsState?.isLoading==false){
                      if(searchQuery.isNotEmpty && displayedSubjects.isEmpty){
                        return Center(
                          child: Text(UiConstants.misMatchSearchResults,style: getMediumStyle(color: ColorManager.black,fontSize: Sizes.s18.sp,fontFamily: GoogleFontsKeys.inter)),
                        );
                      }
                      return Column(
                        children: [
                          for (int i=0;i<displayedSubjects.length;i++) ...[
                            SubjectCard(
                              subjectEntity: displayedSubjects[i],
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.allExams);
                              },
                            ),
                            SizedBox(height: Sizes.s16.h,)
                          ]
                        ],
                      );
                    }else{
                      return Center(
                        child: CircularProgressIndicator(color: ColorManager.blue,),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(){
    return BlocBuilder<ExploreTabCubit,ExploreTabStates>(
      builder: (context, state) {
        return CustomTextFormField(
          radius: Sizes.s20.r,
          hintText:UiConstants.searchText,
          prefixIcon: Icon(Icons.search,color: ColorManager.darkGrey,),
          controller: _searchController,
          onChanged: (value) {
            final allSubjects = state.gettingAllSubjects?.data;
            if(allSubjects!=null){
              context.read<ExploreTabCubit>().doIntent(SearchSubjectsEvent(value, allSubjects));
            }
          },
        );
      },
    );
  }
}