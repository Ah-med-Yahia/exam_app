import 'dart:developer';

import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/data/datasources/local/get_question_local_data_source.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetQuestionLocalDataSource)
class GetQuestionsLocalDataSourceImpl implements GetQuestionLocalDataSource {
  final Box<String> tokenBox;
  final Box<CheckAnswersResponseEntity> answersBox;
  final Box<List<String>> examesBox;
  GetQuestionsLocalDataSourceImpl(this.tokenBox, this.answersBox,this.examesBox);
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

  @override
  Future<BaseResponse<void>> cacheAnswers(
    String examId,
    CheckAnswersResponseEntity answers,
  ) async {
    try {
      await answersBox.put(examId, answers);
      await examesBox.put(
        CacheConstants.cachedExamsKey,
        [...?examesBox.get(CacheConstants.cachedExamsKey), examId],
      );
      return SuccessResponse<void>(data: null);
    } catch (e) {
      log('e cache answers local: ${e.toString()}');
      return ErrorResponse<void>(
        error: LocalException(message: 'Failed to cache answers locally'),
      );
    }
  }
}
