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
import 'package:injectable/injectable.dart' as _i526;

import '../../features/Auth/login/api/api_client/login_api_client.dart'
    as _i533;
import '../../features/Auth/login/api/datasources/login_remote_data_source_impl.dart'
    as _i846;
import '../../features/Auth/login/data/datasources/login_remote_data_source.dart'
    as _i81;
import '../../features/Auth/login/data/repositories/login_repository_impl.dart'
    as _i1071;
import '../../features/Auth/login/domain/repositories/login_repository.dart'
    as _i87;
import '../../features/Auth/login/domain/use_cases/login_use_case.dart'
    as _i937;
import '../../features/Auth/login/presentation/cubit/login_cubit.dart' as _i620;
import '../dio_module/dio_module.dart' as _i773;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i533.LoginApiClient>(
      () => _i533.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i81.LoginRemoteDataSource>(
      () => _i846.LoginRemoteDataSourceImpl(gh<_i533.LoginApiClient>()),
    );
    gh.factory<_i87.LoginRepository>(
      () => _i1071.LoginRepositoryImpl(gh<_i81.LoginRemoteDataSource>()),
    );
    gh.factory<_i937.LoginUseCase>(
      () => _i937.LoginUseCase(gh<_i87.LoginRepository>()),
    );
    gh.factory<_i620.LoginCubit>(
      () => _i620.LoginCubit(gh<_i937.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i773.DioModule {}
