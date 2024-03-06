import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:bloc_login/core/widgets/authentication_scaffold.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      child: BlocProvider<LoginCubit>(
        create: (_) => sl<LoginCubit>(),
        child: AuthenticationScaffold(
          text: 'Login',
          child: LoginForm(),
        ),
      ),
    );
  }
}
