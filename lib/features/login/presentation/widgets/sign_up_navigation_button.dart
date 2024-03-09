import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpNavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: ValueKey("sign_up_navigation_key"),
      child: Text('Sign Up'),
      onPressed: () {
        context.read<AuthenticationCubit>().setIsLoginPage(false);
      },
    );
  }
}
