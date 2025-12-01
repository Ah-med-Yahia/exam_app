import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';
import 'package:exam_app/features/questions/presentation/views/widgets/answers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
  });

  final QuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: getMediumStyle(
              color: ColorManager.black,
              fontSize: FontSize.s20,
              fontFamily: GoogleFontsKeys.inter,
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: AnswersWidget(
              answers: question.answers,
              questionId: question.id,
            ),
          ),
        ],
      ),
    );
  }
}
