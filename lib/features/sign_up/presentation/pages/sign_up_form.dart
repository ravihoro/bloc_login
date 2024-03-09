import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/widgets/login_navigation_button.dart';
import 'package:bloc_login/features/sign_up/presentation/widgets/sign_up_button.dart';
import 'package:bloc_login/features/sign_up/presentation/widgets/sign_up_email_input.dart';
import 'package:bloc_login/features/sign_up/presentation/widgets/sign_up_name_input.dart';
import 'package:bloc_login/features/sign_up/presentation/widgets/sign_up_password_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SignUpNameInput(),
      const SizedBox(
        height: 8.0,
      ),
      SignUpEmailInput(),
      const SizedBox(
        height: 8.0,
      ),
      SignUpPasswordInput(),
      const SizedBox(
        height: 8.0,
      ),
      SignUpButton(),
      const SizedBox(
        height: 8.0,
      ),
      LoginNavigationButton(),
    ]);
  }
}
