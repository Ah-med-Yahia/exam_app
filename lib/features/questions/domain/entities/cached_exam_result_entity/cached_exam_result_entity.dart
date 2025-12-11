
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity/question_entity.dart';

class CachedExamResultEntity{
  ExamEntity exam;
  List<QuestionEntity> questions;
  CheckAnswersResponseEntity answers;
  
  CachedExamResultEntity({required this.answers,required this.exam,required this.questions});
}
