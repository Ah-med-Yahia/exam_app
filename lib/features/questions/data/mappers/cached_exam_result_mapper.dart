import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';

extension CachedExamResultMapper on CachedExamResultEntity {
  CachedExamResultModel get toModel =>
      CachedExamResultModel(answers: answers, exam: exam, questions: questions);
}
