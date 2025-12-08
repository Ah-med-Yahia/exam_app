import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/errors/exception.dart';
import 'package:exam_app/features/questions/data/datasources/local/cache_result_local_data_source.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CacheResultLocalDataSource)
class CacheResultLocalDataSourceImpl extends CacheResultLocalDataSource {
  final Box<CachedExamResultModel> cachedBox;

  CacheResultLocalDataSourceImpl(this.cachedBox);
  @override
  Future<BaseResponse<void>> cacheResult(CachedExamResultModel result) async {
    try {
      await cachedBox.add(result);
      return SuccessResponse<void>(data: null);
    } catch (e) {
      return ErrorResponse<void>(
        error: LocalException(message: 'Failed to cache result'),
      );
    }
  }
}
