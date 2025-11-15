import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
@module
abstract class DioModule {
  @singleton
  Dio get dio=>Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
}