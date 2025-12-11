sealed class GetQuestionsEvents {}

class QuestionsEvent extends GetQuestionsEvents {
  final String examId;
  QuestionsEvent(this.examId);
}
