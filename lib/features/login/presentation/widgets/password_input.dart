import 'package:bloc_login/core/utils/validators.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().setPassword(password),
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: isValidPassword(state.password),
          ),
        );
      },
    );
  }
}
