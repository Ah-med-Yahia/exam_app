import 'dart:developer';

import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';
import 'package:exam_app/features/questions/presentation/views/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswersScreen extends StatelessWidget {
  const AnswersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('message in  widget screen');
    Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    log('args:$args');
    final result = args['score'] as CheckAnswersResponseEntity;
    final correctQuestions = result.correctQuestions;
    final wrongQuestions = result.wrongQuestions;
    final questions = args['questions'] as List<QuestionEntity>;
    return Scaffold(
      appBar: AppBar(title: Text(UiConstants.answers)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView.separated(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final isCorrectQuestion = correctQuestions.any(
              (element) => element.qid == question.id,
            );
            final isWrongQuestion = wrongQuestions.any(
              (element) => element.qid == question.id,
            );
            final correctValue = isCorrectQuestion
                ? correctQuestions
                      .firstWhere((element) => element.qid == question.id)
                      .correctAnswer
                : wrongQuestions
                      .firstWhere((element) => element.qid == question.id)
                      .correctAnswer;
            final wrongValue = isWrongQuestion
                ? wrongQuestions
                      .firstWhere((element) => element.qid == question.id)
                      .inCorrectAnswer
                : null;
            final isEmptyQuestion = wrongValue == ' ';
            return SizedBox(
              height: size.height * .5,
              child: QuestionWidget(
                question: question,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: question.answers.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final value = question.answers[index].key.name
                        .toUpperCase();
                    final title = question.answers[index].answer;
                    return RadioGroup<String>(
                      onChanged: (value) {},
                      groupValue: isCorrectQuestion ? correctValue : wrongValue,
                      child: RadioListTile(
                        title: Text(
                          title,
                          style: getRegularStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s16,
                            fontFamily: GoogleFontsKeys.inter,
                          ),
                        ),
                        value: value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            color: value == correctValue
                                ? ColorManager.green
                                : isEmptyQuestion || value == wrongValue
                                ? ColorManager.red
                                : ColorManager.lightBlue,
                          ),
                        ),
                        enableFeedback: false,
                        enabled: false,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            if (isWrongQuestion) {
                              return ColorManager.red;
                            }
                            return ColorManager.green;
                          }
                          return (isEmptyQuestion && value != correctValue)
                              ? ColorManager.red
                              : value == correctValue
                              ? ColorManager.green
                              : ColorManager.blue;
                        }),
                        tileColor: value == correctValue
                            ? ColorManager.green.withValues(alpha: .1)
                            : isEmptyQuestion || value == wrongValue
                            ? ColorManager.red.withValues(alpha: .1)
                            : ColorManager.lightBlue,
                        toggleable: true,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: 24.h),
        ),
      ),
    );
  }
}
