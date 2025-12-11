import 'package:exam_app/features/questions/data/models/answers_request_model/answers_request_model.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';

extension CheckAnswersRequestMapper on AnswersRequestEntity {
  AnswersRequestModel get toModel =>
      AnswersRequestModel(
        answers: answers.map((entity) => entity.toModel(entity)).toList(),
        time: time,
      );
}

extension AnswerCheckMapper on AnswerCheckEntity {
  AnswerCheckModel toModel(AnswerCheckEntity entity) =>
      AnswerCheckModel(questionId: entity.questionId, correct: entity.correct);
}
