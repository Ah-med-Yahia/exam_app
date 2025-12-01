import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/data/datasources/local/get_question_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetQuestionLocalDataSource)
class GetQuestionsLocalDataSourceImpl implements GetQuestionLocalDataSource {
  final Box<String> tokenBox;
  GetQuestionsLocalDataSourceImpl(this.tokenBox);
  @override
  BaseResponse<String> getToken() {
    try {
      String? token = tokenBox.get(CacheConstants.tokenKey);
      if (token == null) {
        throw (Exception());
      } else {
        return SuccessResponse<String>(data: token);
      }
    } catch (e) {
      return ErrorResponse<String>(
        error: LocalException(message: 'Failed to get token locally'),
      );
    }
  }
}
