import 'package:exam_app/features/result_tab/presentation/cubit/result_event.dart';
import 'package:exam_app/features/result_tab/presentation/cubit/result_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.read<ResultTabCubit>().doIntent(GetResultsHistoryEvent());

    return Scaffold(body: Column(children: [

        ],
      ));
  }
}
