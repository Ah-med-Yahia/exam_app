import 'package:exam_app/features/questions/data/models/exam_model/exam_model.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity.dart';

extension ExamMapper on ExamModel {
  ExamEntity toEntity() => ExamEntity(
        duration: duration,
        title: title,
        numberOfQuestions: numberOfQuestions
      );
}