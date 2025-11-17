import 'package:exam_app/config/base_response/base_response.dart';

abstract class ExploreTabLocalDataSource {
  Future<BaseResponse<String>> getToken({required String token});
}