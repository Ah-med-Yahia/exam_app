import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/models/exam_dto.dart';

abstract class GetAllExamsRemoteDataSource {
    Future<BaseResponse<List<ExamDTO>>> getAllExams(String token);
}