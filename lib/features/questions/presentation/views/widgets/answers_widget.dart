import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/sounds_manager.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_cubit.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswersWidget extends StatelessWidget {
  final List<AnswerEntity> answers;
  final String questionId;

  const AnswersWidget({
    super.key,
    required this.answers,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnswerCubit, AnswerState>(
      builder: (context, answersMap) {
        final index = answersMap.answers.indexWhere(
          (e) => e.questionId == questionId,
        );
        final selectedValue = answersMap.answers[index].correct == ' '
            ? null
            : KeyEntity.values.byName(
                answersMap.answers[index].correct.toLowerCase(),
              );

        return RadioGroup<KeyEntity>(
          groupValue: selectedValue,
          onChanged: (value) {
            SoundManager.playSound(SoundAssets.selectClickSound);
            context.read<AnswerCubit>().selectAnswer(questionId, value);
          },
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: answers.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final ans = answers[index];
              return RadioListTile(
                title: Text(
                  ans.answer,
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                    fontFamily: GoogleFontsKeys.inter,
                  ),
                ),
                value: ans.key,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                enableFeedback: true,
                fillColor: WidgetStatePropertyAll(ColorManager.blue),
                tileColor: selectedValue == answers[index].key
                    ? ColorManager.blue_10
                    : ColorManager.lightBlue,
                toggleable: true,
              );
            },
          ),
        );
      },
    );
  }
}
