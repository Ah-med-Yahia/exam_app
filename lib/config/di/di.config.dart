// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/adapters.dart' as _i744;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/forget_password/api/api_client/forget_password_api_client.dart'
    as _i478;
import '../../features/auth/forget_password/api/datasources/forget_password_local_data_source_impl.dart'
    as _i377;
import '../../features/auth/forget_password/api/datasources/forget_password_remote_data_source_impl.dart'
    as _i163;
import '../../features/auth/forget_password/data/datasources/forget_password_local_data_source.dart'
    as _i129;
import '../../features/auth/forget_password/data/datasources/forget_password_remote_data_source.dart'
    as _i950;
import '../../features/auth/forget_password/data/repositories/forget_password_repository_impl.dart'
    as _i584;
import '../../features/auth/forget_password/domain/repositories/forget_password_repository.dart'
    as _i974;
import '../../features/auth/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i913;
import '../../features/auth/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i22;
import '../../features/auth/forget_password/domain/use_cases/verify_reset_code_use_case.dart'
    as _i295;
import '../../features/auth/forget_password/presentation/cubit/forget_password_cubit.dart'
    as _i231;
import '../../features/auth/sign_up/api/api_client/sign_up_api_client.dart'
    as _i429;
import '../../features/auth/sign_up/api/datasources/sign_up_local_data_source_impl.dart'
    as _i138;
import '../../features/auth/sign_up/api/datasources/sign_up_remote_data_source_impl.dart'
    as _i522;
import '../../features/auth/sign_up/data/datasources/sign_up_local_data_source_contract.dart'
    as _i885;
import '../../features/auth/sign_up/data/datasources/sign_up_remote_data_source_contract.dart'
    as _i645;
import '../../features/auth/sign_up/data/models/user_model.dart' as _i89;
import '../../features/auth/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i442;
import '../../features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart'
    as _i100;
import '../../features/auth/sign_up/domain/use_cases/sign_up_use_case.dart'
    as _i45;
import '../../features/auth/sign_up/presentation/cubit/sign_up_cubit.dart'
    as _i809;
import '../../features/questions/api/api_client/check_answers/check_answers_api_client.dart'
    as _i164;
import '../../features/questions/api/api_client/get_questions_api_client/questions_api_client.dart'
    as _i254;
import '../../features/questions/api/data_sources/local/get_questions_local_data_source_impl.dart'
    as _i569;
import '../../features/questions/api/data_sources/remote/check_answers_remote_data_source_impl.dart'
    as _i1053;
import '../../features/questions/api/data_sources/remote/get_questions_remote_data_sources_impl.dart'
    as _i880;
import '../../features/questions/data/datasources/local/get_question_local_data_source.dart'
    as _i582;
import '../../features/questions/data/datasources/remote/check_answers_remote_data_source.dart'
    as _i390;
import '../../features/questions/data/datasources/remote/get_question_remote_data_source.dart'
    as _i110;
import '../../features/questions/data/repositories/answers_check_repository_impl.dart'
    as _i774;
import '../../features/questions/data/repositories/get_questions_response_repository_impl.dart'
    as _i33;
import '../../features/questions/domain/repositories/answers_check_repository.dart'
    as _i168;
import '../../features/questions/domain/repositories/get_questions_repository.dart'
    as _i390;
import '../../features/questions/domain/usecases/answers_check_use_case.dart'
    as _i152;
import '../../features/questions/domain/usecases/get_questions_use_case.dart'
    as _i240;
import '../../features/questions/presentation/cubit/answer_cubit/answer_cubit.dart'
    as _i275;
import '../../features/questions/presentation/cubit/get_questions_cubit/get_questions_cubit.dart'
    as _i528;
import '../../features/result_tab/api/api_client/get_results_api_client.dart'
    as _i498;
import '../../features/result_tab/api/data_sources/get_results_local_data_source_impl.dart'
    as _i70;
import '../../features/result_tab/api/data_sources/get_results_remote_data_source_impl.dart'
    as _i826;
import '../../features/result_tab/data/data_sources/get_results_local_data_source.dart'
    as _i14;
import '../../features/result_tab/data/data_sources/get_results_remote_data_source.dart'
    as _i457;
import '../../features/result_tab/data/repositories/get_results_repository_impl.dart'
    as _i861;
import '../../features/result_tab/domain/repositories/get_results_history_repository.dart'
    as _i529;
import '../../features/result_tab/domain/usecases/get_results_history_use_case.dart'
    as _i939;
import '../dio_modules/dio_module.dart' as _i365;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final sharedPrefModule = _$SharedPrefModule();
    final hiveModule = _$HiveModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.prefs,
      preResolve: true,
    );
    await gh.singletonAsync<_i744.HiveInterface>(
      () => hiveModule.initHive(),
      preResolve: true,
    );
    gh.singleton<_i429.SignUpApiClient>(
      () => _i429.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i164.CheckAnswersApiClient>(
      () => _i164.CheckAnswersApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i254.GetQuestionsApiClient>(
      () => _i254.GetQuestionsApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i498.GetResultsApiClient>(
      () => _i498.GetResultsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i744.Box<_i89.UserModel>>(
      () => hiveModule.userBox(gh<_i744.HiveInterface>()),
    );
    gh.singleton<_i744.Box<String>>(
      () => hiveModule.tokenBox(gh<_i744.HiveInterface>()),
    );
    gh.singleton<_i645.SignUpRemoteDataSourceContract>(
      () => _i522.SignUpRemoteDataSourceImpl(
        apiClient: gh<_i429.SignUpApiClient>(),
      ),
    );
    gh.singleton<_i110.GetQuestionRemoteDataSource>(
      () => _i880.GetQuestionsRemoteDataSourcesImpl(
        apiClient: gh<_i254.GetQuestionsApiClient>(),
      ),
    );
    gh.singleton<_i14.GetResultsLocalDataSource>(
      () => _i70.GetResultsLocalDataSourceImpl(gh<_i979.Box<String>>()),
    );
    gh.singleton<_i885.SignUpLocalDataSourceContract>(
      () => _i138.SignUpLocalDataSourceImpl(
        gh<_i979.Box<_i89.UserModel>>(),
        gh<_i979.Box<String>>(),
      ),
    );
    gh.singleton<_i100.SignUpRepositoryContract>(
      () => _i442.SignUpRepositoryImpl(
        remoteDataSource: gh<_i645.SignUpRemoteDataSourceContract>(),
        localDataSource: gh<_i885.SignUpLocalDataSourceContract>(),
      ),
    );
    gh.singleton<_i582.GetQuestionLocalDataSource>(
      () => _i569.GetQuestionsLocalDataSourceImpl(gh<_i979.Box<String>>()),
    );
    gh.factory<_i129.ForgetPasswordLocalDataSource>(
      () => _i377.ForgetPasswordLocalDataSourceImpl(
        tokenBox: gh<_i979.Box<String>>(),
      ),
    );
    gh.singleton<_i390.GetQuestionsRepository>(
      () => _i33.GetQuestionsResponseRepositoryImpl(
        remoteDataSource: gh<_i110.GetQuestionRemoteDataSource>(),
        localDataSource: gh<_i582.GetQuestionLocalDataSource>(),
      ),
    );
    gh.factory<_i950.ForgetPasswordRemoteDataSource>(
      () => _i163.ForgetPasswordRemoteDataSourceImpl(
        forgetPasswordApiClient: gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.singleton<_i457.GetResultsRemoteDataSource>(
      () => _i826.GetResultsRemoteDataSourceImpl(
        apiClient: gh<_i498.GetResultsApiClient>(),
      ),
    );
    gh.singleton<_i390.CheckAnswersRemoteDataSource>(
      () => _i1053.CheckAnswersRemoteDataSourceImpl(
        apiClient: gh<_i164.CheckAnswersApiClient>(),
      ),
    );
    gh.singleton<_i240.GetQuestionsUseCase>(
      () => _i240.GetQuestionsUseCase(
        repository: gh<_i390.GetQuestionsRepository>(),
      ),
    );
    gh.singleton<_i45.SignUpUseCase>(
      () =>
          _i45.SignUpUseCase(repository: gh<_i100.SignUpRepositoryContract>()),
    );
    gh.singleton<_i529.GetResultsRepository>(
      () => _i861.GetResultsRepositoryImpl(
        remoteDataSource: gh<_i457.GetResultsRemoteDataSource>(),
        localDataSource: gh<_i14.GetResultsLocalDataSource>(),
      ),
    );
    gh.singleton<_i168.AnswersCheckRepository>(
      () => _i774.AnswersCheckRepositoryImpl(
        gh<_i390.CheckAnswersRemoteDataSource>(),
        gh<_i582.GetQuestionLocalDataSource>(),
      ),
    );
    gh.factory<_i974.ForgetPasswordRepository>(
      () => _i584.ForgetPasswordRepositoryImpl(
        remoteDataSource: gh<_i950.ForgetPasswordRemoteDataSource>(),
        localDataSource: gh<_i129.ForgetPasswordLocalDataSource>(),
      ),
    );
    gh.factory<_i913.ForgetPasswordUseCase>(
      () => _i913.ForgetPasswordUseCase(
        forgetPasswordRepository: gh<_i974.ForgetPasswordRepository>(),
      ),
    );
    gh.factory<_i22.ResetPasswordUseCase>(
      () => _i22.ResetPasswordUseCase(
        forgetPasswordRepository: gh<_i974.ForgetPasswordRepository>(),
      ),
    );
    gh.factory<_i295.VerifyResetCodeUseCase>(
      () => _i295.VerifyResetCodeUseCase(
        forgetPasswordRepository: gh<_i974.ForgetPasswordRepository>(),
      ),
    );
    gh.singleton<_i152.AnswersCheckUseCase>(
      () => _i152.AnswersCheckUseCase(
        repository: gh<_i168.AnswersCheckRepository>(),
      ),
    );
    gh.factory<_i528.GetQuestionsCubit>(
      () => _i528.GetQuestionsCubit(gh<_i240.GetQuestionsUseCase>()),
    );
    gh.factory<_i231.ForgetPasswordCubit>(
      () => _i231.ForgetPasswordCubit(
        gh<_i913.ForgetPasswordUseCase>(),
        gh<_i22.ResetPasswordUseCase>(),
        gh<_i295.VerifyResetCodeUseCase>(),
      ),
    );
    gh.singleton<_i939.GetResultsHistoryUseCase>(
      () => _i939.GetResultsHistoryUseCase(gh<_i529.GetResultsRepository>()),
    );
    gh.singleton<_i809.SignUpCubit>(
      () => _i809.SignUpCubit(gh<_i45.SignUpUseCase>()),
    );
    gh.factory<_i275.AnswerCubit>(
      () => _i275.AnswerCubit(gh<_i152.AnswersCheckUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i365.DioModule {}

class _$SharedPrefModule extends _i365.SharedPrefModule {}

class _$HiveModule extends _i365.HiveModule {}
