import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpNavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Sign Up'),
      onPressed: () {
        context.read<AuthenticationCubit>().setIsLoginPage(false);
      },
    );
  }
}
