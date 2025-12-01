import 'package:exam_app/features/questions/data/models/check_answers_response_model/check_answers_response_model.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';

extension CheckAnswersResponseMapper on CheckAnswersResponseModel {
  CheckAnswersResponseEntity toEntity() {
    return CheckAnswersResponseEntity(
      message: message,
      correct: correct,
      wrong: wrong,
      total: total,
      wrongQuestions:
          wrongQuestions.map((model) => model.toEntity()).toList(),
      correctQuestions:
          correctQuestions.map((model) => model.toEntity()).toList(),
    );
  }
}

extension CorrectQuestionMapper on CorrectQuestionModel {
  CorrectQuestionEntity toEntity() {
    return CorrectQuestionEntity(
      qid: qid,
      question: question,
      correctAnswer: correctAnswer,
    );
  }
}

extension WrongQuestionMapper on WrongQuestionModel {
  WrongQuestionEntity toEntity() {
    return WrongQuestionEntity(
      qid: qid,
      question: question,
      inCorrectAnswer: inCorrectAnswer,
      correctAnswer: correctAnswer,
    );
  }
}