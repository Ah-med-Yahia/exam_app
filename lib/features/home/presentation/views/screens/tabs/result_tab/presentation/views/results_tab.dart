import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/cubit/result_event.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/cubit/result_tab_cubit.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/cubit/result_tab_state.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/views/widgets/exam_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ResultsTab extends StatefulWidget {
  const ResultsTab({super.key});

  @override
  State<ResultsTab> createState() => _ResultsTabState();
}

class _ResultsTabState extends State<ResultsTab> {
  late List<CachedExamResultEntity> results;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<ResultTabCubit>().doIntent(GetResultsHistoryEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              UiConstants.results,
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: FontSize.s22,
              ),
            ),
            SizedBox(height: 28.h),
            BlocListener<ResultTabCubit, ResultTabState>(
              listener: (context, state) {
                if (state.resultState?.isLoading == true) {
                  UIUtils.showEasyLoading();
                } else if (state.resultState?.errorMessage != null) {
                  UIUtils.hideEasyLoading();
                  UIUtils.showMessage(
                    state.resultState!.errorMessage!,
                    backGroundColor: ColorManager.red,
                    textColor: ColorManager.white,
                  );
                } else if (state.resultState?.data != null) {
                  UIUtils.hideEasyLoading();
                  results = state.resultState!.data;
                }
              },
              child: BlocBuilder<ResultTabCubit, ResultTabState>(
                builder: (context, state) {
                  if (state.resultState?.data != null) {
                    return results.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              itemCount: results.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (_, index) => ExamHistoryCard(
                                examEntity: results[index].exam,
                                numOfCorrectedAnswers: results[index]
                                    .answers
                                    .correct
                                    .toString(),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.answers,
                                    arguments: {
                                      'score': results[index].answers,
                                      'questions': results[index].questions,
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Lottie.asset(AnimationsAssets.empty),
                              Text(
                                UiConstants.noRsutlsYet,
                                style: getBoldStyle(
                                  color: ColorManager.blueAccent,
                                  fontSize: FontSize.s24,
                                ),
                              ),
                            ],
                          );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
