class GetResultsHistoryResponseEntity {
    final String message;
    final HistoryEntity history;

    GetResultsHistoryResponseEntity({
        required this.message,
        required this.history,
    });
}

class HistoryEntity {
    final String id;
    final String checkAnswer;
    final QuestionEntity questionInfo;
    final String user;
    final String chosenAnswer;
    final String avgAnswerTime;

    HistoryEntity({
        required this.id,
        required this.checkAnswer,
        required this.questionInfo,
        required this.user,
        required this.chosenAnswer,
        required this.avgAnswerTime,
    });
}

class QuestionEntity {
    final String id;
    final String question;
    final List<AnswerEntity> answers;
    final String type;
    final String correct;
    final String subject;
    final String exam;

    QuestionEntity({
        required this.id,
        required this.question,
        required this.answers,
        required this.type,
        required this.correct,
        required this.subject,
        required this.exam,
    });
}

class AnswerEntity {
    final String answer;
    final String key;

    AnswerEntity({
        required this.answer,
        required this.key,
    });
}
