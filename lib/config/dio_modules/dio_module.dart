import 'package:dio/dio.dart';
import 'package:exam_app/core/constants/api_constants.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_adapter.dart';
import 'package:exam_app/features/auth/sign_up/data/models/user_model.dart';
import 'package:exam_app/features/questions/data/models/cached_exam_result_model/cached_exam_result_model.dart';
import 'package:exam_app/features/questions/domain/entities/check_answers_response_entity/check_answers_response_entity.dart';
import 'package:exam_app/features/questions/domain/entities/exam_entity/exam_entity.dart';
import 'package:exam_app/features/questions/domain/entities/question_entity/question_entity.dart';
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
              final tokenBox = Hive.box<String>(CacheConstants.tokenBoxName);
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
  Future<HiveInterface> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(CheckAnswersResponseEntityAdapter());
    Hive.registerAdapter(CorrectQuestionEntityAdapter());
    Hive.registerAdapter(WrongQuestionEntityAdapter());
    Hive.registerAdapter(QuestionEntityAdapter());
    Hive.registerAdapter(AnswerEntityAdapter());
    Hive.registerAdapter(KeyEntityAdapter());
    Hive.registerAdapter(ExamEntityAdapter());
    Hive.registerAdapter(CachedExamResultModelAdapter());

    await Hive.openBox<UserModel>(CacheConstants.userBoxName);
    await Hive.openBox<String>(CacheConstants.tokenBoxName);
    await Hive.openBox<CachedExamResultModel>(
      CacheConstants.cachedResultBoxName,
    );

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
  Box<CachedExamResultModel> cachedResultsBox(HiveInterface hive) {
    return Hive.box<CachedExamResultModel>(CacheConstants.cachedResultBoxName);
  }
}
