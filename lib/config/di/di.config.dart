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
import '../../features/auth/sign_up/api/api_client/api_client.dart' as _i413;
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
import '../../features/home/presentation/views/screens/tabs/explore_tab/api/api_client/explore_tab_api_client.dart'
    as _i439;
import '../../features/home/presentation/views/screens/tabs/explore_tab/api/datasources/explore_tab_local_data_source_impl.dart'
    as _i875;
import '../../features/home/presentation/views/screens/tabs/explore_tab/api/datasources/explore_tab_remote_data_source_impl.dart'
    as _i271;
import '../../features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_local_data_source.dart'
    as _i656;
import '../../features/home/presentation/views/screens/tabs/explore_tab/data/datasources/explore_tab_remote_data_source.dart'
    as _i508;
import '../../features/home/presentation/views/screens/tabs/explore_tab/data/repositories/explore_tab_repository_impl.dart'
    as _i393;
import '../../features/home/presentation/views/screens/tabs/explore_tab/domain/repositories/explore_tab_repository.dart'
    as _i762;
import '../../features/home/presentation/views/screens/tabs/explore_tab/domain/use_cases/get_all_subjects_use_case.dart'
    as _i120;
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
    await gh.singletonAsync<_i744.Box<_i89.UserModel>>(
      () => hiveModule.userBox,
      preResolve: true,
    );
    await gh.singletonAsync<_i744.Box<String>>(
      () => hiveModule.tokenBox,
      preResolve: true,
    );
    gh.singleton<_i413.SignUpApiClient>(
      () => _i413.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i439.ExploreTabApiClient>(
      () => _i439.ExploreTabApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i508.ExploreTabRemoteDataSource>(
      () => _i271.ExploreTabRemoteDataSourceImpl(
        exploreTabApiClient: gh<_i439.ExploreTabApiClient>(),
      ),
    );
    gh.factory<_i656.ExploreTabLocalDataSource>(
      () => _i875.ExploreTabLocalDataSourceImpl(
        tokenBox: gh<_i979.Box<String>>(),
      ),
    );
    gh.singleton<_i885.SignUpLocalDataSourceContract>(
      () => _i138.SignUpLocalDataSourceImpl(
        gh<_i979.Box<_i89.UserModel>>(),
        gh<_i979.Box<String>>(),
      ),
    );
    gh.factory<_i762.ExploreTabRepository>(
      () => _i393.ExploreTabRepositoryImpl(
        exploreTabRemoteDataSource: gh<_i508.ExploreTabRemoteDataSource>(),
        exploreTabLocalDataSource: gh<_i656.ExploreTabLocalDataSource>(),
      ),
    );
    gh.factory<_i129.ForgetPasswordLocalDataSource>(
      () => _i377.ForgetPasswordLocalDataSourceImpl(
        tokenBox: gh<_i979.Box<String>>(),
      ),
    );
    gh.singleton<_i645.SignUpRemoteDataSourceContract>(
      () => _i522.SignUpRemoteDataSourceImpl(
        apiClient: gh<_i413.SignUpApiClient>(),
      ),
    );
    gh.factory<_i950.ForgetPasswordRemoteDataSource>(
      () => _i163.ForgetPasswordRemoteDataSourceImpl(
        forgetPasswordApiClient: gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i120.GetAllSubjectsUseCase>(
      () => _i120.GetAllSubjectsUseCase(
        exploreTabRepository: gh<_i762.ExploreTabRepository>(),
      ),
    );
    gh.singleton<_i100.SignUpRepositoryContract>(
      () => _i442.SignUpRepositoryImpl(
        remoteDataSource: gh<_i645.SignUpRemoteDataSourceContract>(),
        localDataSource: gh<_i885.SignUpLocalDataSourceContract>(),
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
    gh.factory<_i231.ForgetPasswordCubit>(
      () => _i231.ForgetPasswordCubit(
        gh<_i913.ForgetPasswordUseCase>(),
        gh<_i22.ResetPasswordUseCase>(),
        gh<_i295.VerifyResetCodeUseCase>(),
      ),
    );
    gh.singleton<_i45.SignUpUseCase>(
      () =>
          _i45.SignUpUseCase(repository: gh<_i100.SignUpRepositoryContract>()),
    );
    gh.singleton<_i809.SignUpCubit>(
      () => _i809.SignUpCubit(gh<_i45.SignUpUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i365.DioModule {}

class _$SharedPrefModule extends _i365.SharedPrefModule {}

class _$HiveModule extends _i365.HiveModule {}
