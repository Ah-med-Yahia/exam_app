import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/cached_exam_result_entity/cached_exam_result_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/answers_check_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CacheAnswersUseCase {
  final AnswersCheckRepository repository;

  CacheAnswersUseCase({required this.repository});

  Future<BaseResponse<void>> call({
    required CachedExamResultEntity result
  }) {
    return repository.cacheAnswers(result);
  }
}