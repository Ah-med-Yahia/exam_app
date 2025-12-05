import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_adapter.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DioModule {
  @singleton
Dio get dio {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {

          final tokenBox = Hive.box<String>(CacheConstants.tokenBoxKey);
          final token = tokenBox.get(CacheConstants.tokenKey);

          if (token != null && token.isNotEmpty) {
            options.headers[CacheConstants.tokenKey] = token;
          }

        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        return handler.next(error);
      },
    ),
  );
  return dio;
}
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
  Future<Box<UserModel>> get userBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    return await Hive.openBox<UserModel>(CacheConstants.userBoxKey);
  }

  @preResolve
  @singleton
  Future<Box<String>> get tokenBox async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(CacheConstants.tokenBoxKey)) {
      return await Hive.openBox<String>(CacheConstants.tokenBoxKey);
    }
    return Hive.box<String>(CacheConstants.tokenBoxKey);
  }
}
