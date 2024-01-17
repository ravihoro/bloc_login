import 'package:bloc_login/app_view.dart';
import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bloc login',
      home: BlocProvider<AuthenticationCubit>(
        create: (_) => sl<AuthenticationCubit>(),
        child: AppView(),
      ),
    );
  }
}
