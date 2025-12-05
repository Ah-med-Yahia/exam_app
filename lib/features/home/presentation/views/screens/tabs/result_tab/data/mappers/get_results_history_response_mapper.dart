import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/data/models/get_results_history_response/get_results_history_response_model.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/domain/entities/get_results_history_response_entity.dart';

extension GetResultsHistoryResponseMapper on GetResultsHistoryResponseModel {
  GetResultsHistoryResponseEntity toEntity() {
    return GetResultsHistoryResponseEntity(
      message: message,
      history: history.toEntity(),
    );
  }
}


extension HistoryMapper on HistoryModel {
  HistoryEntity toEntity() {
    return HistoryEntity(
      id: id,
      checkAnswer: checkAnswer,
      questionInfo: qid.toEntity(),
      user: user,
      chosenAnswer: chosenAnswer,
      avgAnswerTime: avgAnswerTime,
    );
  }
}


extension QuestionMapper on QuestionModel {
  QuestionEntity toEntity() {
    return QuestionEntity(
      id: id,
      question: question,
      answers: answers.map((e) => e.toEntity()).toList(),
      type: type,
      correct: correct,
      subject: subject,
      exam: exam,
    );
  }
}

extension AnswerMapper on AnswerModel {
  AnswerEntity toEntity() {
    return AnswerEntity(
      answer: answer,
      key: key,
    );
  }
}