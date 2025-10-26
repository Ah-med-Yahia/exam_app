import 'package:exam_app/core/resources/color_managar.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
   const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: ColorManager.blue),
    );
  }
}
