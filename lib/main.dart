import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/routes/route_generator.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(); 
  runApp(const ExamApp());
}


class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.signUp,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}

