import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isValid != current.isValid,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_login_elevatedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text('Login'),
          onPressed: state.isValid == null || !state.isValid!
              ? null
              : () {
                  context.read<AuthenticationCubit>().login(
                        email: context.read<LoginCubit>().state.email!,
                        password: context.read<LoginCubit>().state.password!,
                      );
                },
        );
      },
    );
  }
}
