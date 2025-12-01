import 'package:exam_app/features/questions/data/mappers/answers_mapper.dart';
import 'package:exam_app/features/questions/data/models/question_model/question_model.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';

extension QuestionsMapper on QuestionModel {
  QuestionEntity toEntity() => QuestionEntity(
    id: id,
    answers: answers.map((answerModel) => answerModel.toEntity()).toList(),
    question: question,
    correct: correct.toEntity(),
  );
}
