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
    gh.singleton<_i885.SignUpLocalDataSourceContract>(
      () => _i138.SignUpLocalDataSourceImpl(
        gh<_i979.Box<_i89.UserModel>>(),
        gh<_i979.Box<String>>(),
      ),
    );
    gh.singleton<_i645.SignUpRemoteDataSourceContract>(
      () => _i522.SignUpRemoteDataSourceImpl(
        apiClient: gh<_i413.SignUpApiClient>(),
      ),
    );
    gh.singleton<_i100.SignUpRepositoryContract>(
      () => _i442.SignUpRepositoryImpl(
        remoteDataSource: gh<_i645.SignUpRemoteDataSourceContract>(),
        localDataSource: gh<_i885.SignUpLocalDataSourceContract>(),
      ),
    );
    gh.singleton<_i45.SignUpUseCase>(
      () =>
          _i45.SignUpUseCase(repository: gh<_i100.SignUpRepositoryContract>()),
    );
    return this;
  }
}

class _$DioModule extends _i365.DioModule {}

class _$SharedPrefModule extends _i365.SharedPrefModule {}

class _$HiveModule extends _i365.HiveModule {}
