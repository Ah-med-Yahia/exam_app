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
import '../dio_module/dio_module.dart' as _i773;

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
    await gh.singletonAsync<_i979.Box<String>>(
      () => hiveModule.tokenBox,
      preResolve: true,
    );
    gh.factory<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i129.ForgetPasswordLocalDataSource>(
      () => _i377.ForgetPasswordLocalDataSourceImpl(
        tokenBox: gh<_i979.Box<String>>(),
      ),
    );
    gh.factory<_i950.ForgetPasswordRemoteDataSource>(
      () => _i163.ForgetPasswordRemoteDataSourceImpl(
        forgetPasswordApiClient: gh<_i478.ForgetPasswordApiClient>(),
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
    return this;
  }
}

class _$DioModule extends _i773.DioModule {}

class _$SharedPrefModule extends _i773.SharedPrefModule {}

class _$HiveModule extends _i773.HiveModule {}
