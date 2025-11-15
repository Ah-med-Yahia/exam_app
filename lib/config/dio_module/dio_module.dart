import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@module
abstract class DioModule {
  @singleton
  Dio get dio=>Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
}
@module
abstract class SharedPrefModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class HiveModule {
  @preResolve
  @singleton
  Future<Box<String>> get tokenBox async {
    if (!Hive.isBoxOpen(CacheConstants.tokenBoxKey)) {
      return await Hive.openBox<String>(CacheConstants.tokenBoxKey);
    }
    return Hive.box<String>(CacheConstants.tokenBoxKey);
  }
}