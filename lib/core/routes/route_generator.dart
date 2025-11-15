
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/auth/forget_password/presentation/views/screens/forget_password_screen.dart';
import 'package:exam_app/features/auth/forget_password/presentation/views/screens/reset_password_screen.dart';
import 'package:exam_app/features/auth/forget_password/presentation/views/screens/verify_reset_code_screen.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/login_screen.dart';
import 'package:exam_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:exam_app/features/home/presentation/views/screens/home_screen.dart';

import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen(),settings: settings);
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(),settings: settings);
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen(),settings: settings);
      case Routes.verifyResetCode:
        return MaterialPageRoute(builder: (_) => VerifyResetCodeScreen(),settings: settings);
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) =>ResetPasswordScreen(),settings: settings);    
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>const HomeScreen(),settings: settings);  
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
