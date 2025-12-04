import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/answers_check_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CacheAnswersUseCase {
  final AnswersCheckRepository repository;

  CacheAnswersUseCase({required this.repository});

  Future<BaseResponse<void>> call({
    required String examId,
    required CheckAnswersResponseEntity answers,
  }) {
    return repository.cacheAnswers(examId, answers);
  }
}