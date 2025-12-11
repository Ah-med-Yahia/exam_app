import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/start_exam/domain/entities/exam_entity.dart';
import 'package:exam_app/features/start_exam/domain/repositories/start_exam_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class StartExamUseCase {
  final StartExamRepository startExamRepository;
  StartExamUseCase(this.startExamRepository);
  Future<BaseResponse<ExamEntity>> call(String id) async{
    return startExamRepository.getExamById(id);
  }
}