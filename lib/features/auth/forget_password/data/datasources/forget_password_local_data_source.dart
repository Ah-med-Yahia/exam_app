
import 'package:exam_app/config/base_response/base_response.dart';

abstract class ForgetPasswordLocalDataSource {
  Future<BaseResponse<void>> saveToken({required String token});
}