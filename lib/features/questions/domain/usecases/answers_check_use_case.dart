import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/answers_request_entity/answers_request_entity.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/answers_check_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnswersCheckUseCase {
  final AnswersCheckRepository repository;

  AnswersCheckUseCase({required this.repository});

  Future<BaseResponse<CheckAnswersResponseEntity>> call({
    required AnswersRequestEntity answers,
  }) {
    return repository.checkAnswers(answers: answers);
  }
}