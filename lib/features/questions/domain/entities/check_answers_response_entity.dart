
class CheckAnswersResponseEntity {
    final String message;
    final int correct;
    final int wrong;
    final String total;
    final List<WrongQuestionEntity> wrongQuestions;
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

class CorrectQuestionEntity {
    final String qid;
    final String question;
    final String correctAnswer;

    CorrectQuestionEntity({
        required this.qid,
        required this.question,
        required this.correctAnswer,
    });
}

class WrongQuestionEntity {
    final String qid;
    final String question;
    final String inCorrectAnswer;
    final String correctAnswer;

    WrongQuestionEntity({
        required this.qid,
        required this.question,
        required this.inCorrectAnswer,
        required this.correctAnswer,
    });
}
