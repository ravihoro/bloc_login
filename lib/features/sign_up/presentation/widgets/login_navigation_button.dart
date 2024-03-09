import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: ValueKey("login_navigation_key"),
      child: Text('Login'),
      onPressed: () {
        context.read<AuthenticationCubit>().setIsLoginPage(true);
      },
    );
  }
}
