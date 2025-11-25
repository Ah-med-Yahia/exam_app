import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/login/data/models/login_request.dart';
import 'package:exam_app/features/auth/login/domain/entites/login_entity.dart';
import 'package:exam_app/features/auth/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<BaseResponse<LoginEntity>> call(LoginRequest request) =>
      loginRepository.login(request);
}
