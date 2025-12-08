import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity/question_entity.dart';
import 'package:hive/hive.dart';
part 'cached_exam_result_model.g.dart';

@HiveType(typeId: 9)
class CachedExamResultModel extends HiveObject{
  
  @HiveField(0)
  ExamEntity exam;
  
  @HiveField(1)
  List<QuestionEntity> questions;
  
  @HiveField(2)
  CheckAnswersResponseEntity answers;
  
  CachedExamResultModel({required this.answers,required this.exam,required this.questions});
}
