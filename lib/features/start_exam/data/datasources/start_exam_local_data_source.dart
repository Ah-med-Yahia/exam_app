import 'package:exam_app/config/base_response/base_response.dart';

abstract class StartExamLocalDataSource {
  Future<BaseResponse<String>> getToken();
}