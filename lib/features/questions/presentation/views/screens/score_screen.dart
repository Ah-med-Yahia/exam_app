import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/sounds_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late CheckAnswersResponseEntity result;
  late String examId;
  late String total;
  late ConfettiController _confettiController;
  late Size screenSize;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    screenSize = MediaQuery.of(context).size;
    result = args['score'] as CheckAnswersResponseEntity;
    examId = args['examId'] as String;
    total = double.parse(
      result.total.replaceAll('%', ''),
    ).toStringAsFixed(2);

    double number = double.tryParse(total) ?? 0;
    if (!_hasInitialized) {
      SoundManager.playSound(
        number >= 50 ? SoundAssets.success : SoundAssets.faliure,
      );
      if (number >= 50) {
        _confettiController.play();
      }
      _hasInitialized = true;
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.home,
                  (route) => false,
                );
              },
              icon: Icon(Icons.home_max, color: ColorManager.blue),
            ),
            title: const Text(UiConstants.examScore),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: Insets.s16,
              right: Insets.s16,
              top: Insets.s40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiConstants.yourScore,
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontFamily: GoogleFontsKeys.inter,
                    fontSize: FontSize.s18,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 5,
                      percent: result.correct / (result.wrong + result.correct),
                      center: Text(
                        '$total %',
                        style: getMediumStyle(
                          color: Colors.black,
                          fontSize: FontSize.s20,
                        ),
                      ),
                      progressColor: ColorManager.blue,
                      backgroundColor: ColorManager.red,
                    ),
                    Spacer(flex: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UiConstants.correct,
                          style: getMediumStyle(
                            color: ColorManager.blue,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        SizedBox(height: 11.h),
                        Text(
                          UiConstants.incorrect,
                          style: getMediumStyle(
                            color: ColorManager.red,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 2),
                    Column(
                      children: [
                        Container(
                          width: 25.w,
                          height: 25.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorManager.blue),
                          ),
                          child: Text(
                            result.correct.toString(),
                            style: getMediumStyle(
                              color: ColorManager.blue,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 25.w,
                          height: 25.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorManager.red),
                          ),
                          child: Text(
                            result.wrong.toString(),
                            style: getMediumStyle(
                              color: ColorManager.red,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 1),
                CustomElevatedButton(
                  label: UiConstants.showResults,
                  labelStyle: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s16,
                  ),
                  backgroundColor: ColorManager.blue,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.answers,
                      arguments: {
                        'score': result,
                        'examId': examId,
                        'questions':
                            (ModalRoute.of(context)!.settings.arguments
                                as Map)['questions'],
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  label: UiConstants.startAgain,
                  labelStyle: getMediumStyle(
                    color: ColorManager.blue,
                    fontSize: FontSize.s16,
                  ),
                  border: BorderSide(color: ColorManager.blue),
                  backgroundColor: ColorManager.white,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.questions,
                      arguments: examId,
                    );
                  },
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality
                .explosive, // This spreads confetti in all directions
            numberOfParticles: 60,
            colors: [ColorManager.blue, ColorManager.green, Colors.yellow],
            emissionFrequency: 0.05,
            maxBlastForce: 20, // Increased force to reach further
            minBlastForce: 5,
            gravity: 0.1, // Lower gravity so particles travel further
          ),
        ),
      ],
    );
  }
}
