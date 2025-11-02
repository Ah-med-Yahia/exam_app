import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/auth/forget_password/presentation/views/screens/forget_password_screen.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/login_screen.dart';
import 'package:exam_app/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:exam_app/features/auth/sign_up/presentation/views/screens/sign_up_screen.dart';
import 'package:exam_app/features/home/presentation/views/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt.get<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
