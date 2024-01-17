import 'package:bloc_login/features/login/presentation/widgets/email_input.dart';
import 'package:bloc_login/features/login/presentation/widgets/login_button.dart';
import 'package:bloc_login/features/login/presentation/widgets/password_input.dart';
import 'package:bloc_login/features/login/presentation/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EmailInput(),
        const SizedBox(
          height: 8.0,
        ),
        PasswordInput(),
        const SizedBox(
          height: 8.0,
        ),
        LoginButton(),
        const SizedBox(
          height: 8.0,
        ),
        SignUpButton(),
      ],
    );
  }
}
