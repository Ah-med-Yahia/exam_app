class QuestionEntity {
  final List<AnswerEntity> answers;
  final String question;
  final KeyEntity correct;
  final String id;

  QuestionEntity({
    required this.answers,
    required this.question,
    required this.correct,
    required this.id,
  });
}

class AnswerEntity {
  final String answer;
  final KeyEntity key;

  AnswerEntity({required this.answer, required this.key});
}

enum KeyEntity { a1, a2, a3, a4 }
