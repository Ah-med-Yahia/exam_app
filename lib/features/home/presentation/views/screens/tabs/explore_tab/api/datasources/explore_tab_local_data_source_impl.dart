import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ExploreTabLocalDataSource)
class ExploreTabLocalDataSourceImpl implements ExploreTabLocalDataSource{
  final Box<String> tokenBox;
  ExploreTabLocalDataSourceImpl({required this.tokenBox});
  @override
  Future<BaseResponse<String>> getToken() async{
    try{
      String? token= tokenBox.get(CacheConstants.tokenKey);
      return SuccessResponse<String>(data:token!);
    }catch(e){
      return ErrorResponse<String>(error: LocalException(message: 'Failed to Achieve token'));
    }
  }

}