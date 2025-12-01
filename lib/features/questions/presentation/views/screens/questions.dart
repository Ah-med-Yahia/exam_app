import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    String id=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold();
  }
}