import 'package:bloc_login/core/widgets/authentication_scaffold.dart';
import 'package:bloc_login/features/sign_up/presentation/pages/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationScaffold(
      text: 'Sign Up',
      child: SignUpForm(),
    );
  }
}
