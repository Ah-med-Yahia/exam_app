import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@singleton
class SignUpUseCase {
  final SignUpRepositoryContract repository;
  SignUpUseCase({required this.repository});

  Future<BaseResponse<void>> call(SignUpRequestEntity request)=> repository.signUp(request);
}