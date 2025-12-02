import 'dart:async';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/sounds_manager.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_cubit.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_event.dart';
import 'package:exam_app/features/questions/presentation/cubit/answer_cubit/answer_state.dart';
import 'package:exam_app/features/questions/presentation/cubit/get_questions_cubit/get_guestions_events.dart';
import 'package:exam_app/features/questions/presentation/cubit/get_questions_cubit/get_questions_cubit.dart';
import 'package:exam_app/features/questions/presentation/cubit/get_questions_cubit/get_questions_state.dart';
import 'package:exam_app/features/questions/presentation/views/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  PageController pageController = PageController();

  Timer? _timer;
  int _remainingSeconds = 5;

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetQuestionsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.doIntent(QuestionsEvent('6700707030a3c3c1944a9c5d'));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    SoundManager.disposeSoundPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(UiConstants.exam),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Insets.s16),
            child: BlocBuilder<GetQuestionsCubit, GetQuestionsStates>(
              builder: (context, state) {
                final cubitContext = context;
                if (state.questionsState?.data != null) {
                  final questions = state.questionsState!.data!;
                  return Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: ColorManager.blueAccent,
                        size: Sizes.s20,
                      ),
                      SizedBox(width: 9.h),
                      StatefulBuilder(
                        builder: (context, setTimerState) {
                          _timer ??= Timer.periodic(
                            const Duration(seconds: 1),
                            (timer) {
                              if (_remainingSeconds > 0) {
                                _remainingSeconds--;
                                setTimerState(() {});
                              } else {
                                timer.cancel();
                                SoundManager.playSound(
                                  SoundAssets.timeOutSound,
                                );
                                showDialog(
                                  context: cubitContext,
                                  barrierDismissible: false,
                                  builder: (_) => BlocProvider.value(
                                    value: cubitContext.read<AnswerCubit>(),
                                    child: PopScope(
                                      canPop: false,
                                      child: AlertDialog(
                                        backgroundColor: ColorManager.blueGrey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        content: Row(
                                          children: [
                                            Spacer(),
                                            SvgPicture.asset(
                                              IconsAssets.timeOutIcon,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              UiConstants.timeOut,
                                              style: getMediumStyle(
                                                color: ColorManager.red,
                                                fontSize: FontSize.s24,
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        actions: [
                                          BlocListener<
                                            AnswerCubit,
                                            AnswerState
                                          >(
                                            listener: (context, state) {
                                              if (state.scoreState?.isLoading ==
                                                  true) {
                                                UIUtils.showEasyLoading();
                                              } else if (state
                                                      .scoreState
                                                      ?.data !=
                                                  null) {
                                                UIUtils.hideEasyLoading();
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.score,
                                                  arguments: {
                                                    'score':
                                                        state.scoreState!.data!,
                                                    'questions': questions,
                                                  },
                                                );
                                              } else if (state
                                                      .scoreState
                                                      ?.errorMessage !=
                                                  null) {
                                                UIUtils.hideEasyLoading();
                                              }
                                            },
                                            child: CustomElevatedButton(
                                              label: UiConstants.viewScore,
                                              backgroundColor:
                                                  ColorManager.blue,
                                              size: Size(190.w, 40.h),
                                              onTap: () {
                                                context
                                                    .read<AnswerCubit>()
                                                    .doIntent(
                                                      CalculateScoreEvent(
                                                        answers: context
                                                            .read<AnswerCubit>()
                                                            .state
                                                            .answers,
                                                        time:
                                                            _remainingSeconds ~/
                                                            60,
                                                      ),
                                                    );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                          return Text(
                            _formatTime(_remainingSeconds),
                            style: getRegularStyle(
                              color: _remainingSeconds <= 300
                                  ? ColorManager.red
                                  : ColorManager.green,
                              fontSize: FontSize.s20,
                            ),
                          );
                        },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.s16),
        child: BlocListener<GetQuestionsCubit, GetQuestionsStates>(
          listener: (context, state) {
            if (state.questionsState?.isLoading == true) {
              UIUtils.showEasyLoading();
            } else if (state.questionsState?.errorMessage != null) {
              UIUtils.hideEasyLoading();
              UIUtils.showMessage(
                state.questionsState!.errorMessage!,
                backGroundColor: ColorManager.red,
                textColor: ColorManager.white,
              );
            } else {
              UIUtils.hideEasyLoading();
            }
          },
          child: BlocBuilder<GetQuestionsCubit, GetQuestionsStates>(
            builder: (context, state) {
              if (state.questionsState?.data != null) {
                final questions = state.questionsState!.data!;
                context.read<AnswerCubit>().doIntent(
                  InitializeAnswersEvent(questions: questions),
                );
                return Column(
                  children: [
                    SizedBox(height: 11.h),
                    BlocBuilder<AnswerCubit, AnswerState>(
                      builder: (context, state) {
                        final currentQuestion = state.currentQuestionIndex + 1;
                        return Column(
                          children: [
                            Text(
                              '${UiConstants.question} $currentQuestion ${UiConstants.of} ${questions.length}',
                              style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            LinearPercentIndicator(
                              lineHeight: 4.h,
                              percent: (currentQuestion) / questions.length,
                              backgroundColor: ColorManager.black_10,
                              progressColor: ColorManager.blue,
                              barRadius: Radius.circular(10.r),
                              padding: EdgeInsets.zero,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 300,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      flex: 3,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: questions.length,
                        onPageChanged: (value) async {
                          await Future.delayed(
                            const Duration(milliseconds: 700),
                          );
                          if (context.mounted) {
                            context.read<AnswerCubit>().nextQuestion(value);
                          }
                        },
                        itemBuilder: (context, index) =>
                            QuestionWidget(question: questions[index]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(343.w, 48.h),
                                side: BorderSide(color: ColorManager.blue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () async {
                                if (pageController.page!.toInt() == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: ColorManager.blueGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      title: Text(
                                        UiConstants.confirmExitFromExamTitle,
                                        style: getSemiBoldStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s24,
                                        ),
                                      ),
                                      content: Text(
                                        UiConstants.confirmExitFromExamMessage,
                                        style: getMediumStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s18,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            UiConstants.no,
                                            style: getSemiBoldStyle(
                                              color: ColorManager.blue,
                                              fontSize: FontSize.s14,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            UiConstants
                                                .confirmExitFromExamTitle,
                                            style:
                                                getSemiBoldStyle(
                                                  color: ColorManager.red,
                                                  fontSize: FontSize.s18,
                                                ).copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  await pageController.animateToPage(
                                    pageController.page!.toInt() - 1,
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeIn,
                                  );
                                  if (context.mounted) {
                                    context.read<AnswerCubit>().nextQuestion(
                                      pageController.page!.toInt(),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                UiConstants.back,
                                style: getMediumStyle(
                                  color: ColorManager.blue,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: BlocBuilder<AnswerCubit, AnswerState>(
                              builder: (context, state) {
                                final isLastQustion =
                                    state.currentQuestionIndex ==
                                    questions.length - 1;
                                return BlocListener<AnswerCubit, AnswerState>(
                                  listener: (context, state) {
                                    if (state.scoreState?.isLoading == true) {
                                      UIUtils.showEasyLoading();
                                    } else if (state.scoreState?.data != null) {
                                      UIUtils.hideEasyLoading();
                                      Navigator.pushNamed(
                                        context,
                                        Routes.score,
                                        arguments: {
                                          'score': state.scoreState!.data!,
                                          'questions': questions,
                                        },
                                      );
                                    } else if (state.scoreState?.errorMessage !=
                                        null) {
                                      UIUtils.hideEasyLoading();
                                    }
                                  },
                                  child: CustomElevatedButton(
                                    label: isLastQustion
                                        ? UiConstants.finish
                                        : UiConstants.next,
                                    backgroundColor: ColorManager.blue,
                                    radius: 10.r,
                                    onTap: () async {
                                      if (questions.length - 1 ==
                                          pageController.page!.toInt()) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            backgroundColor:
                                                ColorManager.blueGrey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                            ),
                                            title: Text(
                                              UiConstants.finished,
                                              style: getSemiBoldStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s24,
                                              ),
                                            ),
                                            content: Text(
                                              UiConstants.finishedMessage,
                                              style: getMediumStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s18,
                                              ),
                                            ),
                                            actions: [
                                              CustomElevatedButton(
                                                label: UiConstants.viewScore,
                                                backgroundColor:
                                                    ColorManager.blue,
                                                onTap: () {
                                                  context
                                                      .read<AnswerCubit>()
                                                      .doIntent(
                                                        CalculateScoreEvent(
                                                          answers:
                                                              state.answers,
                                                          time:
                                                              _remainingSeconds ~/
                                                              60,
                                                        ),
                                                      );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        await pageController.animateToPage(
                                          pageController.page!.toInt() + 1,
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                          curve: Curves.easeIn,
                                        );
                                        if (context.mounted) {
                                          context
                                              .read<AnswerCubit>()
                                              .nextQuestion(
                                                state.currentQuestionIndex + 1,
                                              );
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
