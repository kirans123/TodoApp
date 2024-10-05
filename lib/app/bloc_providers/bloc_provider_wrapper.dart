import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_registration/app/bloc_providers/bloc/auth_bloc.dart';
import 'package:login_and_registration/features/home/bloc/task_bloc.dart';

class BlocProviderWrapper extends StatelessWidget {
  final Widget child;

  const BlocProviderWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(create: (context) => TaskBloc()..add(LoadTasksEvent())),
      ],
      child: child,
    );
  }
}
