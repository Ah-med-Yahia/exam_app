import 'package:exam_app/features/questions/data/mappers/exam_mapper.dart';
import 'package:exam_app/features/questions/data/mappers/questions_mapper.dart';
import 'package:exam_app/features/questions/data/models/get_questions_response_model/get_questions_response_model.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';

extension GetQuestionsResponseMapper on GetQuestionsResponseModel {
  GetQuestionsResponseEntity toEntity() => GetQuestionsResponseEntity(
    questions: questions
        .map(
          (questionModel) =>questionModel.toEntity()
        )
        .toList(),

    exam: questions[0].exam.toEntity()
  );
}
