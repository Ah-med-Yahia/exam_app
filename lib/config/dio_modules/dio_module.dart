import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_adapter.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity.dart';
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
    Hive.registerAdapter(CheckAnswersResponseEntityAdapter());
    Hive.registerAdapter(WrongQuestionEntityAdapter());
    Hive.registerAdapter(CorrectQuestionEntityAdapter());

    await Hive.openBox<UserModel>(CacheConstants.userBoxName);
    await Hive.openBox<String>(CacheConstants.tokenBoxName);
    await Hive.openBox<CheckAnswersResponseEntity>(
      CacheConstants.answersBoxName,
    );
    await Hive.openBox<List<String>>(CacheConstants.examesBoxName);

    return Hive;
  }

  @singleton
  Box<UserModel> userBox(HiveInterface hive) {
    return Hive.box<UserModel>(CacheConstants.userBoxName);
  }

  @singleton
  Box<String> tokenBox(HiveInterface hive) {
    return Hive.box<String>(CacheConstants.tokenBoxName);
  }

  @singleton
  Box<CheckAnswersResponseEntity> answersBox(HiveInterface hive) {
    return Hive.box<CheckAnswersResponseEntity>(CacheConstants.answersBoxName);
  }

  @singleton
  Box<List<String>> examesBox(HiveInterface hive) {
    return Hive.box<List<String>>(CacheConstants.examesBoxName);
  }
}
