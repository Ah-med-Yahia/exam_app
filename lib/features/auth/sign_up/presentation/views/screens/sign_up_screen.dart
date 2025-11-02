import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/features/auth/sign_up/domain/entities/sign_up_request_entity.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_events.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = getIt<SignUpCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up Test')),
      body: BlocProvider.value(
        value: signUpCubit,
        child: BlocListener<SignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              print('🔄 Loading...');
            } else if (state is SignUpSuccess) {
              print('✅ Sign up success!');
            } else if (state is SignUpFailure) {
              print('❌ Sign up failed: ${state.error}');
            }
          },
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                signUpCubit.doIntent(SignUpEvent(SignUpRequestEntity(
                  email: 'ahmed505yahiha32@gmail.com',
                  firstName: 'Ahmed',
                  lastName: 'Yahia',
                  password: 'Ahmed#2005',
                  phone: '01091391955',
                  rePassword: 'Ahmed#2005',
                  username: 'AhmedYahia32',
                )));
              },
              child: const Text('Sign Up'),
            ),
          ),
        ),
      ),
    );
  }
}
