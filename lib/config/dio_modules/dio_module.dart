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
  Dio get dio => Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
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
  Future<HiveInterface> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());

    await Hive.openBox<UserModel>(CacheConstants.userBoxKey);
    await Hive.openBox<String>(CacheConstants.tokenBoxName);

    return Hive;
  }

  @singleton
  Box<UserModel> userBox(HiveInterface hive) {
    return Hive.box<UserModel>(CacheConstants.userBoxKey);
  }

  @singleton
  Box<String> tokenBox(HiveInterface hive) {
    return Hive.box<String>(CacheConstants.tokenBoxName);
  }
}
