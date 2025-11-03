import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/features/auth/register/presentation/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterStates());
}
