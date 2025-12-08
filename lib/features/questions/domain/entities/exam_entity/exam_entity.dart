import 'package:hive/hive.dart';
part 'exam_entity.g.dart'; 

@HiveType(typeId: 4)
class ExamEntity extends HiveObject {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final int duration;
  
  @HiveField(2)
  final int numberOfQuestions;

  ExamEntity({
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
  });
}
