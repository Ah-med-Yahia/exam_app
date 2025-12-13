import 'package:hive/hive.dart';

part 'question_entity.g.dart'; 

@HiveType(typeId: 6)
class QuestionEntity extends HiveObject {
  @HiveField(0)
  final List<AnswerEntity> answers;
  
  @HiveField(1)
  final String question;
  
  @HiveField(2)
  final KeyEntity correct;
  
  @HiveField(3)
  final String id;

  QuestionEntity({
    required this.answers,
    required this.question,
    required this.correct,
    required this.id,
  });
}

@HiveType(typeId: 7)
class AnswerEntity {
  @HiveField(0)
  final String answer;
  
  @HiveField(1)
  final KeyEntity key;

  AnswerEntity({required this.answer, required this.key});
}

@HiveType(typeId: 8)
enum KeyEntity {
  @HiveField(0)
  a1,
  
  @HiveField(1)
  a2,
  
  @HiveField(2)
  a3,
  
  @HiveField(3)
  a4,
  @HiveField(4)
  a5,
}