import 'package:hive/hive.dart';

part 'check_answers_response_entity.g.dart';

@HiveType(typeId: 1)
class CheckAnswersResponseEntity {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final int correct;

  @HiveField(2)
  final int wrong;

  @HiveField(3)
  final String total;

  @HiveField(4)
  final List<WrongQuestionEntity> wrongQuestions;

  @HiveField(5)
  final List<CorrectQuestionEntity> correctQuestions;

  CheckAnswersResponseEntity({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });
}

@HiveType(typeId: 2)
class CorrectQuestionEntity {
  @HiveField(0)
  final String qid;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final String correctAnswer;

  CorrectQuestionEntity({
    required this.qid,
    required this.question,
    required this.correctAnswer,
  });
}

@HiveType(typeId: 3)
class WrongQuestionEntity {
  @HiveField(0)
  final String qid;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final String inCorrectAnswer;

  @HiveField(3)
  final String correctAnswer;

  WrongQuestionEntity({
    required this.qid,
    required this.question,
    required this.inCorrectAnswer,
    required this.correctAnswer,
  });
}
