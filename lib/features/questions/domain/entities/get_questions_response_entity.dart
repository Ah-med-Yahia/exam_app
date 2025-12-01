import 'package:exam_app/features/questions/domain/entities/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';

class GetQuestionsResponseEntity {
  final List<QuestionEntity> questions;
  final ExamEntity exam;

  GetQuestionsResponseEntity({
    required this.questions,
    required this.exam,
  });
}