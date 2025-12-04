import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/questions/domain/entities/get_questions_response_entity.dart';
import 'package:exam_app/features/questions/domain/repositories/get_questions_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetQuestionsUseCase {
  final GetQuestionsRepository repository;
  GetQuestionsUseCase({required this.repository});
  Future<BaseResponse<GetQuestionsResponseEntity>> call({
    required String examId,
  }) {
    return repository.getQuestions(examId: examId);
  }
}
