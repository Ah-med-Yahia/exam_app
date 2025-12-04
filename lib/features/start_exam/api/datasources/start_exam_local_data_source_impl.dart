import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/start_exam/data/datasources/start_exam_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: StartExamLocalDataSource)
class StartExamLocalDataSourceImpl implements StartExamLocalDataSource{
  final Box<String> tokenBox;
  StartExamLocalDataSourceImpl({required this.tokenBox});
  @override
  Future<BaseResponse<String>> getToken() async{
    try{
      String? token= tokenBox.get(CacheConstants.tokenKey);
      return SuccessResponse<String>(data:token!);
    }catch(e){
      return ErrorResponse<String>(error: LocalException(message: 'Failed to Retrieve token'));
    }
  }
}