import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordLocalDataSource)
class ForgetPasswordLocalDataSourceImpl implements ForgetPasswordLocalDataSource{
  final Box<String> tokenBox;
  ForgetPasswordLocalDataSourceImpl({required this.tokenBox});
  @override
  Future<BaseResponse<void>> saveToken({required String token,}) async{
     try {
      await tokenBox.put(CacheConstants.tokenKey, token);
      return SuccessResponse<void>(data: null);
    } catch (e) {
      return ErrorResponse<void>(error: LocalException(message: 'Falied to save user locally'));
    }
  }
}