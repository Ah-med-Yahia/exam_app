import 'package:exam_app/features/questions/data/models/question_model/question_model.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity.dart';

extension AnswersMapper on AnswerModel {
  AnswerEntity toEntity() => AnswerEntity(
        answer: answer,
        key: key.toEntity(),
      );
}

extension KeyMapper on KeyModel {
  KeyEntity toEntity() {
    switch (this) {
      case KeyModel.a1:
        return KeyEntity.a1;
      case KeyModel.a2:
        return KeyEntity.a2;
      case KeyModel.a3:
        return KeyEntity.a3;
      case KeyModel.a4:
        return KeyEntity.a4;
    }
  }
}