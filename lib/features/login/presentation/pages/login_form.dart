import 'package:bloc_login/features/login/presentation/widgets/login_email_input.dart';
import 'package:bloc_login/features/login/presentation/widgets/login_button.dart';
import 'package:bloc_login/features/login/presentation/widgets/login_password_input.dart';
import 'package:bloc_login/features/login/presentation/widgets/sign_up_navigation_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginEmailInput(),
        const SizedBox(
          height: 8.0,
        ),
        LoginPasswordInput(),
        const SizedBox(
          height: 8.0,
        ),
        LoginButton(),
        const SizedBox(
          height: 8.0,
        ),
        SignUpNavigationButton(),
      ],
    );
  }
}
